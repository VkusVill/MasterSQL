CREATE TABLE [dbo].[Cards_telegram_off] (
  [number] [char](7) NULL,
  [telegram_id] [bigint] NOT NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_Cards_telegram_off_date_add] DEFAULT (getdate()),
  [type_add] [int] NULL CONSTRAINT [DF_Cards_telegram_off_type_add] DEFAULT (0),
  [bot_id] [int] NULL
)
ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [IX_Cards_telegram_off]
  ON [dbo].[Cards_telegram_off] ([number], [telegram_id], [date_add])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Бот, который заблокировал пользователь.', 'SCHEMA', N'dbo', 'TABLE', N'Cards_telegram_off', 'COLUMN', N'number'
GO