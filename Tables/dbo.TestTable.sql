CREATE TABLE [dbo].[TestTable] (
  [col1] [int] NULL,
  [col2] [numeric](10) NULL
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
CREATE TRIGGER [Instead_Insert_TestTable]
   ON  [dbo].[TestTable]
   INSTEAD OF INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	declare @maxID numeric = (select max(col2) from dbo.TestTable)
    Insert Into dbo.TestTable (col1, col2)
	Select i.col1, ROW_NUMBER() over (order by i.col1) + @maxID
	From inserted i 
END
GO