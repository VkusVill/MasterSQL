CREATE TABLE [dbo].[arc_lovepr_card_tov] (
  [number] [nchar](7) NOT NULL,
  [id_tov] [int] NOT NULL,
  [date_from] [date] NOT NULL,
  [date_to] [date] NOT NULL,
  [sp_price] [int] NOT NULL,
  [date_add] [datetime] NOT NULL,
  [id] [bigint] NOT NULL,
  [date_ins] [datetime] NULL CONSTRAINT [DF_arc_lovepr_card_tov_date_add] DEFAULT (getdate()),
  [id_arc] [bigint] IDENTITY,
  [set_type] [int] NULL,
  CONSTRAINT [PK_arc_lovepr_card_tov] PRIMARY KEY CLUSTERED ([id_arc])
)
ON [PRIMARY]
GO