SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: 2017-06-08
-- Description:	Формирование списка по порядку
-- =============================================
CREATE FUNCTION [dbo].[Get_List_order]
(	
@str as varchar(max)
)
RETURNS TABLE 
AS
RETURN 
(
--declare @str as varchar(max)='1152,1284,1293,1278,1261'
	
	
	select rn , _id id
	from
	(select _id ,row_number() over (partition by 0 order by (select 0)) rn
	from (select cast('<r><c>'+replace(@str,',','</c><c>')+'</c></r>' as xml) id
			)t
		cross apply(select x.z.value('.', 'varchar(100)') _id from id.nodes('/r/c') x(z))q)q1
	--where  CHARINDEX('~',_checkline,1)-1>0
	
	)
GO