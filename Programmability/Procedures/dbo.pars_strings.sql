SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[pars_strings]
@str1 as nvarchar(max) ,
@str2 as nvarchar(max)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

create table #a ([id] [int] IDENTITY(1,1) NOT NULL , id_tov int)

insert into #a (id_tov)
select N.X.value('text()[1]','int') id_tov
 from
(SELECT Convert(XML,'<s>' + replace(@str1,',','</s><s>') + '</s>'))S(X) 
  CROSS APPLY S.X.nodes('/s') N(X)

create table #b ([id] [int] IDENTITY(1,1) NOT NULL , par1 int)


if @str2 is not null 

begin

insert into #b (par1)
select N.X.value('text()[1]','int') id_tov
 from
(SELECT Convert(XML,'<s>' + replace(@str2,',','</s><s>') + '</s>'))S(X) 
  CROSS APPLY S.X.nodes('/s') N(X)


select a.id_tov , isnull(b.par1,0)
from #a  a
left join #b b on  a.id = b.id

end

else

select a.id_tov , a.id
from #a  a
      

END
GO