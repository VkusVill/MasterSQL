CREATE TABLE [dbo].[Shop_Assortiment] (
  [ShopNo] [int] NOT NULL,
  [id_tov] [int] NOT NULL
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [PK_Shop_Assortiment]
  ON [dbo].[Shop_Assortiment] ([ShopNo], [id_tov])
  ON [PRIMARY]
GO