CREATE TABLE [dbo].[arc_Coupon_tov_noused] (
  [id] [int] NOT NULL,
  [id_tov] [int] NULL,
  [id_group] [int] NULL,
  [date_from] [date] NOT NULL,
  [date_to] [date] NOT NULL,
  [date_add] [datetime] NOT NULL,
  [user_add] [nchar](100) NULL,
  [date_ins] [datetime] NOT NULL CONSTRAINT [DF_arc_Coupon_tov_noused_date_add] DEFAULT (getdate())
)
ON [PRIMARY]
GO