CREATE TABLE [dbo].[SBQRPay_trn] (
  [SBQRPayID] [int] IDENTITY,
  [CashID] [int] NULL,
  [CashCheckNo] [int] NULL,
  [OrderId] [nvarchar](50) NULL,
  [DateTimeAdd] [datetime] NOT NULL CONSTRAINT [DF_SBQRPay_trn_DateTimeAdd] DEFAULT (getdate()),
  [Status] [int] NULL
)
ON [PRIMARY]
GO