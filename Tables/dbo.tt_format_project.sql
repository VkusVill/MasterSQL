CREATE TABLE [dbo].[tt_format_project] (
  [tt_format] [int] NOT NULL,
  [project] [varchar](2) NOT NULL,
  [format_name] [varchar](100) NULL,
  [descr_format] [varchar](1000) NULL,
  [TM] [varchar](50) NULL,
  [Load_sr_Checks_Checkline_add_trigger] [tinyint] NULL,
  [is_MarketPlace] [bit] NULL,
  [email_tt_format] [varchar](500) NOT NULL,
  [SummForLP] [tinyint] NULL,
  [load_for_web] [tinyint] NULL,
  [id_tm] [int] NULL,
  [td_move_upd] [bit] NULL,
  [load_remainders] [bit] NULL
)
ON [PRIMARY]
GO