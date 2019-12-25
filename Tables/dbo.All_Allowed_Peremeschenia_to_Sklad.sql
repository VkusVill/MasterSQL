CREATE TABLE [dbo].[All_Allowed_Peremeschenia_to_Sklad] (
  [id_TT] [int] NULL,
  [ShopNo] [int] NULL,
  [id_tov] [int] NULL,
  [id_kontr] [int] NULL,
  [Kolvo] [decimal](15, 3) NULL
)
ON [PRIMARY]
GO

CREATE INDEX [IX_All_Allowed_Peremeschenia_to_Sklad_1]
  ON [dbo].[All_Allowed_Peremeschenia_to_Sklad] ([id_TT], [ShopNo], [id_tov])
  ON [PRIMARY]
GO