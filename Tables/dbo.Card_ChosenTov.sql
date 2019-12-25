CREATE TABLE [dbo].[Card_ChosenTov] (
  [date_add] [datetime] NOT NULL DEFAULT (getdate()),
  [number] [char](7) NOT NULL,
  [id_tov] [int] NOT NULL
)
ON [PRIMARY]
GO

CREATE INDEX [card_id_tov]
  ON [dbo].[Card_ChosenTov] ([id_tov])
  ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [card_tov]
  ON [dbo].[Card_ChosenTov] ([number], [id_tov])
  ON [PRIMARY]
GO