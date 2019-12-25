CREATE TABLE [dbo].[51AA3708_C840_4BA6_9ADC_ED6D371160EE] (
  [CheckUID] [varchar](36) NULL,
  [id_tov_cl] [int] NULL,
  [ShopNo] [int] NOT NULL,
  [CashID] [bigint] NULL,
  [CloseDate] [datetime] NOT NULL,
  [Name_tov] [nvarchar](150) NOT NULL,
  [CashCheckNo] [int] NULL,
  [BONUSCARD] [varchar](50) NULL,
  [BasePrice] [money] NOT NULL,
  [Quantity] [numeric](38, 3) NULL,
  [Price_retail] [money] NULL,
  [BaseSum] [money] NOT NULL
)
ON [PRIMARY]
GO