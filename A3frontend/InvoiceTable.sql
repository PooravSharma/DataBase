CREATE TABLE [dbo].[InvoiceTable]
(
	[Invoice] INT PRIMARY KEY NOT NULL IDENTITY,
[Invoice_Date] Date NOT NULL,
[CustomerNo] INT NOT NULL,
FOREIGN KEY ([CustomerNo]) REFERENCES CustomerDetail([CustomerNo])
)
