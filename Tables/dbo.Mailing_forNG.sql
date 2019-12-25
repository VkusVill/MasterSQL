CREATE TABLE [dbo].[Mailing_forNG] (
  [id] [int] IDENTITY,
  [id_tov] [int] NULL,
  [date_start] [date] NULL,
  [date_end] [date] NULL,
  [Qty_send] [int] NULL,
  [is_active] [bit] NULL,
  [user_1C] [nvarchar](255) NULL,
  [date_deactivate] [date] NULL,
  [Qty_max] [int] NULL,
  CONSTRAINT [PK_Mailing_forNG] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO