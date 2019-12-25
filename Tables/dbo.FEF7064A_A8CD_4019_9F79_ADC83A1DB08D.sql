CREATE TABLE [dbo].[FEF7064A_A8CD_4019_9F79_ADC83A1DB08D] (
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