SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO




CREATE  VIEW [dbo].[vw_Lost_sales_2014]
AS
 select  [date_ls]
           ,[id_tt_ls]
           ,[id_tov_ls]
           ,[shopno_ls]
           ,[id_kontr_ls]
           ,[id_kontr_matrix]
           ,[is_matrix]
           ,[sales_ls]
           ,[sales_fact]
           ,[lost1]
           ,[lost2]
           ,[lost3]
           ,[lost6]
           ,[time_0]
           ,[time_0_vz]
           ,[checks_1]
           ,[checks_1_vz]
           ,[checks_2]
           ,[checks_2_vz]
           ,[konost_ls]
           ,[price_ls]
           ,[type_chast]
           ,[chastota]
           ,[id_tov_vz]
           ,[sales_q]
           ,[id_kontr_fp]
           ,[sales_fact_scan]
           from [srv-sql01].[sms_izbenka_arc].dbo.lost_sales as ls with(NOLOCK)





GO