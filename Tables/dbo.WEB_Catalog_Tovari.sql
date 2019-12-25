CREATE TABLE [dbo].[WEB_Catalog_Tovari] (
  [id_tov] [numeric](10) NULL,
  [Name_tov] [nvarchar](150) NOT NULL,
  [id_group] [numeric](10) NULL,
  [Group_name] [nvarchar](150) NULL,
  [id_group_parent] [numeric](10) NULL,
  [Parent_Name] [nvarchar](150) NULL,
  [id_group_parent1] [numeric](10) NULL,
  [Parent_name_1] [nvarchar](150) NULL,
  [CпецЦена] [int] NULL,
  [При покупке] [int] NULL,
  [CпецЦена Описание] [varchar](1000) NULL,
  [rn_gr] [int] NULL,
  [rn_gr_par] [int] NULL,
  [rn_gr_par1] [int] NULL,
  [rn_tov] [int] NULL,
  [sp_price_date_to] [date] NULL,
  [spec_tov] [int] NULL
)
ON [PRIMARY]
GO

CREATE INDEX [IX_id_group]
  ON [dbo].[WEB_Catalog_Tovari] ([id_group], [id_group_parent])
  ON [PRIMARY]
GO

CREATE INDEX [ix_WEB_Catalog_Tovari_id_tov]
  ON [dbo].[WEB_Catalog_Tovari] ([id_tov])
  ON [PRIMARY]
GO