SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO





 
CREATE view [dbo].[WEB_Catalog_Tovari_vw]  
as
select *
from  vv03..WEB_Catalog_Tovari as c with(nolock) 
where isnull(spec_tov,0)=0




GO