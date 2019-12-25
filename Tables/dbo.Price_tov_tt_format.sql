CREATE TABLE [dbo].[Price_tov_tt_format] (
  [id_tov] [numeric](10) NULL,
  [price] [numeric](15, 2) NOT NULL,
  [tt_format] [numeric](11) NULL
)
ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [PK_Price_tov_tt_format]
  ON [dbo].[Price_tov_tt_format] ([id_tov], [tt_format])
  ON [PRIMARY]
GO