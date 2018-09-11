/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/


-- Need to create the FK to the QBO Process table manually, unless we include a reference to the raw qbo.Standard.sqlproj file.
-- Sadly, one cannot create a Nuget package from a .sqlproj file yet.
-- See https://github.com/NuGet/Home/issues/545

IF NOT EXISTS (
	SELECT	OBJECT_NAME(constraint_object_id)
	FROM	sys.foreign_key_columns as fk
	WHERE	Object_Name(constraint_object_id) = 'FK_CreditApplication_Process'
		AND OBJECT_NAME(parent_object_id) = 'CreditApplication'
		AND	OBJECT_NAME(referenced_object_id) = 'Process'
) 
BEGIN
	ALTER TABLE dbo.CreditApplication
	ADD CONSTRAINT FK_CreditApplication_Process FOREIGN KEY (ProcessID)
		REFERENCES dbo.Process (ProcessID);  

END