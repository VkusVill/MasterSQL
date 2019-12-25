CREATE TABLE [dbo].[cards_tov_predict_old] (
  [number] [char](7) NOT NULL,
  [tov] [nvarchar](max) NULL,
  [type_ins] [smallint] NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [PK_number]
  ON [dbo].[cards_tov_predict_old] ([number], [type_ins])
  ON [PRIMARY]
GO