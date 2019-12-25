CREATE TABLE [dbo].[ShopNo_CashID] (
  [ShopNo] [int] NOT NULL,
  [CashID] [int] NOT NULL,
  [id_tt] [int] NOT NULL,
  [date_last_upd] [datetime] NULL,
  [CashIP] [varchar](100) NULL,
  CONSTRAINT [PK_ShopNo_CashID] PRIMARY KEY CLUSTERED ([ShopNo], [CashID])
)
ON [PRIMARY]
GO