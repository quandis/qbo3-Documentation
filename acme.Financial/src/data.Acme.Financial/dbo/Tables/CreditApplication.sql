CREATE TABLE [dbo].[CreditApplication]
(
	[CreditApplicationID] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CreditApplication] NVARCHAR(50) NOT NULL,
	[ProcessID] INT,
	[SomeCustomField] NVARCHAR(50)
)
