CREATE TABLE [dbo].[Cards_Discount_Action] (
  [number] [char](7) NOT NULL,
  [Year_month] [int] NOT NULL,
  [discount_proc] [int] NOT NULL,
  [date_start] [datetime] NOT NULL CONSTRAINT [DF_Cards_Discount_Action_date_start] DEFAULT (getdate()),
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_Cards_Discount_Action_date_add] DEFAULT (getdate()),
  [perenos_cards_del] [int] NULL CONSTRAINT [DF_Cards_Discount_Action_perenos_cards] DEFAULT (0),
  [date_perenos] [datetime] NULL,
  [Type_add] [tinyint] NULL CONSTRAINT [DF_Cards_Discount_Action_Type_add] DEFAULT (0),
  [user_add] [varchar](100) NULL,
  [descr] [varchar](1000) NULL
)
ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [PK_Cards_Discount_action]
  ON [dbo].[Cards_Discount_Action] ([number], [Year_month])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: 2017-12-01
-- Description:	Перемещение скидок по старой акции в архив
-- =============================================
CREATE TRIGGER [del_Cards_Discount_Action]
   ON  [dbo].[Cards_Discount_Action]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO [vv03].[dbo].[arc_Cards_Discount_Action]
           ([number]
           ,[Year_month]
           ,[discount_proc]
           ,[date_start]
           ,[date_add]
           ,[perenos_cards_del]
           ,[date_perenos]
           ,[Type_add])
    SELECT [number]
      ,[Year_month]
      ,[discount_proc]
      ,[date_start]
      ,[date_add]
      ,[perenos_cards_del]
      ,[date_perenos]
      ,[Type_add]
  FROM deleted where year_month < telegram.dbo.Curr_month_year(getdate()) 
END
GO