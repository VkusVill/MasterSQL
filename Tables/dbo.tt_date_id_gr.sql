CREATE TABLE [dbo].[tt_date_id_gr] (
  [date] [date] NOT NULL,
  [id_tt] [int] NOT NULL,
  [id_gr] [int] NOT NULL,
  [ShopNo] [int] NOT NULL
)
ON [PRIMARY]
GO

CREATE INDEX [IX_]
  ON [dbo].[tt_date_id_gr] ([date], [id_tt], [ShopNo])
  INCLUDE ([id_gr])
  ON [PRIMARY]
GO