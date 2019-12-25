CREATE TABLE [dbo].[7CC4859C_5B14_4563_A764_29416528EF54] (
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