CREATE TABLE [dbo].[tt_metro] (
  [id_tt] [numeric](10) NULL,
  [ShopNo] [numeric](10) NULL,
  [Метро] [nvarchar](max) NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [PK_tt_metro]
  ON [dbo].[tt_metro] ([id_tt], [ShopNo])
  ON [PRIMARY]
GO