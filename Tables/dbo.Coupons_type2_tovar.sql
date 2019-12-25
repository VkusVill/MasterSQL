CREATE TABLE [dbo].[Coupons_type2_tovar] (
  [date_activation] [date] NOT NULL,
  [id_tov] [int] NOT NULL,
  [v_tov] [int] NOT NULL,
  [price] [int] NOT NULL,
  [sp_price] [int] NOT NULL,
  [nac_tov] [int] NOT NULL,
  [date_add] [datetime] NULL CONSTRAINT [DF_Coupons_type2_tovar_date_add] DEFAULT (getdate()),
  [type1_typeadd] [int] NULL,
  CONSTRAINT [PK_Coupons_type2_tovar] PRIMARY KEY CLUSTERED ([date_activation], [id_tov])
)
ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [du_Coupons_type2_tovar]
   ON  [dbo].[Coupons_type2_tovar]
   AFTER DELETE,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


insert into [vv03].[dbo].[arc_Coupons_type2_tovar]
      (date_activation
      ,[id_tov]
      ,[v_tov]
      ,[price]
      ,[sp_price]
      ,[nac_tov]
      ,[date_add] )
select date_activation
      ,[id_tov]
      ,[v_tov]
      ,[price]
      ,[sp_price]
      ,[nac_tov]
      ,[date_add]
from deleted      


END
GO