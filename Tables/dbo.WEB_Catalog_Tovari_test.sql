CREATE TABLE [dbo].[WEB_Catalog_Tovari_test] (
  [id_tov] [numeric](10) NULL,
  [Name_tov] [nvarchar](150) NOT NULL,
  [id_group] [numeric](14) NULL,
  [Group_name] [nvarchar](150) NULL,
  [id_group_parent] [numeric](14) NULL,
  [Parent_Name] [nvarchar](150) NULL,
  [id_group_parent1] [numeric](10) NULL,
  [Parent_name_1] [nvarchar](150) NULL,
  [CпецЦена] [numeric](15) NULL,
  [При покупке] [int] NULL,
  [CпецЦена Описание] [varchar](53) NULL,
  [rn_gr] [numeric](11) NULL,
  [rn_gr_par] [numeric](11) NULL,
  [rn_gr_par1] [numeric](11) NULL,
  [rn_tov] [bigint] NULL,
  [sp_price_date_to] [date] NULL,
  [spec_tov] [int] NOT NULL
)
ON [PRIMARY]
GO