CREATE TABLE [dbo].[Price_Period] (
  [id_tt] [int] NULL,
  [id_tov] [int] NOT NULL,
  [Price] [decimal](15, 2) NULL,
  [Period] [date] NULL
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Price_Period]
  ON [dbo].[Price_Period] ([id_tt], [id_tov], [Period])
  INCLUDE ([Price])
  ON [PRIMARY]
GO