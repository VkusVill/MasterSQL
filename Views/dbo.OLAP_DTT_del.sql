SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO



CREATE  VIEW [dbo].[OLAP_DTT_del]
AS
SELECT     date_tt, id_group, id_tt, id_tov, post, digust, spisanie, spisanie_kach, boi, spisanie_dost, akcia, akcia_sms, discount50, discount50_qty, discount50_sms, 
                      discount50_sms_qty, razniza, summa, quantity, price, date_update, vozvrat_pok, peremPlus, peremMinus, tt_format_dtt 
FROM         vv03.dbo.DTT_2014 with(nolock)
union all
SELECT     date_tt, id_group, id_tt, id_tov, post, digust, spisanie, spisanie_kach, boi, spisanie_dost, akcia, akcia_sms, discount50, discount50_qty, discount50_sms, 
                      discount50_sms_qty, razniza, summa, quantity, price, date_update, vozvrat_pok, peremPlus, peremMinus, tt_format_dtt
FROM         vv03.dbo.DTT with(nolock)




GO