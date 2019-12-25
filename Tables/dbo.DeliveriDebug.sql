CREATE TABLE [dbo].[DeliveriDebug] (
  [ID] [int] IDENTITY,
  [CashID] [int] NULL,
  [CashChequeNo] [int] NULL,
  [DeliveriOrderNo] [nvarchar](50) NULL,
  [DateTimeAdd] [datetime] NULL CONSTRAINT [DF_DeliveryDebug_DateTimeAdd] DEFAULT (getdate()),
  [GUID] [uniqueidentifier] NULL,
  CONSTRAINT [PK_DeliveriDebug] PRIMARY KEY NONCLUSTERED ([ID])
)
ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [ClusteredIndex-20181203-185916]
  ON [dbo].[DeliveriDebug] ([DeliveriOrderNo])
  ON [PRIMARY]
GO