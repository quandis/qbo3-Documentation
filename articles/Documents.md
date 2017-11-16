# Documents

The QBO Document module provides the ability to generate, deliver, store, and manage documents.

Document Management includes document imaging. Documents can be uploaded to QBO by:

* Dragging and dropping one or more documents onto a Documents panel
* Monitor an FTP site (or other repository) on a schedule, importing matching documents
* Push via web service

Documents can be categorized many ways:

* Parent: most Summary pages in QBO contain a Documents panel
  * e.g. if you upload documents on the summary page for Loan 12345, the documents’ parent is Loan 12345
  * e.g. if you upload documents on the summary page for Foreclosure 23456, the documents’ parent is Loan 23456
  * e.g. if you upload documents on the summary page for Organization “Quandis”, the documents’ parent is Organization “Quandis”
* Type: as with all QBO objects, documents may be assigned a type, where the possible list of types is defined by power users
* Status: as with all QBO objects, documents may be assigned a status, where the possible statuses is defined by power users
* Template: documents may be assigned to a template, and permissions may be granted based on template

## Mail Merge

Documents can be created by QBO via mail merge, using several technologies, including:

* Microsoft Word (saved as Word, PDF or RTF)
* Adobe PDF (with form fields) (saved as PDF)
* HTML (saved as PDF)

Power users can create new document templates, choose their mail merge engine, and upload the document template (usually a .docx or .pdf) they wish to use. Any data available in the QBO database may be used as merge fields.

When a document is created based on a document template, it can be saved to any document storage location configured in the system. This means you can have QBO produce documents on the QBO servers, and seamlessly deliver them to your FTP site, Amazon S3, Microsoft Azure, etc.

## OCR and Classification

QBO includes an interface for Optical Character Recognition (OCR), which will extract text from common document formats 
(including Word, PDF, TIFF, JPEG, and more), making the text searchable. Rather than invent our own technology, 
we leverage third party software that excels at OCR; our default plugin leverages Google’s OCR engine. 
If you have an existing OCR provider that provides an API, Quandis’ Document module can leverage a plugin to use it instead of Google.

Once the text of a document is available in the QBO database, power users can extract data from the text using a simple 
*Text Parsing* plugin. Examples of values that can be extracted include:

* Money: extract a loan amount from a text pattern like:
“I promise to pay U.S. ${Value} (this amount is called ‘Principle’)”

* Percentages: extract an interest rate from a text pattern like:
“I will pay interest at a yearly rate of {Value}%.”
* Dates: extract dates from a text pattern like:
“Payments start on {Value}, with late charges starting”

* Strings: extract names from a text pattern like:
“Mortgage is issued to {Value}, known as the mortgagor.”

Next, documents can be classified with the combination of OCR, the text parsing engine, and a set of rules (matrix) 
to set the document type, template, status, or other values. For example, in the image below, a simple text parsing 
model looks for text specific to loan modifications, subprime mortgage, and mortgage notes, and then leverages a 
weighted rule set to determine the document type.

This enables you to purchase a portfolio of loans, drop the collateral documents into QBO, and having a workflow OCR, 
parses, and classify each document received. Processors would be assigned to review only documents classified as ‘unknown’, 
instead of putting eyeballs on each and every document, and loans missing key documents can automatically be flagged for follow-up.

## Mailing Documents

The Document Management module can be used to seamlessly deliver documents to a print-and-mail vendor. 
Data points per document include:

* Outbound tracking number
* Outbound due date
* Outbound received date
* Return receipt tracking number
* Return due date
* Return received date

Assuming the print-and-mail vendor is capable of returning this data, QBO will display it and allow for reporting 
(including exception reporting) on this data.

The Document Management module can also generate a USPS certified mailing number prior to a mail merge, 
so you can use the certified mailing number as part of the merge data. This allows legal documents to inject the 
certified mailing number anywhere in the document, without the need to coordinate “exact print coordinates” with a mailing vendor. 
This enables your power users to manage document template changes in minutes, instead of weeks.

## Storage

The Document Management module supports the use of many types of document storage (“repositories”). This includes:

* Storage Area Networks (SAN)
* FTP (including sFTP)
* Amazon Simple Storage Service (S3)
* Microsoft Azure
* Google Drive
* Local file storage
* SourceCorp
* FileNET

Any given QBO system can have multiple repositories configured, and workflow or scheduled jobs can move documents 
between these repositories. Integration with Amazon S3 and Microsoft Azure provides cheap unlimited storage.

Common use cases include:

* Monitor a client sFTP site for data files to import
* Deliver newly generated documents to a print vendor’s sFTP site
* Store terabytes of photos in Amazon S3
* Other Features

## Printing

The Document Management module also includes the ability to queue documents for bulk printing on your printers. 
Instead of asking users to download and print documents, QBO servers can push documents directly to your printers 
via Google Cloud Print, or via third-party print vendors such as Printer On.

## Virus Scanning

Quandis integrates with Scanii to provide virus scanning of uploaded documents
