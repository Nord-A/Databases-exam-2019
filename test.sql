USE [master]
GO
/****** Object:  Database [DataBaseExam2019]    Script Date: 02-12-2019 14:56:24 ******/
CREATE DATABASE [DataBaseExam2019]
USE [DataBaseExam2019]
GO
/****** Object:  Table [dbo].[TCityHistory]    Script Date: 02-12-2019 15:03:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TCityHistory](
	[cZipCode] [varchar](4) NOT NULL,
	[cName] [varchar](30) NULL,
	[dValidFrom] [datetime2](2) NOT NULL,
	[dValidTo] [datetime2](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TCity]    Script Date: 02-12-2019 15:03:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TCity](
	[cZipCode] [varchar](4) NOT NULL,
	[cName] [varchar](30) NULL,
	[dValidFrom] [datetime2](2) GENERATED ALWAYS AS ROW START NOT NULL,
	[dValidTo] [datetime2](2) GENERATED ALWAYS AS ROW END NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cZipCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([dValidFrom], [dValidTo])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[TCityHistory] )
)
GO
/****** Object:  Table [dbo].[UserHistory]    Script Date: 02-12-2019 15:03:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserHistory](
	[nUserId] [int] NOT NULL,
	[cName] [varchar](255) NOT NULL,
	[cSurname] [varchar](255) NOT NULL,
	[cAddress] [varchar](100) NOT NULL,
	[cZipCode] [varchar](4) NULL,
	[cPhoneNumber] [varchar](8) NOT NULL,
	[cEmail] [varchar](320) NOT NULL,
	[nTotalPurchase] [money] NOT NULL,
	[dValidFrom] [datetime2](2) NOT NULL,
	[dValidTo] [datetime2](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TUser]    Script Date: 02-12-2019 15:03:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TUser](
	[nUserId] [int] IDENTITY(1,1) NOT NULL,
	[cName] [varchar](255) NOT NULL,
	[cSurname] [varchar](255) NOT NULL,
	[cAddress] [varchar](100) NOT NULL,
	[cZipCode] [varchar](4) NULL,
	[cPhoneNumber] [varchar](8) NOT NULL,
	[cEmail] [varchar](320) NOT NULL,
	[nTotalPurchase] [money] NOT NULL,
	[dValidFrom] [datetime2](2) GENERATED ALWAYS AS ROW START NOT NULL,
	[dValidTo] [datetime2](2) GENERATED ALWAYS AS ROW END NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([dValidFrom], [dValidTo])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[UserHistory] )
)
GO
/****** Object:  Table [dbo].[RatingHistory]    Script Date: 02-12-2019 15:03:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RatingHistory](
	[nUserId] [int] NOT NULL,
	[nProductId] [int] NOT NULL,
	[nStar] [tinyint] NOT NULL,
	[cComment] [varchar](2048) NULL,
	[dValidFrom] [datetime2](2) NOT NULL,
	[dValidTo] [datetime2](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRating]    Script Date: 02-12-2019 15:03:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRating](
	[nUserId] [int] NOT NULL,
	[nProductId] [int] NOT NULL,
	[nStar] [tinyint] NOT NULL,
	[cComment] [varchar](2048) NULL,
	[dValidFrom] [datetime2](2) GENERATED ALWAYS AS ROW START NOT NULL,
	[dValidTo] [datetime2](2) GENERATED ALWAYS AS ROW END NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nUserId] ASC,
	[nProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([dValidFrom], [dValidTo])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[RatingHistory] )
)
GO
/****** Object:  Table [dbo].[TCreditCard]    Script Date: 02-12-2019 15:03:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TCreditCard](
	[nCreditCardId] [int] IDENTITY(1,1) NOT NULL,
	[cCardNumber] [varchar](16) NOT NULL,
	[cCardHolder] [varchar](100) NOT NULL,
	[cExpiringDate] [varchar](5) NOT NULL,
	[cCCV] [varchar](4) NOT NULL,
	[nTotalPurchase] [money] NOT NULL,
	[nUserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nCreditCardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TInvoice]    Script Date: 02-12-2019 15:03:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TInvoice](
	[nInvoiceId] [int] IDENTITY(1,1) NOT NULL,
	[nTotalPrice] [money] NOT NULL,
	[nVAT] [money] NOT NULL,
	[nCreditCardId] [int] NULL,
	[nUserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[nInvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TInVoiceLine]    Script Date: 02-12-2019 15:03:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TInVoiceLine](
	[nProductId] [int] NOT NULL,
	[nInvoiceId] [int] NOT NULL,
	[nQuantity] [smallint] NOT NULL,
	[nUnitPrice] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nProductId] ASC,
	[nInvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TProduct]    Script Date: 02-12-2019 15:03:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TProduct](
	[nProductId] [int] IDENTITY(1,1) NOT NULL,
	[cName] [varchar](255) NOT NULL,
	[cDescription] [varchar](2048) NULL,
	[nUnitPrice] [money] NOT NULL,
	[nStock] [int] NOT NULL,
	[nAverageRaiting] [tinyint] NULL,
	[nMinimumStock] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TCreditCard] ADD  DEFAULT ((0)) FOR [nTotalPurchase]
GO
ALTER TABLE [dbo].[TUser] ADD  DEFAULT ((0)) FOR [nTotalPurchase]
GO
ALTER TABLE [dbo].[TCreditCard]  WITH CHECK ADD FOREIGN KEY([nUserId])
REFERENCES [dbo].[TUser] ([nUserId])
GO
ALTER TABLE [dbo].[TInvoice]  WITH CHECK ADD FOREIGN KEY([nCreditCardId])
REFERENCES [dbo].[TCreditCard] ([nCreditCardId])
GO
ALTER TABLE [dbo].[TInvoice]  WITH CHECK ADD FOREIGN KEY([nUserId])
REFERENCES [dbo].[TUser] ([nUserId])
GO
ALTER TABLE [dbo].[TInVoiceLine]  WITH CHECK ADD FOREIGN KEY([nInvoiceId])
REFERENCES [dbo].[TInvoice] ([nInvoiceId])
GO
ALTER TABLE [dbo].[TInVoiceLine]  WITH CHECK ADD FOREIGN KEY([nProductId])
REFERENCES [dbo].[TProduct] ([nProductId])
GO
ALTER TABLE [dbo].[TRating]  WITH CHECK ADD FOREIGN KEY([nProductId])
REFERENCES [dbo].[TProduct] ([nProductId])
GO
ALTER TABLE [dbo].[TRating]  WITH CHECK ADD FOREIGN KEY([nUserId])
REFERENCES [dbo].[TUser] ([nUserId])
GO
ALTER TABLE [dbo].[TUser]  WITH CHECK ADD FOREIGN KEY([cZipCode])
REFERENCES [dbo].[TCity] ([cZipCode])
GO
