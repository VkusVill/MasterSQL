CREATE TABLE [dbo].[Group_tovari] (
  [id_group] [int] NOT NULL,
  [Name_gr] [nvarchar](150) NOT NULL,
  [id_parent] [int] NULL,
  [id_par_group] [int] NULL
)
ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [PK_Group_tovari]
  ON [dbo].[Group_tovari] ([id_group])
  ON [PRIMARY]
GO