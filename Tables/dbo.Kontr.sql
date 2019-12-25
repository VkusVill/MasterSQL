CREATE TABLE [dbo].[Kontr] (
  [id_kontr] [int] NULL,
  [nova_kontr] [varchar](250) NULL,
  [is_active] [int] NOT NULL,
  [id_ul_post] [int] NULL
)
ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [PK_Kontr]
  ON [dbo].[Kontr] ([id_kontr])
  ON [PRIMARY]
GO