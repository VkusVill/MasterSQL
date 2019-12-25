CREATE TABLE [dbo].[Tovar_Har] (
  [id_tov] [int] NOT NULL,
  [id_kontr] [int] NOT NULL,
  [Name_har] [varchar](150) NOT NULL
)
ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [PK_Tovar_Har]
  ON [dbo].[Tovar_Har] ([id_tov], [id_kontr])
  ON [PRIMARY]
GO