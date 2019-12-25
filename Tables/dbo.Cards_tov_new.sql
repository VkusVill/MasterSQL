CREATE TABLE [dbo].[Cards_tov_new] (
  [BonusCard] [nchar](10) NOT NULL,
  [id_tov] [int] NOT NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_Cards_tov_new_date_add] DEFAULT (getdate()),
  CONSTRAINT [PK_Cards_tov_new] PRIMARY KEY CLUSTERED ([BonusCard], [id_tov])
)
ON [PRIMARY]
GO