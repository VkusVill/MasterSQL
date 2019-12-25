CREATE TABLE [dbo].[BOT_info_SMS] (
  [number] [char](7) NOT NULL,
  [phone] [char](10) NOT NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_BOT_info_SMS_date_add] DEFAULT (getdate())
)
ON [PRIMARY]
GO

CREATE INDEX [IX_BOT_info_sms_1]
  ON [dbo].[BOT_info_SMS] ([number], [phone])
  ON [PRIMARY]
GO