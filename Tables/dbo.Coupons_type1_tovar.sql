CREATE TABLE [dbo].[Coupons_type1_tovar] (
  [date_activation] [date] NOT NULL,
  [id_tov] [int] NOT NULL,
  [Дата_ввода] [date] NOT NULL,
  [Колво_продажи_день] [int] NOT NULL,
  [Сумма_продажи_день] [int] NOT NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_Coupons_type1_tovar_date_add] DEFAULT (getdate()),
  CONSTRAINT [PK_Coupons_type1_tovar] PRIMARY KEY CLUSTERED ([date_activation], [id_tov])
)
ON [PRIMARY]
GO