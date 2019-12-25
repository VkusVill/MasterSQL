CREATE TABLE [dbo].[arc_Cards_Discount_Action] (
  [number] [char](7) NOT NULL,
  [Year_month] [int] NOT NULL,
  [discount_proc] [int] NOT NULL,
  [date_start] [datetime] NOT NULL,
  [date_add] [datetime] NOT NULL,
  [date_perenos] [datetime] NULL,
  [Type_add] [tinyint] NULL
)
ON [PRIMARY]
GO