CREATE TABLE [dbo].[MobileOrderHold] (
  [MobileOrderHoldID] [int] IDENTITY,
  [ItemGUID] [uniqueidentifier] NULL,
  [PARAMS] [nvarchar](1000) NULL,
  [IsProcessed] [bit] NULL DEFAULT (0),
  [IsCardVerified] [bit] NULL DEFAULT (0),
  [DateTimeAdd] [datetime] NULL CONSTRAINT [DF_MobileOrderHold_DateTimeAdd] DEFAULT (getdate()),
  [CashID] [int] NULL,
  [CashCheckNo] [int] NULL,
  [RemoteIP] [nvarchar](15) NULL
)
ON [PRIMARY]
GO

CREATE INDEX [GUID]
  ON [dbo].[MobileOrderHold] ([ItemGUID])
  INCLUDE ([IsProcessed])
  ON [PRIMARY]
GO

CREATE INDEX [IX_MobileOrderHold_1]
  ON [dbo].[MobileOrderHold] ([DateTimeAdd], [RemoteIP])
  ON [PRIMARY]
GO