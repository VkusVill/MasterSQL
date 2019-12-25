CREATE TABLE [dbo].[Schedule_Shop_Work] (
  [id_tt] [numeric](10) NULL,
  [ShopNo] [numeric](10) NULL,
  [dw] [numeric](2) NULL,
  [H_Start] [time] NULL,
  [H_End] [time] NULL
)
ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [PK_Schedule_Shop_Work]
  ON [dbo].[Schedule_Shop_Work] ([ShopNo], [dw])
  ON [PRIMARY]
GO