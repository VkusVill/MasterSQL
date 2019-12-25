CREATE TABLE [dbo].[arc_Coupons_type2_tovar] (
  [date_activation] [date] NULL,
  [id_tov] [int] NOT NULL,
  [v_tov] [int] NOT NULL,
  [price] [int] NOT NULL,
  [sp_price] [int] NOT NULL,
  [nac_tov] [int] NOT NULL,
  [date_add] [datetime] NULL,
  [date_ins] [datetime] NOT NULL CONSTRAINT [DF_arc_Coupons_type2_tovar_date_ins] DEFAULT (getdate())
)
ON [PRIMARY]
GO