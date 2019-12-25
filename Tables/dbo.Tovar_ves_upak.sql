CREATE TABLE [dbo].[Tovar_ves_upak] (
  [id_tov] [int] NULL,
  [id_kontr] [int] NULL,
  [ves_Upak] [numeric](15, 3) NULL
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [PK_Tovar_ves_Upak]
  ON [dbo].[Tovar_ves_upak] ([id_tov], [id_kontr])
  ON [PRIMARY]
GO