CREATE TABLE [dbo].[lct_one_day] (
  [number] [nchar](7) NOT NULL,
  [id_tov] [int] NOT NULL,
  [id_tov_tek] [int] NOT NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_lct_one_day_date_add] DEFAULT (getdate()),
  [id] [bigint] IDENTITY,
  [cashid] [int] NOT NULL,
  [sp_price_one_day] [decimal](15, 2) NULL,
  [proc_sk_one_day] [int] NULL,
  [double_only_today] [bit] NULL
)
ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [IX_lct_one_day]
  ON [dbo].[lct_one_day] ([date_add])
  ON [PRIMARY]
GO

CREATE INDEX [IX_lct_one_day_1]
  ON [dbo].[lct_one_day] ([number], [date_add], [id_tov])
  ON [PRIMARY]
GO