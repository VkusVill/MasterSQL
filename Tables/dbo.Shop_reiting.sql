CREATE TABLE [dbo].[Shop_reiting] (
  [ShopNo] [int] NOT NULL,
  [reiting] [decimal](15, 2) NOT NULL,
  [reiting_avg] [decimal](15, 2) NOT NULL,
  [Qty] [int] NULL
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [PK_Shop_Reiting]
  ON [dbo].[Shop_reiting] ([ShopNo])
  ON [PRIMARY]
GO