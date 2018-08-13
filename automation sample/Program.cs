using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace qbo.Sample
{
	class Program
	{
		static void Main(string[] args)
		{
			Console.Write("Enter Module (e.g. Application or Decision): ");
			string module = Console.ReadLine();
			Console.Write("Enter Class (e.g. Matrix, SmartWorklist, Attachment): ");
			string className = Console.ReadLine();
			Console.Write("Enter Method (e.g. Summary, Generate, Lookup): ");
			string method = Console.ReadLine();
			Console.Write("Parameters (e.g. ID=1&OtherParam=ABC): ");
			string parameters = Console.ReadLine();

			string url = string.Format("{0}{1}/{2}.ashx/{3}?{4}&Output={5}", Properties.Settings.Default.BaseUrl, module, className, method, parameters, Properties.Settings.Default.Output);
			string outputFile = string.Format("{0}/{1}.{2}", Properties.Settings.Default.OutputPath, Guid.NewGuid(), Properties.Settings.Default.Output);

			WebRequest request = WebRequest.Create(url);
			CredentialCache cache = new CredentialCache();
			cache.Add(new Uri(Properties.Settings.Default.BaseUrl), "Basic", new NetworkCredential(Properties.Settings.Default.Username, Properties.Settings.Default.Password));
			request.Credentials = cache;
			request.PreAuthenticate = true;
			using (WebResponse response = request.GetResponse())
			{
				using (Stream from = response.GetResponseStream())
				{
					int BUFFER_SIZE = 4096;
					Byte[] buffer = new Byte[BUFFER_SIZE];
					int bytesRead = from.Read(buffer, 0, BUFFER_SIZE);

					using (FileStream file = new FileStream(outputFile, FileMode.OpenOrCreate))
					{
						while (bytesRead > 0)
						{
							file.Write(buffer, 0, bytesRead);
							// Console.Write(Encoding.Default.GetString(buffer));
							bytesRead = from.Read(buffer, 0, BUFFER_SIZE);
						}
					}

				}
			}
			Console.WriteLine(string.Format("\nURL: {0}", url));
			Console.WriteLine(string.Format("Output file: {0}", outputFile));
			Console.WriteLine("\n\nPress enter to exit");
			Console.ReadLine();
		}
	}
}
