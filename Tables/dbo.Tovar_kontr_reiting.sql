CREATE TABLE [dbo].[Tovar_kontr_reiting] (
  [id_tov] [int] NOT NULL,
  [id_kontr] [int] NULL,
  [reiting] [decimal](15, 2) NOT NULL,
  [reiting_avg] [decimal](15, 2) NOT NULL,
  [Qty] [int] NULL,
  [date_update] [datetime] NULL
)
ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [IX_Tovar_kont_Reiting]
  ON [dbo].[Tovar_kontr_reiting] ([id_tov], [id_kontr])
  ON [PRIMARY]
GO