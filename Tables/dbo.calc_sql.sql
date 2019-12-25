CREATE TABLE [dbo].[calc_sql] (
  [sql] [nvarchar](400) NULL,
  [cnt] [bigint] NOT NULL,
  [sum_duration] [varchar](93) NULL,
  [avg_duration] [bigint] NULL,
  [min_duration] [bigint] NULL,
  [max_duration] [bigint] NULL,
  [sum_CPU] [varchar](93) NULL,
  [avg_CPU] [bigint] NULL,
  [min_CPU] [bigint] NULL,
  [max_CPU] [bigint] NULL,
  [sum_reads] [bigint] NULL,
  [min_reads] [bigint] NULL,
  [max_reads] [bigint] NULL,
  [query_plan] [xml] NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF_calc_sql_date_add] DEFAULT (getdate())
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [ind1]
  ON [dbo].[calc_sql] ([sql], [date_add] DESC)
  ON [PRIMARY]
GO

CREATE INDEX [ind2_date_add]
  ON [dbo].[calc_sql] ([date_add] DESC)
  ON [PRIMARY]
GO