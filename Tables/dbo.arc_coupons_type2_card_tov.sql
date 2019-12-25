CREATE TABLE [dbo].[arc_coupons_type2_card_tov] (
  [date_activation] [date] NULL,
  [date_from] [date] NULL,
  [date_to] [date] NULL,
  [number] [nchar](7) NOT NULL,
  [type_number] [int] NOT NULL,
  [id_tov] [int] NOT NULL,
  [type_tov] [int] NULL,
  [sp_price] [int] NOT NULL,
  [date_add] [datetime] NOT NULL,
  [date_take] [datetime] NULL,
  [date_ins] [datetime] NOT NULL CONSTRAINT [DF_arc_coupons_type2_card_tov_date_ins] DEFAULT (getdate()),
  [id] [bigint] IDENTITY,
  [proc_sk] [int] NULL
)
ON [PRIMARY]
GO

CREATE INDEX [IX_arc_coupons_type2_card_tov_1]
  ON [dbo].[arc_coupons_type2_card_tov] ([date_ins])
  ON [PRIMARY]
GO