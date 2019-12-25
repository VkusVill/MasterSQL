CREATE TABLE [dbo].[tt_action] (
  [id_tov] [numeric](10) NULL,
  [shopNo] [numeric](5) NOT NULL,
  [action_for_quantity] [int] NULL,
  [discount] [numeric](15, 2) NULL,
  [quantity_for_discount] [numeric](10, 3) NULL,
  [price_special] [numeric](15, 2) NULL
)
ON [PRIMARY]
GO

CREATE INDEX [idx_tt_action_shopNo_id_tov]
  ON [dbo].[tt_action] ([shopNo], [id_tov])
  ON [PRIMARY]
GO