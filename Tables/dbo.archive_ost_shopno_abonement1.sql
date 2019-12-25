CREATE TABLE [dbo].[archive_ost_shopno_abonement1] (
  [shopno] [int] NOT NULL,
  [id_tov] [int] NOT NULL,
  [id_kontr] [int] NULL,
  [q] [real] NULL,
  [date_pr] [datetime] NULL,
  [k] [int] NOT NULL,
  [date_add] [datetime] NOT NULL
)
ON [PRIMARY]
GO

CREATE INDEX [IX_date_add]
  ON [dbo].[archive_ost_shopno_abonement1] ([date_add])
  ON [PRIMARY]
GO