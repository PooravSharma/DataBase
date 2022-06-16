CREATE TABLE [dbo].[InvoiceItems]
(
	[Invoice] INT NOT NULL,
[Item_ID] INT NOT NULL,
[Item_Quantity] INT NOT NULL,
CONSTRAINT FK_Invoice FOREIGN KEY ([Invoice]) REFERENCES InvoiceTable([Invoice]),
CONSTRAINT FK_Item_ID FOREIGN KEY ([Item_ID]) REFERENCES ItemDetail([Item_ID]),
PRIMARY KEY(Invoice, Item_ID)
)
