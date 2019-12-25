CREATE TABLE [dbo].[Cards_Settings] (
  [number] [char](7) NOT NULL,
  [Cashier_communication] [int] NOT NULL CONSTRAINT [DF_Cards_Settings_Cashier_communication] DEFAULT (0),
  [Send_check_BOT] [int] NULL CONSTRAINT [DF_Cards_Settings_Send_check_BOT] DEFAULT (1),
  [DontAsk_LP] [smallint] NULL CONSTRAINT [DF_Cards_Settings_DontAsk_LP] DEFAULT (0),
  [Not_abonement_category] [varchar](100) NULL CONSTRAINT [DF_Cards_Settings_Not_abonement_category] DEFAULT ('0|0'),
  [distribution_service] [int] NULL CONSTRAINT [DF_Cards_Settings_distribution_service] DEFAULT (1),
  [distribution_action] [int] NULL CONSTRAINT [DF_Cards_Settings_distribution_action] DEFAULT (1),
  [distribution_tema] [int] NULL CONSTRAINT [DF_Cards_Settings_distribusion_tema] DEFAULT (1),
  [id_region] [int] NULL CONSTRAINT [DF_Cards_Settings_id_region] DEFAULT (1),
  [chosen_shops] [varchar](100) NULL,
  [date_change] [datetime] NULL DEFAULT (getdate()),
  [send_into] [smallint] NULL DEFAULT (0),
  [distribution_poll] [smallint] NULL DEFAULT (1),
  [offer_for_Wallet] [bit] NOT NULL DEFAULT (0),
  [city] [varchar](250) NOT NULL DEFAULT ('')
)
ON [PRIMARY]
GO

CREATE INDEX [idx_cards_setting_ditributions]
  ON [dbo].[Cards_Settings] ([distribution_service], [distribution_action], [distribution_tema])
  ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [PK_Cards_Settings]
  ON [dbo].[Cards_Settings] ([number])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: 2017-06-15
-- Description:	Установка значений по умолчанию вместо пустых значений
-- =============================================
CREATE TRIGGER [upd_Cards_settings]
   ON  [dbo].[Cards_Settings]
   AFTER INSERT,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

update vv03..cards_settings with(rowlock) set Not_abonement_category='0'
from vv03..cards_Settings as cs inner join inserted as i on cs.number=i.number
where isnull(i.Not_abonement_category,'')='' 

update vv03..cards_settings with(rowlock) set Cashier_communication=0
from vv03..cards_Settings as cs inner join inserted as i on cs.number=i.number
where i.Cashier_communication is null

update vv03..cards_settings with(rowlock) set Send_check_BOT=1
from vv03..cards_Settings as cs inner join inserted as i on cs.number=i.number
where i.Send_check_BOT is null

update vv03..cards_settings with(rowlock) set DontAsk_LP=0
from vv03..cards_Settings as cs inner join inserted as i on cs.number=i.number
where i.DontAsk_LP is null

update vv03..cards_settings with(rowlock) set DontAsk_LP=0
from vv03..cards_Settings as cs inner join inserted as i on cs.number=i.number
where i.DontAsk_LP is null

update vv03.dbo.cards_settings with(rowlock)
   set date_change = getdate()
  from vv03.dbo.cards_Settings as cs
 inner join inserted as i
         on cs.number = i.number

END
GO