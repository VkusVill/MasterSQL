CREATE TABLE [dbo].[arc_Cards] (
  [number] [nchar](7) NOT NULL,
  [FullName] [nvarchar](255) NULL,
  [Bonus_ost] [real] NULL,
  [Sales_ost] [real] NULL,
  [SumSales2] [int] NULL,
  [last_date_VV] [datetime] NULL,
  [Sum_discount] [real] NULL,
  [nvaCardNum_2] [nchar](7) NULL,
  [Balance2] [int] NULL,
  [coupon_text] [nchar](50) NULL,
  [last_date_coupon] [datetime] NULL,
  [date_ins] [datetime] NULL CONSTRAINT [DF_Cards_date_ins] DEFAULT (getdate()),
  [phone_card] [bigint] NULL,
  [telegram_id] [int] NULL,
  [DateLP_to] [date] NULL,
  [id_bot] [int] NULL
)
ON [PRIMARY]
GO