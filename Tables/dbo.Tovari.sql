CREATE TABLE [dbo].[Tovari] (
  [id_tov] [int] NOT NULL,
  [Name_tov] [nvarchar](150) NULL,
  [ЕстьАктХар] [int] NULL,
  [ЕстьНовХар] [int] NULL,
  [is_alc] [smallint] NULL,
  [IsComplect] [int] NULL DEFAULT (0),
  [Ed_Izm] [varchar](50) NULL,
  [Ves] [decimal](15, 3) NULL,
  [id_tov_web] [int] NULL,
  [kvant_ves_tov] [decimal](15, 3) NULL,
  [id_tov_Osnovn] [int] NULL,
  [id_group] [int] NULL,
  [price_tov] [decimal](15, 2) NULL,
  [t_reiting] [int] NULL,
  [Месяц_del] [int] NULL,
  [CatAssStr] [varchar](30) NULL,
  [ВесДляСайта] [varchar](100) NULL,
  [bez_ostatkov] [int] NULL,
  [N_tov] [decimal](10, 3) NULL,
  [TradeMark] [int] NULL,
  [nds] [decimal](3, 2) NOT NULL CONSTRAINT [DF_Tovari_nds] DEFAULT (0),
  [vesovoi] [bit] NULL DEFAULT (0),
  [Name_Tov_For_Search] [varchar](255) NULL,
  CONSTRAINT [PK_Tovari] PRIMARY KEY CLUSTERED ([id_tov])
)
ON [PRIMARY]
GO

CREATE INDEX [id_tov_osn]
  ON [dbo].[Tovari] ([id_tov_Osnovn])
  INCLUDE ([id_tov])
  ON [PRIMARY]
GO

CREATE INDEX [IX_price_tov]
  ON [dbo].[Tovari] ([price_tov])
  INCLUDE ([id_tov], [Name_tov], [Ed_Izm], [ВесДляСайта], [Name_Tov_For_Search])
  ON [PRIMARY]
GO

CREATE INDEX [X_tov_Compl]
  ON [dbo].[Tovari] ([id_tov], [IsComplect])
  ON [PRIMARY]
GO