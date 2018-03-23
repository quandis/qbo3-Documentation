# Importing Data

QBO offers several means of importing data, including:
- Spreadsheets
- Delimited files
- XML files
- API calls

Several techniques can be used to import data, each implemented by an `IImportEngine` interface. Broadly speaking, 
the techniques boil down either _application tier_ processing vs _data tier_ processing. Data tier processing is 
faster, but application tier processing offers easier setup and features that are difficult to leverage in 
data tier processing.

## Application Tier Processing

The most flexible method of importing data is using the BatchEngine to import Excel data.

## Remote Monitoring

A typical use case is remote monitoring of a FTP site for file to import. For example:

`ImportFile.ashx/Queue/Watch?FileObject=SomeClientFtpSite&Path=/Outbound&Pattern=*.csv&TemplateID=X&Schedule=Daily at 3am`

will create a job to check the FTP site configured in SomeClientFtpSite every day at 3 am. 

When invoking the watch method, an ImportFile record will be created for each file in the target location. 

By default, the file will be copied to the 'Database' FileObject (in case SQL Server needs to read it directly), 
and the original file will be deleted from the target location.

Parameters available to this method include:
- FileObject (required): the name of the FileObject (file repository) to monitor
- Path (optional, defaults to /): the folder to monitor
- Pattern (optional, defaults to *): the naming pattern files to be imported must follow to be imported
- Depth (optional, defaults to 0): depth of child folders to parse looking for files to import
- MoveTo (optional, defaults to Database): name of the FileObject to move the file to before deleting the original
- TransferTo (optional, default to null): name of the FileObject to copy the file to; the original will be left alone
- Async (optional, defaults to true): when true, the import will be queued for async processing
- TemplateID (required): the ImportFileTemplateID to use when creating 

The sequence of execution is:

```
FileObject.List() is called to retrieve a list of files available for import
for each file:
  create an Attachment
  create an ImportFile, setting the PreTransformID to point to the new Attachment
  if a TransferTo parameter was specified, copy the file, otherwise move the file (deleting the original)
  if async, queue ImportFile.Import(), otherwise invoke ImportFile.Import
```

## Packages

Packages are QBO 3 'add-ons' that provide pre-configured functionality in QBO 3. 
Package files are simply QBO 3 compliant XML files that pre-seed data and configuration entries to rapidly set up functionality. 
For example, the `Compliance` package will install the data and configuration required to manage compliance audits for 
attorneys in the mortgage space.

- To view packages available for install, navigate to `Design > Configuration > Packages`.
- To install a packages, click on the name of the package.

### Creating packages

Developers can create packages by:
- Creating a Theme (empty ASP.NET web project)
- Adding the required XSLTs, javascript, and css files to the project
- Creating an import-framework compliant XML documents, placed in Config/Setup.{Package Name}.xml
- Deploying the project to the target QBO 3 system.

Note that custom configuration components (statements, filters, file objects, etc.) should be part of the Setup XML file, 
so they are stored in the `ConfigurationEntry` table instead of 'polluting' the core configuration files.

See `Source > Theme.Compliance.csproj` for an example package.

## Bulk Applying a Method Signature 

The import module's ImportFile class includes an Apply method that supports applying a method signature to all rows returned by a query. Examples include:

```
// Add a message to all Contacts with a Beverly Hills zip code
Apply.ashx/Contact/Search?PostalCode=90210&Signature=Message/Save?Object=Contact%26&ObjectID={ContactID}&Subject=Welcome to the Jungle, {FirstName}
- or - 
ImportFile.ashx/Apply?ClassName=Contact&Operation=Search&PostalCode=90210&Signature=Message/Save?Object=Contact%26&ObjectID={ContactID}&Subject=Welcome to the Jungle, {FirstName}

// Launch a workflow for Loans with a UPB of more than $1M
Apply.ashx/Loan/Search?UPBAmount>=1000000&Signature=Decision/Save?Object=Contact%26&ObjectID={LoanID}&Template=High Risk Loan Analysis
- or -
ImportFile.ashx/Apply?ClassName=Loan&Operation=Search&UPBAmount>=1000000&Signature=Decision/Save?Object=Contact%26&ObjectID={LoanID}&Template=High Risk Loan Analysis
```

Notes:
- The Signature often needs to include ampersands (&): the HTML escape sequence for this is %26
- Javascript can field this easily: escape('Decision/Save?Object=Loan&ObjectID={LoanID}')

## Import File Status

The Import module's commonly used status values include:
- Awaiting Import: set upon calling ImportFile/Import
- Awaiting Validation: set upon calling ImportFile/Validate.
- Stored: set upon calling ImportFile/Create when the template is not set to Async
ImportFile/Create is called by dragging-and-dropping files on the Import File dashboard, or by calling ImportFile/Watch
- Error: set when an error occurred during many of the import method signatures
- Validation Error: set when validation failed after calling ImportFile/Import, when the template has a validator defined
- Complete: set when the import is complete
for async engines like the Batch Engine, this is handled by a callback, and may take minutes or hours.
- Pending: set by ImportFile/Import when the underlying engine does not complete its work
for example, the Batch Engine will queue an ImportFileQueue/Process method signature for each row imported
- Ending:  set by ImportFile/EndImport, while any workflows are launched at the end of the import process
- Queued: set when the import is waiting to be processed by Queueing
- Validated: set when ImportFile/Validate successfully validates the data being imported
- Validation Failed: set when ImportFile/Validate fails to validate the data being imported
