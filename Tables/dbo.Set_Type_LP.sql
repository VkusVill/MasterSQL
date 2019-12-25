CREATE TABLE [dbo].[Set_Type_LP] (
  [id] [int] NOT NULL,
  [NameType] [varchar](30) NOT NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_Set_Type_LP_date_add] DEFAULT (getdate())
)
ON [PRIMARY]
GO