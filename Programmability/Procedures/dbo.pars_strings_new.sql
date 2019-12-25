SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: 2018-09-07
-- Description:	Основана на процедуре pars_strings(оптимизированная версия) 
-- =============================================
CREATE PROCEDURE [dbo].[pars_strings_new]
@str1 as nvarchar(max) ,
@str2 as nvarchar(max)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--insert into jobs..Jobs_log(id_job, number_step, duration)
--select 1040,1,0

create table #a ([id] [int] IDENTITY(1,1) NOT NULL , id_tov int)

insert into #a (id_tov)
SELECT val FROM vv03.dbo.ParsingStrT(@str1, ',')
   
create table #b ([id] [int] IDENTITY(1,1) NOT NULL , par1 int)


if @str2 is not null 

begin

insert into #b (par1)
SELECT val FROM vv03.dbo.ParsingStrT(@str2, ',')   


select a.id_tov , isnull(b.par1,0)
from #a  a
left join #b b on  a.id = b.id

end

else

select a.id_tov , a.id
from #a  a
      

END
GO