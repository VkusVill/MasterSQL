CREATE TABLE [dbo].[Cards_Discount_Special_use] (
  [id] [bigint] IDENTITY,
  [id_cards_discount] [bigint] NOT NULL,
  [Cashid] [bigint] NOT NULL,
  [CheckNo] [bigint] NOT NULL,
  [closedate] [datetime] NOT NULL,
  [date_add] [datetime] NOT NULL
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Cards_Discount_Special_use_1]
  ON [dbo].[Cards_Discount_Special_use] ([id_cards_discount])
  ON [PRIMARY]
GO