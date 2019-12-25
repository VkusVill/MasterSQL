CREATE TABLE [dbo].[tovar_barcode] (
  [barcode] [varchar](15) NOT NULL,
  [id_tov] [int] NOT NULL,
  [id_kontr] [int] NULL,
  [hashsum] AS (checksum([id_tov],[barcode],[id_kontr]))
)
ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [ClusteredIndex-20190704-224248]
  ON [dbo].[tovar_barcode] ([barcode])
  ON [PRIMARY]
GO

CREATE INDEX [NonClusteredIndex-20190704-224317]
  ON [dbo].[tovar_barcode] ([id_tov])
  ON [PRIMARY]
GO