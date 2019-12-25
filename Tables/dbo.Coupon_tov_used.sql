CREATE TABLE [dbo].[Coupon_tov_used] (
  [id] [int] IDENTITY,
  [id_tov] [int] NOT NULL,
  [date_from] [date] NOT NULL,
  [date_to] [date] NOT NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_Coupon_tov_used_date_add] DEFAULT (getdate()),
  [user_add] [nchar](100) NULL,
  CONSTRAINT [PK_Coupon_tov_used] PRIMARY KEY CLUSTERED ([id])
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
CREATE TRIGGER [change_coupon_tov_used] 
   ON  [dbo].[Coupon_tov_used] 
   AFTER DELETE,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


insert into [vv03].[dbo].[arc_coupon_tov_used]
      ( [id]
      ,[id_tov]
      ,[date_from]
      ,[date_to]
      ,[date_add]
      ,[user_add])
  select  [id]
      ,[id_tov]
      ,[date_from]
      ,[date_to]
      ,[date_add]
      ,[user_add]
      from deleted    

END
GO