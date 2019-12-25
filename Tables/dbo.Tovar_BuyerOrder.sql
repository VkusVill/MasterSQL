CREATE TABLE [dbo].[Tovar_BuyerOrder] (
  [number] [char](7) NOT NULL,
  [date_order] [date] NOT NULL,
  [id_tov] [int] NOT NULL,
  [ShopNo] [int] NOT NULL,
  [Quantity] [decimal](15, 3) NOT NULL,
  [date_update] [datetime] NOT NULL CONSTRAINT [DF_Tovar_BuyerOrder_date_update] DEFAULT (getdate()),
  [NOrder] [int] NULL,
  [SecretSanta] [int] NULL
)
ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [IX_Tovar_BuyerOrder]
  ON [dbo].[Tovar_BuyerOrder] ([number], [date_order], [ShopNo], [id_tov])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Tovar_BuyerOrder_1]
  ON [dbo].[Tovar_BuyerOrder] ([NOrder], [SecretSanta])
  ON [PRIMARY]
GO