Drop table InvoiceItems;
Drop table InvoiceTable ;
Drop table ItemDetail;
Drop table CustomerDetail;

CREATE TABLE CustomerDetail(
[CustomerNo] INT PRIMARY KEY NOT NULL IDENTITY,
[Name] NVARCHAR (50) NOT NULL,
[StreetAddress] NVARCHAR (50) NOT NULL,
[City] NVARCHAR (50) NOT NULL,
[State] NVARCHAR (50) NOT NULL
);

CREATE TABLE ItemDetail (
[Item_ID] INT PRIMARY KEY NOT NULL IDENTITY,
[Item_Description] NVARCHAR (50) NOT NULL,
[Item_Price] DECIMAL (15,2) NOT NULL
);

CREATE TABLE InvoiceTable (
[Invoice] INT PRIMARY KEY NOT NULL IDENTITY,
[Invoice_Date] Date NOT NULL,
[CustomerNo] INT NOT NULL,
FOREIGN KEY ([CustomerNo]) REFERENCES CustomerDetail([CustomerNo])
);


CREATE TABLE InvoiceItems(
[Invoice] INT NOT NULL,
[Item_ID] INT NOT NULL,
[Item_Quantity] INT NOT NULL,
CONSTRAINT FK_Invoice FOREIGN KEY ([Invoice]) REFERENCES InvoiceTable([Invoice]),
CONSTRAINT FK_Item_ID FOREIGN KEY ([Item_ID]) REFERENCES ItemDetail([Item_ID]),
PRIMARY KEY(Invoice, Item_ID)
);

SET IDENTITY_INSERT CustomerDetail ON

INSERT INTO CustomerDetail
	(CustomerNo, Name, StreetAddress, City, State)
VALUES
	(56, 'Foo.Inc', '23 Main St.' , 'Thorpleburg', 'TX'),
	(57, 'Van.Inc', '3299 Woodland Terrace', 'Fair Oaks', 'California'),
	(58, 'Bake.Inc', '1895 White Pine Lane', 'Winchester', 'Virginia');
SET IDENTITY_INSERT CustomerDetail OFF

SET IDENTITY_INSERT ItemDetail ON
INSERT INTO ItemDetail
	(Item_ID, Item_Description, Item_Price)
VALUES
	(563, '56" Blue Freen', 3.50),
	(652, '3" Red Freen', 12.00),
	(851, 'Spline End (Xtra Large)', 0.25);
SET IDENTITY_INSERT ItemDetail OFF


SET IDENTITY_INSERT InvoiceTable ON
INSERT INTO InvoiceTable
	(Invoice, Invoice_Date, CustomerNo)
VALUES
	(125, '2002/09/13', 56),
	(254, '2002/09/14', 57),
	(345, '2002/10/05', 58);
SET IDENTITY_INSERT InvoiceTable OFF


INSERT INTO InvoiceItems
	(Invoice, Item_ID, Item_Quantity)
VALUES
	(125, 563, 4),
	(125, 851, 32),
	(125, 652, 5),
	(254, 563, 60),
	(345, 563, 15),
	(345, 851, 160),
	(345, 652, 70);
