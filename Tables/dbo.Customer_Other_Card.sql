CREATE TABLE [dbo].[Customer_Other_Card] (
  [number] [char](7) NOT NULL,
  [Number_other] [varchar](30) NULL,
  [id_type] [int] NOT NULL,
  CONSTRAINT [PK_Customer_Other_Card] PRIMARY KEY CLUSTERED ([number])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Customer_Other_Card]
  ON [dbo].[Customer_Other_Card] ([Number_other], [id_type])
  INCLUDE ([number])
  ON [PRIMARY]
GO