CREATE TABLE [dbo].[chinese_tovari] (
  [id_tov] [int] NULL,
  [name_tov] [nvarchar](max) NULL,
  [group_name] [nvarchar](500) NULL,
  [parent_gr_name] [nvarchar](500) NULL,
  [ccal] [nvarchar](500) NULL,
  [ingredients] [nvarchar](max) NULL,
  [descr] [nvarchar](max) NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO