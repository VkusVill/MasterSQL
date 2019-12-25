CREATE TABLE [dbo].[Tovar_images] (
  [id_tov] [int] NOT NULL,
  [ordr] [tinyint] NOT NULL DEFAULT (1),
  [short_name] [varchar](200) NULL,
  [photourl] [varchar](150) NULL,
  [name] [varchar](50) NULL,
  [ext] [varchar](10) NULL,
  [main] [bit] NOT NULL DEFAULT (0),
  [mini_photo] [varchar](150) NULL,
  [big_photo] [varchar](150) NULL,
  [hashsum] AS (checksum([id_tov],[ordr],[mini_photo],[big_photo],[name],[main]))
)
ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [ClusteredIndex-20190705-000243]
  ON [dbo].[Tovar_images] ([id_tov], [ordr])
  ON [PRIMARY]
GO