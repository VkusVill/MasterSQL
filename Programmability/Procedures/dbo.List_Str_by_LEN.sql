SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_Str_by_LEN]

		   @str1 nvarchar(max)='' output
		  ,@str2 nvarchar(max)='' output
		  ,@str3 nvarchar(max)='' output
		  ,@str4 nvarchar(max)='' output
		  , @len as int =3600
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 declare @len_all as int
 
	set @str1=RTRIM(@str1) 
    set @str2= RTRIM(@str2)
    set @str3=RTRIM(@str3)
    set @str4=RTRIM(@str4)
    set @len_all=LEN( @str1 +',' + @str2 +','+ @str3 +',' + @str4 )
		  
		  
	if @len_all>@len and @len>100
	begin
	  declare @len_str1 as int
			, @len_str2 as int
			, @len_str3 as int
			, @len_str4 as int
			
			
			set @len_str1=LEN(@str1)
			set @len_str4=LEN(@str4)
			set @len_str3=LEN(@str3)
			set @len_str2=LEN(@str2)
			
			set @len=@len-3 -- скидка на запятые при конкантенации
			set @len_str1=case when @len_str1>5 then convert(int,@len_str1*@len/@len_all)        else @len_str1 end
			set @len_str4=case when @len_str4>5 then convert(int,@len_str4*@len/@len_all)  else @len_str4 end
			set @len_str3=case when @len_str3>5 then convert(int,@len_str3*@len/@len_all)  else @len_str3 end
			set @len_str2=case when @len_str2>5 then convert(int,@len_str2*@len/@len_all) else @len_str2 end
			
			select @str1= vv03.dbo.Get_list_str_len(@str1, @len_str1)     
			select @str4= vv03.dbo.Get_list_str_len(@str4, @len_str4)     
			select @str2= vv03.dbo.Get_list_str_len(@str2, @len_str2)     
			select @str3= vv03.dbo.Get_list_str_len(@str3, @len_str3) 
			
 
    
	end
	
END
GO