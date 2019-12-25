CREATE TABLE [dbo].[DocPeredanoNaTTTovari] (
  [id_tov_1c] [int] NOT NULL,
  [KolvoSkl] [decimal](15, 3) NOT NULL,
  [date_last_upd] [datetime] NULL,
  [id_tt_1c] [int] NOT NULL,
  CONSTRAINT [PK_DocPeredanoNaTTTovari] PRIMARY KEY CLUSTERED ([id_tov_1c], [id_tt_1c])
)
ON [PRIMARY]
GO

CREATE INDEX [ind_id_tt]
  ON [dbo].[DocPeredanoNaTTTovari] ([id_tt_1c])
  INCLUDE ([id_tov_1c], [KolvoSkl])
  ON [PRIMARY]
GO