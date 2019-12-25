CREATE TABLE [dbo].[coupon_tov_change] (
  [id] [int] IDENTITY,
  [id_tov] [int] NOT NULL,
  [id_tov_new] [int] NOT NULL,
  [sp_price_new] [int] NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_coupon_tov_change_date_add] DEFAULT (getdate()),
  [user_add] [nchar](100) NULL,
  [date_change] [datetime] NULL,
  CONSTRAINT [PK_coupon_tov_change] PRIMARY KEY CLUSTERED ([id])
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
CREATE TRIGGER [change_coupon_tov_change] 
   ON  [dbo].[coupon_tov_change] 
   AFTER DELETE,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


insert into [vv03].[dbo].[arc_coupon_tov_change]
      ([id]
      ,[id_tov]
      ,[id_tov_new]
      ,[sp_price_new]
      ,[date_add]
      ,[user_add]
      ,date_change)
  select [id]
      ,[id_tov]
      ,[id_tov_new]
      ,[sp_price_new]
      ,[date_add]
      ,[user_add]
      ,date_change
      from deleted    

END
GO