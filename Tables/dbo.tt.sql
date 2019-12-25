CREATE TABLE [dbo].[tt] (
  [N] [int] NULL,
  [id_TT] [int] NULL,
  [type_tt] [varchar](50) NULL,
  [name_TT] [nvarchar](250) NOT NULL,
  [is_active] [int] NOT NULL,
  [tt_format] [int] NULL,
  [id_group] [int] NOT NULL,
  [Shirota] [numeric](18, 15) NULL,
  [Dolgota] [numeric](18, 15) NULL,
  [adress] [nvarchar](500) NULL,
  [Hours] [varchar](250) NOT NULL CONSTRAINT [DF__tt__Hours__62D0AF62] DEFAULT (''),
  [Статус] [varchar](50) NULL,
  [kids_room] [int] NULL,
  [id_tt_web] [int] NULL,
  [PublishContacts] [int] NULL,
  [region_tt] [varchar](250) NULL,
  [id_region_tt] [int] NULL,
  [instamart] [bit] NULL,
  [savetime] [bit] NULL,
  [fresh_juice] [bit] NULL,
  [coffee] [bit] NULL,
  [bakery] [bit] NULL,
  [job_interview] [bit] NULL,
  [shop_phone] [varchar](20) NULL,
  [shop_phone2] [varchar](20) NULL,
  [pandomat] [bit] NULL,
  [butcher] [bit] NULL DEFAULT (0),
  [isTrainingShop] [bit] NOT NULL DEFAULT (0),
  [NoAlcohol] [bit] NULL DEFAULT (0),
  [CommentForWeb] [varchar](200) NOT NULL DEFAULT (''),
  [gettaxi] [bit] NOT NULL CONSTRAINT [DF_tt_gettaxi] DEFAULT (0),
  [express] [bit] NOT NULL CONSTRAINT [DF_tt_express] DEFAULT (0),
  [goodcaps] [bit] NOT NULL DEFAULT (0),
  [cafe] [bit] NOT NULL DEFAULT (0),
  [cardscollecting] [bit] NOT NULL DEFAULT (0),
  [nopackage] [bit] NOT NULL DEFAULT (0),
  [cashpoint] [bit] NOT NULL CONSTRAINT [DF_tt_cashpoint] DEFAULT (0)
)
ON [PRIMARY]
GO

CREATE INDEX [IX_TT]
  ON [dbo].[tt] ([N], [Статус])
  ON [PRIMARY]
GO

CREATE INDEX [IX_tt_2]
  ON [dbo].[tt] ([id_TT], [tt_format], [type_tt], [Статус], [PublishContacts], [instamart], [savetime], [fresh_juice], [coffee], [bakery], [job_interview])
  ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [PK_TT]
  ON [dbo].[tt] ([N], [id_TT])
  ON [PRIMARY]
GO

CREATE INDEX [tt_f_ind]
  ON [dbo].[tt] ([tt_format], [type_tt])
  INCLUDE ([N], [id_TT], [name_TT], [is_active], [id_group], [Shirota], [Dolgota], [adress], [Hours], [Статус], [kids_room], [id_tt_web], [PublishContacts], [region_tt], [id_region_tt], [instamart], [savetime], [fresh_juice], [coffee], [bakery], [job_interview], [shop_phone], [shop_phone2], [pandomat])
  ON [PRIMARY]
GO