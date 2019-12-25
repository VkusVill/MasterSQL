CREATE TABLE [dbo].[coupon_type_3] (
  [Number] [nvarchar](50) NOT NULL,
  [Phone] [nchar](10) NOT NULL,
  [Имя] [nchar](30) NULL,
  [ShopNo] [int] NULL,
  [Dateactivation] [date] NOT NULL,
  [type_rassilka] [varchar](3) NOT NULL,
  [type_coupon] [int] NOT NULL,
  [id_type_coupon] [uniqueidentifier] NOT NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_coupon_type_3_date_add] DEFAULT (getdate()),
  [date_finish_coupon] [date] NOT NULL
)
ON [PRIMARY]
GO