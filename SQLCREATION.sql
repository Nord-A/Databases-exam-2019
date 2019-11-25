--Create Database TheBestDataBaseInThisCentury

Create Table TCity
(
cZipCode varchar(4) Primary Key,
cName varchar(30)
)

Create Table TUser
(
nUserId int Primary key,
cName varchar(255) not null,
cSurname varchar(255) not null,
cAddress varchar(100) not null,
cPhoneNumber varchar(8) not null,
cEmail varchar(320) not null,
nTotalPurchase money not null,
cZipCode varchar(4) FOREIGN KEY REFERENCES TCity(cZipCode)
);

Create Table TCreditCard
(
nCreditCardId int Primary key,
cCardNumber varchar(16) not null,
cCardHolder varchar(100) not null,
cExpiringDate varchar(5) not null,
cCCV varchar(4) not null,
nTotalPurchase money not null,
nUserId int FOREIGN KEY REFERENCES TUser(nUserId)
)

Create Table TInvoice
(
nInvoiceId int Primary key,
nTotalPrice money not null,
nVAT money not null,
nCreditCardId int FOREIGN KEY REFERENCES TCreditCard(nCreditCardId)
)

Create Table TProduct
(
nProductId int Primary key,
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

Create Table TRaiting
(
nUserId int FOREIGN KEY REFERENCES TUser(nUserId),
nProductId int FOREIGN KEY REFERENCES TProduct(nProductId),
nStar tinyint not null,
cComment varchar(2048),
primary key (nUserId, nProductId)
)