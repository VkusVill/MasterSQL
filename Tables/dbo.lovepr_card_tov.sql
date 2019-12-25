CREATE TABLE [dbo].[lovepr_card_tov] (
  [number] [nchar](7) NOT NULL,
  [id_tov] [int] NOT NULL,
  [date_from] [date] NOT NULL,
  [date_to] [date] NOT NULL,
  [sp_price] [int] NOT NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_lovepr_card_tov_date_add] DEFAULT (getdate()),
  [id] [bigint] IDENTITY,
  [proc_sk] [int] NULL,
  [Set_Type] [int] NULL CONSTRAINT [DF_Set_Type] DEFAULT (0),
  CONSTRAINT [PK_lovepr_card_tov] PRIMARY KEY CLUSTERED ([number], [id_tov], [date_from])
)
ON [PRIMARY]
GO

CREATE INDEX [dates_number]
  ON [dbo].[lovepr_card_tov] ([number], [date_from], [date_to])
  INCLUDE ([id_tov])
  ON [PRIMARY]
GO

CREATE INDEX [IX_lover_card_id_date_add]
  ON [dbo].[lovepr_card_tov] ([id])
  INCLUDE ([date_add])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [update_lovepr_card_tov]
   ON  [dbo].[lovepr_card_tov] 
   AFTER update , delete
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

insert into [vv03].[dbo].[arc_lovepr_card_tov]
      ([number]
      ,[id_tov]
      ,[date_from]
      ,[date_to]
      ,[sp_price]
      ,[date_add]
      ,[id]
      ,set_type
      )
select [number]
      ,[id_tov]
      ,[date_from]
      ,[date_to]
      ,[sp_price]
      ,[date_add]
      ,[id]
      ,set_type
      
from deleted        
      
      

END
GO