CREATE TABLE [dbo].[error_jobs] (
  [job_name] [sysname] NOT NULL,
  [message] [nvarchar](max) NULL,
  [run_date] [int] NULL,
  [run_time] [int] NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_error_jobs_date_add] DEFAULT (getdate()),
  [number_step] [int] NULL,
  [query_err] [nvarchar](max) NULL,
  [id_job] [int] NULL,
  [id_err] [int] IDENTITY
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO