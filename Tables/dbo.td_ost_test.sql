CREATE TABLE [dbo].[td_ost_test] (
  [id_tov] [int] NOT NULL,
  [Ost_kon] [decimal](15, 3) NOT NULL,
  [date_last_upd] [datetime] NULL,
  [ShopNo_rep] [int] NOT NULL,
  [row_uid] [varchar](36) NULL,
  [id_kontr_last_post] [int] NULL,
  [is_wrong_ost] [smallint] NULL
)
ON [PRIMARY]
GO