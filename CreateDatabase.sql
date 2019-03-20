--Schema
CREATE SCHEMA dbo;
CREATE SCHEMA saleslt;

--Tables
CREATE TABLE "dbo.BuildVersion"
(SystemInformationID serial PRIMARY key,
DatabaseVersion varchar(25) not null,
VersionDate TIMESTAMP not null,
ModifiedDate TIMESTAMP not null);

CREATE TABLE dbo.ErrorLog
(ErrorLogID serial PRIMARY KEY,
ErrorTime TIMESTAMP not null,
UserName VARCHAR(50) NOT NULL,
ErrorNumber INTEGER NOT NULL,
ErrorSeverity INTEGER NOT NULL,
ErrorState INTEGER NULL,
ErrorProcedure VARCHAR(126) NULL,
ErrorLine INTEGER NULL,
ErrorMessage VARCHAR(4000) NOT NULL);

CREATE TABLE saleslt.Address(
	AddressID SERIAL PRIMARY KEY,
	AddressLine1 varchar(60) NOT NULL,
	AddressLine2 varchar(60) NULL,
	City varchar(30) NOT NULL,
	StateProvince varchar(50) NOT NULL,
	CountryRegion varchar(50) NOT NULL,
	PostalCode varchar(15) NOT NULL,
	rowguid char(16) NOT NULL,
	ModifiedDate TIMESTAMP NOT NULL
);

CREATE TABLE saleslt.Customer(
	CustomerID SERIAL PRIMARY KEY,
	NameStyle VARCHAR(50) NOT NULL,
	Title varchar(8) NULL,
	FirstName varchar(50) NOT NULL,
	MiddleName VARCHAR(50) NULL,
	LastName VARCHAR(50) NOT NULL,
	Suffix varchar(10) NULL,
	CompanyName varchar(128) NULL,
	SalesPerson varchar(256) NULL,
	EmailAddress varchar(50) NULL,
	Phone VARCHAR(50) NULL,
	PasswordHash varchar(128) NOT NULL,
	PasswordSalt varchar(10) NOT NULL,
	rowguid char(16) NOT NULL,
	ModifiedDate TIMESTAMP NOT NULL
);

CREATE TABLE saleslt.CustomerAddress(
	CustomerID int NOT NULL,
	AddressID int NOT NULL,
	AddressType varchar(50) NOT NULL,
	rowguid char(50) NOT NULL,
	ModifiedDate TIMESTAMP NOT NULL
)

CREATE TABLE saleslt.Product(
	ProductID SERIAL PRIMARY KEY,
	Name varchar(50) NOT NULL,
	ProductNumber varchar(25) NOT NULL,
	Color varchar(15) NULL,
	StandardCost money NOT NULL,
	ListPrice money NOT NULL,
	Size varchar(5) NULL,
	Weight decimal(8, 2) NULL,
	ProductCategoryID int NULL,
	ProductModelID int NULL,
	SellStartDate timestamp NOT NULL,
	SellEndDate timestamp NULL,
	DiscontinuedDate timestamp NULL,
	ThumbNailPhoto bytea NULL,
	ThumbnailPhotoFileName varchar(50) NULL,
	rowguid char(16) NOT NULL,
	ModifiedDate timestamp NOT NULL
);

CREATE TABLE saleslt.ProductCategory(
	ProductCategoryID SERIAL PRIMARY KEY,
	ParentProductCategoryID int NULL,
	Name varchar(50) NOT NULL,
	rowguid char(16) NOT NULL,
	ModifiedDate TIMESTAMP NOT NULL
);

CREATE TABLE saleslt.ProductDescription(
	ProductDescriptionID SERIAL PRIMARY KEY,
	Description varchar(400) NOT NULL,
	rowguid char(16) NOT NULL,
	ModifiedDate TIMESTAMP NOT NULL
);

CREATE TABLE saleslt.ProductModel(
	ProductModelID SERIAL PRIMARY KEY,
	Name varchar(50) NOT NULL,
	CatalogDescription xml NULL,
	rowguid char(16) NOT NULL,
	ModifiedDate TIMESTAMP NOT NULL
);

CREATE TABLE saleslt.ProductModelProductDescription(
	ProductModelID int NOT NULL,
	ProductDescriptionID int NOT NULL,
	Culture char(6) NOT NULL,
	rowguid char(16) NOT NULL,
	ModifiedDate TIMESTAMP NOT NULL
);

CREATE TABLE saleslt.SalesOrderDetail(
	SalesOrderID int NOT NULL,
	SalesOrderDetailID SERIAL NOT NULL,
	OrderQty smallint NOT NULL,
	ProductID int NOT NULL,
	UnitPrice money NOT NULL,
	UnitPriceDiscount money NOT NULL,
	LineTotal money,
	rowguid char(16) NOT NULL,
	ModifiedDate TIMESTAMP NOT NULL
);



CREATE TABLE saleslt.SalesOrderHeader(
	SalesOrderID SERIAL PRIMARY KEY,
	RevisionNumber smallint NOT NULL,
	OrderDate timestamp NOT NULL,
	DueDate timestamp NOT NULL,
	ShipDate timestamp NULL,
	Status smallint NOT NULL,
	OnlineOrderFlag BOOLEAN NOT NULL,
	SalesOrderNumber  VARCHAR(23),
	PurchaseOrderNumber VARCHAR(50) NULL,
	AccountNumber VARCHAR(50) NULL,
	CustomerID int NOT NULL,
	ShipToAddressID int NULL,
	BillToAddressID int NULL,
	ShipMethod varchar(50) NOT NULL,
	CreditCardApprovalCode varchar(15) NULL,
	SubTotal money NOT NULL,
	TaxAmt money NOT NULL,
	Freight money NOT NULL,
	TotalDue  money,
	Comment TEXT NULL,
	rowguid char(16) NOT NULL,
	ModifiedDate timestamp NOT NULL
);

ALTER TABLE saleslt.CustomerAddress 
ADD CONSTRAINT CustomerAddressAddress FOREIGN KEY (AddressID) REFERENCES saleslt.Customer (CustomerID);

ALTER TABLE saleslt.Product 
ADD CONSTRAINT ProductProductCategory FOREIGN KEY (ProductCategoryID) REFERENCES saleslt.ProductCategory (ProductCategoryID);

ALTER TABLE saleslt.Product 
ADD CONSTRAINT ProductProductModel FOREIGN KEY (ProductModelID) REFERENCES saleslt.ProductModel (ProductModelID);

ALTER TABLE saleslt.ProductCategory
ADD CONSTRAINT ProductCategoryProductCategory FOREIGN KEY (ParentProductCategoryID) REFERENCES saleslt.ProductCategory (ProductCategoryID);

ALTER TABLE saleslt.ProductModelProductDescription
ADD CONSTRAINT ProductModelProductDescription FOREIGN KEY (ProductDescriptionID) REFERENCES saleslt.ProductDescription (ProductDescriptionID);

ALTER TABLE saleslt.ProductModelProductDescription
ADD CONSTRAINT ProductModelProductModel FOREIGN KEY (ProductModelID) REFERENCES saleslt.ProductModel (ProductModelID);

ALTER TABLE saleslt.SalesOrderDetail
ADD CONSTRAINT SalesOrderDetailProduct FOREIGN KEY (ProductID) references saleslt.Product (ProductID);


ALTER TABLE saleslt.SalesOrderDetail
ADD CONSTRAINT SalesOrderDetailSalesOrderHeader FOREIGN KEY (SalesOrderID) references saleslt.SalesOrderHeader (SalesOrderID);
