--Create Database TheBestDataBaseInThisCentury

Create Table TCity
(
cZipCode varchar(4) Primary Key,
cName varchar(30),
dValidFrom DATETIME2 (2) GENERATED ALWAYS AS ROW START,
dValidTo DATETIME2 (2) GENERATED ALWAYS AS ROW END,
PERIOD FOR SYSTEM_TIME (dValidFrom, dValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.TCityHistory));

Create Table TUser
(
nUserId int IDENTITY Primary key,
cName varchar(255) not null,
cSurname varchar(255) not null,
cAddress varchar(100) not null,
cZipCode varchar(4) FOREIGN KEY REFERENCES TCity(cZipCode),
cPhoneNumber varchar(8) not null,
cEmail varchar(320) not null,
nTotalPurchase money not NULL DEFAULT 0,
dValidFrom DATETIME2 (2) GENERATED ALWAYS AS ROW START,
dValidTo DATETIME2 (2) GENERATED ALWAYS AS ROW END,
PERIOD FOR SYSTEM_TIME (dValidFrom, dValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.UserHistory));

Create Table TCreditCard
(
nCreditCardId int IDENTITY Primary key,
cCardNumber varchar(16) not null,
cCardHolder varchar(100) not null,
cExpiringDate varchar(5) not null,
cCCV varchar(4) not null,
nTotalPurchase money not NULL DEFAULT 0,
nUserId int FOREIGN KEY REFERENCES TUser(nUserId)
)

Create Table TInvoice
(
nInvoiceId int IDENTITY Primary key,
nTotalPrice money not null,
nVAT money not null,
nCreditCardId int FOREIGN KEY REFERENCES TCreditCard(nCreditCardId),
nUserId INT FOREIGN KEY REFERENCES dbo.TUser(nUserId)
)

Create Table TProduct
(
nProductId int IDENTITY Primary key,
cName varchar(255) not null,
cDescription varchar(2048),
nUnitPrice money not null,
nStock int not null,
nAverageRaiting tinyint
)

Create Table TInVoiceLine
(
nProductId int FOREIGN KEY REFERENCES TProduct(nProductId),
nInvoiceId int FOREIGN KEY REFERENCES TInvoice(nInvoiceId),
nQuantity smallint not null,
nUnitPrice money not null,
primary key (nProductId, nInvoiceId)
)

Create Table TRating
(
nUserId int FOREIGN KEY REFERENCES TUser(nUserId),
nProductId int FOREIGN KEY REFERENCES TProduct(nProductId),
nStar tinyint not null,
cComment varchar(2048),
primary key (nUserId, nProductId),
dValidFrom DATETIME2 (2) GENERATED ALWAYS AS ROW START,
dValidTo DATETIME2 (2) GENERATED ALWAYS AS ROW END,
PERIOD FOR SYSTEM_TIME (dValidFrom, dValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.RatingHistory));

ALTER TABLE TProduct
ADD nMinimumStock int not null;
                              
ALTER TABLE TCreditCard
ALTER COLUMN nUserId int NOT NULL;
