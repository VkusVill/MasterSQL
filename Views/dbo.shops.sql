SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO







CREATE view [dbo].[shops] as
      select id_TT,
             name_TT,
             N,
             N as ShopNo,
             tt_format,
             adress as addr,
             ISNULL(kids_room ,0) as kids_room,
             -- Адрес для отображения в боте
             (case tt_format when 1 then 'Изб, '
                             when 2 then 'ВВ, ' end) 
                + adress
                + (case when RTrim(isnull([Hours],'')) = '' then '' else char(10) end)
                + rtrim([Hours]) as adress,
             [Hours] as hours_working,
             dolgota,
             shirota,
             ISNULL(tt.PublishContacts, 0) as PublishContacts,
             instamart,
             savetime,
             fresh_juice,
             coffee,
             bakery
        from vv03.dbo.tt as tt with(nolock)
       where is_active = 1
         and tt_format = 2
         and type_tt = 'торговая'
         and [Статус] in ('Открыт', 'Скоро закрытие')
        





GO