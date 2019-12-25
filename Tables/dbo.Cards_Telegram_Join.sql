CREATE TABLE [dbo].[Cards_Telegram_Join] (
  [number] [char](7) NOT NULL,
  [number_join] [char](7) NOT NULL,
  [is_Join] [int] NOT NULL,
  [sms_code] [int] NOT NULL,
  [date_send_sms_code] [datetime] NOT NULL,
  [view_join_history] [smallint] NULL CONSTRAINT [DF_Cards_Telegram_Join_view_join_history] DEFAULT (0),
  [permanent_join] [int] NULL,
  [join_date] [datetime] NULL
)
ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [IX_Telegram_Join]
  ON [dbo].[Cards_Telegram_Join] ([number], [number_join])
  ON [PRIMARY]
GO