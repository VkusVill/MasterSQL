CREATE TABLE [dbo].[tt_time_coupon] (
  [date_activation] [date] NOT NULL,
  [id_TT] [numeric](10) NOT NULL,
  [time_begin] [datetime] NOT NULL,
  [time_make] [datetime] NULL,
  CONSTRAINT [PK_tt_time_coupon] PRIMARY KEY CLUSTERED ([date_activation], [id_TT])
)
ON [PRIMARY]
GO