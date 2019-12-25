CREATE TABLE [dbo].[Cards_tov_tt] (
  [number] [char](7) NOT NULL,
  [tt] [nvarchar](max) NULL,
  [vozvrati] [nvarchar](max) NULL,
  [perestali] [nvarchar](max) NULL,
  [novinki] [nvarchar](max) NULL,
  [korzina] [nvarchar](max) NULL,
  [Q_perestali] [varchar](max) NULL,
  [Q_novinki] [varchar](max) NULL,
  [Q_korzina] [varchar](max) NULL,
  [date_add] [datetime] NULL CONSTRAINT [DF_Cards_tov_tt_date_add] DEFAULT (getdate()),
  [Max_Price] [int] NULL,
  [tov_last_checks] [varchar](2000) NULL,
  [tov_Last_14Days] [varchar](max) NULL,
  [tov_for_mark] [varchar](max) NULL,
  [tt_for_mark] [varchar](max) NULL,
  CONSTRAINT [key1] PRIMARY KEY CLUSTERED ([number])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'Описание', N'https://docs.google.com/document/d/1C_gXs7yGBCsft92hTDkRUkX0SMLjW57Us7ifvyVWr7Q/edit?usp=sharing', 'SCHEMA', N'dbo', 'TABLE', N'Cards_tov_tt'
GO