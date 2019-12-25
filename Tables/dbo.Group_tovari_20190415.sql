CREATE TABLE [dbo].[Group_tovari_20190415] (
  [id_group] [int] NOT NULL,
  [Name_gr] [nvarchar](150) NOT NULL,
  [id_parent] [int] NULL,
  [id_par_group] [int] NULL,
  [id_parent_curr] [int] NULL,
  [id_par_group_curr] [int] NULL
)
ON [PRIMARY]
GO