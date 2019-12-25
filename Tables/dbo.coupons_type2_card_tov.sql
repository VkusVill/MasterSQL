CREATE TABLE [dbo].[coupons_type2_card_tov] (
  [date_activation] [date] NOT NULL,
  [number] [nchar](7) NOT NULL,
  [id_tov] [int] NOT NULL,
  [proc_sk] [int] NULL,
  [date_from] [date] NOT NULL,
  [date_to] [date] NOT NULL,
  [type_number] [int] NOT NULL,
  [type_tov] [int] NOT NULL,
  [sp_price] [int] NOT NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_coupons_type2_card_tov_date_add] DEFAULT (getdate()),
  [date_take] [datetime] NULL,
  [id] [bigint] IDENTITY,
  [par1] [int] NULL,
  [par2] [int] NULL,
  [par3] [smallint] NULL,
  [par4] [int] NULL,
  [par5] [smallint] NULL,
  [insSource] [smallint] NULL,
  [shopNo] [int] NULL,
  [td_ost] [decimal](18, 3) NULL,
  CONSTRAINT [PK_coupons_type2_card_tov] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_coupons_type2_card_tov]
  ON [dbo].[coupons_type2_card_tov] ([date_activation], [number])
  INCLUDE ([id_tov])
  ON [PRIMARY]
GO

CREATE INDEX [IX_coupons_type2_card_tov_2]
  ON [dbo].[coupons_type2_card_tov] ([number], [date_activation], [date_from])
  INCLUDE ([date_to], [sp_price], [id_tov], [id], [date_take])
  ON [PRIMARY]
GO

CREATE INDEX [IX_coupons_type2_card_tov_3]
  ON [dbo].[coupons_type2_card_tov] ([number], [id_tov], [date_from], [date_to], [date_take], [date_add])
  INCLUDE ([type_number], [sp_price], [id])
  ON [PRIMARY]
GO

CREATE INDEX [IX_coupons_type2_card_tov_4]
  ON [dbo].[coupons_type2_card_tov] ([number], [date_add], [date_from])
  INCLUDE ([id_tov], [proc_sk], [date_to], [sp_price], [id], [type_number])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [du_coupons_type2_card_tov]
   ON  [dbo].[coupons_type2_card_tov]
   AFTER DELETE,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--/**
insert into [vv03].[dbo].[arc_coupons_type2_card_tov]
      ([date_activation]
      ,[date_from]
      ,[date_to]
      ,[number]
      ,[type_number]
      ,[id_tov]
      ,[type_tov]
      ,[sp_price]
      ,[date_add]
      ,[date_take]
      ,proc_sk )
select [date_activation]
      ,[date_from]
      ,[date_to]
      ,[number]
      ,[type_number]
      ,[id_tov]
      ,[type_tov]
      ,[sp_price]
      ,[date_add]
      ,[date_take]
      ,proc_sk
from deleted   
where date_to >= DATEADD(DAY,-28,GETDATE())   
--**/


END
GO