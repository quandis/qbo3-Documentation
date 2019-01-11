using qbo.Application.Interfaces;
using qbo.Attachment;
using qbo.Attachment.FileObjects;
using qbo.Import.Configuration;
using qbo.Import.Engines;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace server.Acme.Financial
{
    /// <summary>
    /// Demonstrate importing an external data source into QBO.
    /// </summary>
    public class PublicDataImport : AbstractEngine
    {
        public PublicDataImport(ImportEngine configuration, IPerson user) : base(configuration, user)
        {
        }

        public override bool Import(IDictionary<string, object> parameters)
        {
            return ImportAsync(parameters).GetAwaiter().GetResult();
        }

        public async override Task<bool> ImportAsync(IDictionary<string, object> parameters)
        {
            // Often, the source of data is picked up by ImportFile/Watch or a user dropping a file onto the Import dashboard.
            // To keep this demo self-contained, we'll download a public spreadsheet from HUD and import that.
            if (!ImportFile.PreTransformID.HasValue)
            {
                // Point the source of data to a public URL
                ImportFile.PreTransform = new AttachmentObject(User)
                {
                    // Standard QBO installations include an Internet file object that allows reading URLs that are publically accessible.
                    FileObjectAssembly = "Internet",
                    PathURL = "https://www.huduser.gov/portal/datasets/fmr/fmr2019/FY19_4050_FMRs.xlsx"
                };
            }

            // Many files, including Excel, need to be cached locally for processing.
            // Attachment.CacheStream* methods copy a file to c:\windows\temp, and open a CacheFile over it.
            // This temp file will be deleted on dispoal, so we don't clutter c:\windows\temp.
            string scratchpad = AbstractFile.GetScratchpadFile();
            using (var stream = new qbo.Attachment.FileObjects.CacheStream(scratchpad, System.IO.FileMode.OpenOrCreate, System.IO.FileAccess.ReadWrite))
            {
                // Copy the data from the Internet to the scratchpad
                await ImportFile.PreTransform.ReadAsync(stream);

                // Prepare the stream for reading
                stream.Position = 0;

                // Set up an OldDbConnection to the Excel spreadsheet
                var sourceConnection = $"Provider=Microsoft.ACE.OLEDB.12.0;Extended Properties=\"Excel 12.0;HRD=Yes;IMEX=1\";Data Source={scratchpad}";

                // determine the connection string to the target SqlServer; in this case, we'll just used the default QBO database
                var targetConnection = ConfigurationManager.ConnectionStrings["qbo.Default"];
                using (OleDbConnection _Connection = new OleDbConnection(sourceConnection))
                {
                    // Wire a command to select data from the spreadsheet.
                    // In this case, the spreadsheet from HUD has a worksheet called 'fmr19_info'. 
                    var command = new OleDbCommand("SELECT * FROM [fmr19_info]", _Connection);
                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        SqlBulkCopy bulkCopy = new SqlBulkCopy(targetConnection.ConnectionString, SqlBulkCopyOptions.TableLock);
                        bulkCopy.DestinationTableName = "[hud].[FairMarketRentValue]";
                        bulkCopy.WriteToServer(reader);
                    }
                }

            }

            // Successful
            return true;
        }
    }
}