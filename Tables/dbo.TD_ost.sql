CREATE TABLE [dbo].[TD_ost] (
  [id_tov] [int] NOT NULL,
  [Ost_kon] [decimal](15, 3) NOT NULL,
  [date_last_upd] [datetime] NULL,
  [ShopNo_rep] [int] NOT NULL,
  [row_uid] [varchar](36) NULL,
  [id_kontr_last_post] [int] NULL,
  [is_wrong_ost] [smallint] NULL,
  [date_last_post] [datetime] NULL,
  [load_web] [tinyint] NULL CONSTRAINT [DF_TD_ost_load_web] DEFAULT (0),
  CONSTRAINT [PK_TD_ost] UNIQUE CLUSTERED ([id_tov], [ShopNo_rep])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Td_ost_1]
  ON [dbo].[TD_ost] ([ShopNo_rep])
  ON [PRIMARY]
GO

CREATE INDEX [IX_TD_ost_2]
  ON [dbo].[TD_ost] ([id_tov], [ShopNo_rep], [id_kontr_last_post])
  INCLUDE ([Ost_kon], [date_last_upd])
  ON [PRIMARY]
GO