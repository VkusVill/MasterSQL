CREATE TABLE [dbo].[sp_log] (
  [id_job] [int] NOT NULL,
  [number_step] [bigint] NOT NULL,
  [duration] [int] NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_sp_log_date_add] DEFAULT (getdate()),
  [par1] [int] NULL,
  [par2] [int] NULL,
  [par3] [char](50) NULL,
  [par4] [char](50) NULL,
  [par5] [char](50) NULL
)
ON [PRIMARY]
GO

CREATE INDEX [ind1]
  ON [dbo].[sp_log] ([id_job], [number_step], [par1], [par2])
  INCLUDE ([date_add], [par3], [par4])
  ON [PRIMARY]
GO

CREATE INDEX [ind2O]
  ON [dbo].[sp_log] ([id_job], [number_step], [par3])
  INCLUDE ([date_add])
  ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [IX_sp_log]
  ON [dbo].[sp_log] ([date_add])
  ON [PRIMARY]
GO

CREATE INDEX [key_sp_logO)]
  ON [dbo].[sp_log] ([id_job], [number_step], [par1], [par2], [par3])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: 2016-02-24
-- Description:	Перенос удаленных записей в архив
-- =============================================
CREATE TRIGGER [del_log] 
   ON  [dbo].[sp_log]
   AFTER Delete
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO [vv03].[dbo].[arc_sp_log]
           ([id_job]
           ,[number_step]
           ,[duration]
           ,[date_add]
           ,[par1]
           ,[par2]
           ,[par3]
           ,[par4]
           ,[par5])

SELECT [id_job]
      ,[number_step]
      ,[duration]
      ,[date_add]
      ,[par1]
      ,[par2]
      ,[par3]
      ,[par4]
      ,[par5]
  FROM deleted
  


END
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: 2016-02-24
-- Description:	Перенос записей об неправильной установке ЛП в таблицу jobs..Err_Set_LP_trigger для организации рассылки
-- =============================================

CREATE TRIGGER [ins_log]
ON [dbo].[sp_log]
AFTER INSERT
AS
BEGIN
  SET NOCOUNT ON;

  INSERT INTO [jobs].[dbo].[Err_Set_LP_trigger] (
    [id_job],
    [number_step],
    [duration],
    [date_add],
    [CashID],
    [CheckNumber],
    [number],
    [id_tov],
    [MaxOst]
  )
  SELECT
    [id_job],
    [number_step],
    [duration],
    [date_add],
    [par1],
    [par2],
    [par3],
    [par4],
    [par5]
  FROM inserted
  WHERE id_job = -20
        AND number_step = -17
END
GO