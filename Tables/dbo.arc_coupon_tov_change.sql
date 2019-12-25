CREATE TABLE [dbo].[arc_coupon_tov_change] (
  [id] [int] NOT NULL,
  [id_tov] [int] NOT NULL,
  [id_tov_new] [int] NOT NULL,
  [sp_price_new] [int] NULL,
  [date_add] [datetime] NOT NULL,
  [user_add] [nchar](100) NULL,
  [date_ins] [datetime] NOT NULL CONSTRAINT [DF_arc_coupon_tov_change_date_add] DEFAULT (getdate()),
  [date_change] [datetime] NULL
)
ON [PRIMARY]
GO