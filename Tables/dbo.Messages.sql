CREATE TABLE [dbo].[Messages] (
  [ID] [int] IDENTITY,
  [MsgText] [nvarchar](4000) NULL,
  [CashierID] [int] NOT NULL,
  [DateTimeAdd] [datetime] NULL CONSTRAINT [DF_Messages_DateTimeAdd] DEFAULT (getdate()),
  [Delivered] [datetime] NULL,
  [CashID] [int] NULL,
  CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

CREATE INDEX [Cashier]
  ON [dbo].[Messages] ([CashierID], [Delivered])
  ON [PRIMARY]
GO