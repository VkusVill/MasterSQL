CREATE TABLE [dbo].[Postavka_CurDay] (
  [id_tt] [int] NOT NULL,
  [ShopNo] [int] NOT NULL,
  [id_tov] [int] NOT NULL,
  [Quantity_RO] [decimal](15, 3) NOT NULL,
  [Quantity_TD] [decimal](15, 3) NOT NULL,
  [date_last_upd] [datetime] NULL,
  CONSTRAINT [PK_Postavka_CurDay] PRIMARY KEY CLUSTERED ([id_tt], [ShopNo], [id_tov])
)
ON [PRIMARY]
GO