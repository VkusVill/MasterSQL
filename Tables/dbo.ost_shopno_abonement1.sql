CREATE TABLE [dbo].[ost_shopno_abonement1] (
  [shopno] [int] NOT NULL,
  [id_tov] [int] NOT NULL,
  [id_kontr] [int] NULL,
  [q] [real] NULL,
  [date_pr] [datetime] NULL,
  [k] [int] NOT NULL
)
ON [PRIMARY]
GO

CREATE INDEX [IX_osa_1]
  ON [dbo].[ost_shopno_abonement1] ([shopno], [id_tov], [id_kontr], [k])
  INCLUDE ([q], [date_pr])
  ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [PK_osa]
  ON [dbo].[ost_shopno_abonement1] ([k], [shopno], [id_tov])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'описание', N'https://docs.google.com/document/d/1Xiz3aHfE32sCX81E-PBVo5P2THyBQrhGLHvzO5n1B08/edit?usp=sharing', 'SCHEMA', N'dbo', 'TABLE', N'ost_shopno_abonement1'
GO