CREATE TABLE [dbo].[Price_1C_tov] (
  [id_tov] [int] NOT NULL,
  [Price] [decimal](15, 2) NULL,
  [sebest] [decimal](15, 5) NULL,
  CONSTRAINT [PK_Price_1C_tov] PRIMARY KEY CLUSTERED ([id_tov])
)
ON [PRIMARY]
GO