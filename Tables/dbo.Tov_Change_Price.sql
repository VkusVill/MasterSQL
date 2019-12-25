CREATE TABLE [dbo].[Tov_Change_Price] (
  [id_tov] [int] NULL,
  [name_tov] [varchar](150) NULL,
  [new_price] [decimal](15, 2) NULL,
  [last_price] [decimal](15, 2) NULL,
  [date_change] [date] NULL
)
ON [PRIMARY]
GO