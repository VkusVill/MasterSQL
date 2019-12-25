CREATE TABLE [dbo].[Reiting_reset_period] (
  [id] [bigint] IDENTITY,
  [id_tov] [int] NOT NULL,
  [id_kontr] [int] NULL,
  [date_reset] [date] NOT NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_Reiting_reset_priod_date_add] DEFAULT (getdate()),
  [Reason] [varchar](1000) NOT NULL,
  [Autor] [varchar](100) NOT NULL,
  [Current_reiting] [float] NULL,
  CONSTRAINT [PK_Reiting_start_priod] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Reiting_reset_period_1]
  ON [dbo].[Reiting_reset_period] ([id_tov], [id_kontr], [date_reset])
  ON [PRIMARY]
GO