DROP DATABASE IF EXISTS Invoice;
CREATE DATABASE Invoice;

USE Invoice;

CREATE TABLE CustomerDetail(
CustomerNo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
Name VARCHAR (50) NOT NULL,
StreetAddress VARCHAR (50) NOT NULL,
City VARCHAR (50) NOT NULL,
State VARCHAR (50) NOT NULL
);

CREATE TABLE ItemDetail (
Item_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
Item_Description VARCHAR (50) NOT NULL,
Item_Price DECIMAL (15,2) NOT NULL
);

CREATE TABLE InvoiceTable (
Invoice INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
Invoice_Date Date NOT NULL,
CustomerNo INT NOT NULL,
FOREIGN KEY (CustomerNo) REFERENCES CustomerDetail(CustomerNo)
);


CREATE TABLE InvoiceItems(
Invoice INT NOT NULL,
Item_ID INT NOT NULL,
Item_Quantity INT NOT NULL,
CONSTRAINT FK_Invoice FOREIGN KEY (Invoice) REFERENCES InvoiceTable(Invoice),
CONSTRAINT FK_Item_ID FOREIGN KEY (Item_ID) REFERENCES ItemDetail(Item_ID),
PRIMARY KEY(Invoice, Item_ID)
);

INSERT INTO CustomerDetail
	(CustomerNo, Name, StreetAddress, City, State)
VALUES
	(56, 'Foo.Inc', '23 Main St.' , 'Thorpleburg', 'TX'),
	(57, 'Van.Inc', '3299 Woodland Terrace', 'Fair Oaks', 'California'),
	(58, 'Bake.Inc', '1895 White Pine Lane', 'Winchester', 'Virginia');


INSERT INTO ItemDetail
	(Item_ID, Item_Description, Item_Price)
VALUES
	(563, '56" Blue Freen', 3.50),
	(652, '3" Red Freen', 12.00),
	(851, "Spline End (Xtra Large)", 0.25);

INSERT INTO InvoiceTable
	(Invoice, Invoice_Date, CustomerNo)
VALUES
	(125, "2002/09/13/", 56),
	(254, "2002/09/14", 57),
	(345, "2002/10/05", 58);

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



