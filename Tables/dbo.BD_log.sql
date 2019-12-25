CREATE TABLE [dbo].[BD_log] (
  [nvaCardNum] [nvarchar](50) NULL,
  [Cashid] [int] NULL,
  [checknumber] [int] NULL,
  [BD] [nvarchar](8) NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_bd_log_date_add] DEFAULT (getdate())
)
ON [PRIMARY]
GO

CREATE INDEX [IX_BD]
  ON [dbo].[BD_log] ([nvaCardNum], [Cashid], [checknumber], [BD])
  ON [PRIMARY]
GO