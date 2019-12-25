CREATE TABLE [dbo].[sp_log_New] (
  [id_job] [int] NOT NULL,
  [number_step] [bigint] NOT NULL,
  [duration] [int] NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_sp_log_date_addNew] DEFAULT (getdate()),
  [par1] [int] NULL,
  [par2] [int] NULL,
  [par3] [char](50) NULL,
  [par4] [char](50) NULL,
  [par5] [char](50) NULL
)
ON [PRIMARY]
GO

CREATE INDEX [ind1]
  ON [dbo].[sp_log_New] ([id_job], [number_step], [par1], [par2])
  INCLUDE ([date_add], [par3], [par4])
  ON [PRIMARY]
GO

CREATE INDEX [ind2]
  ON [dbo].[sp_log_New] ([id_job], [number_step], [par3])
  INCLUDE ([date_add])
  ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [IX_sp_log_3]
  ON [dbo].[sp_log_New] ([date_add])
  ON [PRIMARY]
GO

CREATE INDEX [key_sp_log]
  ON [dbo].[sp_log_New] ([id_job], [number_step], [par1], [par2], [par3])
  ON [PRIMARY]
GO