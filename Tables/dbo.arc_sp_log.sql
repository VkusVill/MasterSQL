CREATE TABLE [dbo].[arc_sp_log] (
  [id_job] [int] NOT NULL,
  [number_step] [bigint] NOT NULL,
  [duration] [int] NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_arc_sp_log_date_add] DEFAULT (getdate()),
  [par1] [int] NULL,
  [par2] [int] NULL,
  [par3] [char](50) NULL,
  [par4] [char](50) NULL,
  [par5] [char](50) NULL,
  [date_ins] [datetime] NOT NULL CONSTRAINT [DF_arc_sp_log_date_ins] DEFAULT (getdate())
)
ON [PRIMARY]
GO

CREATE INDEX [ind_for_delete]
  ON [dbo].[arc_sp_log] ([date_ins])
  ON [PRIMARY]
GO