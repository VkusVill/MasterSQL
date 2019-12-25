CREATE TABLE [dbo].[Lost_sales_hour] (
  [date_ls] [date] NOT NULL,
  [id_tt_ls] [int] NOT NULL,
  [id_tov_ls] [int] NOT NULL,
  [shopno_ls] [int] NULL,
  [day_week] AS (datepart(weekday,[date_ls])),
  [day_week_str] AS (datename(weekday,[date_ls])),
  [sales_fact] [real] NOT NULL,
  [hour_ls] [tinyint] NOT NULL,
  CONSTRAINT [IX_Lost_sales] PRIMARY KEY CLUSTERED ([date_ls], [id_tt_ls], [id_tov_ls], [hour_ls])
)
ON [PRIMARY]
GO

CREATE INDEX [NonClusteredIndex-20191205-122346]
  ON [dbo].[Lost_sales_hour] ([id_tov_ls], [sales_fact], [hour_ls])
  ON [PRIMARY]
GO