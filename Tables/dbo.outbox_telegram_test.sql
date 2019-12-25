CREATE TABLE [dbo].[outbox_telegram_test] (
  [id] [bigint] IDENTITY,
  [bot_id] [int] NULL,
  [user_id] [int] NULL,
  [incoming_message] [int] NULL,
  [message] [varchar](8000) NULL,
  [keyboard_id] [int] NULL,
  [keyboard_parameter] [varchar](200) NULL,
  [message_type] [int] NULL,
  [add_date] [datetime] NULL,
  [send_date] [datetime] NULL,
  [CashID] [int] NULL,
  [CashCheckNo] [int] NULL,
  [message_id] [bigint] NULL
)
ON [PRIMARY]
GO