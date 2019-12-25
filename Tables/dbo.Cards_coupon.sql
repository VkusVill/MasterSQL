CREATE TABLE [dbo].[Cards_coupon] (
  [Number] [nchar](7) NOT NULL,
  [Tovari_str] [nvarchar](max) NULL,
  [Cupon_str] [nvarchar](max) NULL,
  [Prices_str] [nvarchar](max) NULL,
  [Date_coup_from] [date] NULL,
  [Date_coup_to] [date] NULL,
  [LovePr_today_str] [nvarchar](max) NULL,
  [LovePr_tomor_str] [nvarchar](max) NULL,
  [Date_LovePr_to] [date] NULL,
  [proc_sk_ab] [int] NULL,
  [proc_sk_lt] [int] NULL,
  [date_add] [datetime] NULL CONSTRAINT [DF_Cards_coupon_date_add] DEFAULT (getdate()),
  CONSTRAINT [PK_Cards_coupon] PRIMARY KEY CLUSTERED ([Number])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [du_Cards_coupon]
   ON  [dbo].[Cards_coupon]
   AFTER DELETE,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

insert into [vv03].[dbo].[arc_Cards_coupon]
      ([Number]
      ,[Tovari_str]
      ,[Cupon_str]
      ,[Prices_str]
      ,[Date_coup_from]
      ,[Date_coup_to]
      ,LovePr_today_str	
      ,LovePr_tomor_str
      ,Date_LovePr_to
      ,proc_sk_ab
      ,proc_sk_lt
      )

select [Number]
      ,[Tovari_str]
      ,[Cupon_str]
      ,[Prices_str]
      ,[Date_coup_from]
      ,[Date_coup_to]
      ,LovePr_today_str	
      ,LovePr_tomor_str
      ,Date_LovePr_to
      ,proc_sk_ab
      ,proc_sk_lt      
from deleted      


END
GO