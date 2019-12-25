CREATE TABLE [dbo].[MobileOrderHold_fix] (
  [MobileOrderHoldID] [int] NOT NULL,
  [ItemGUID] [uniqueidentifier] NULL,
  [PARAMS] [nvarchar](1000) NULL,
  [IsProcessed] [bit] NULL,
  [IsCardVerified] [bit] NULL,
  [DateTimeAdd] [datetime] NULL,
  [CashID] [int] NULL,
  [CashCheckNo] [int] NULL,
  [RemoteIP] [nvarchar](15) NULL
)
ON [PRIMARY]
GO