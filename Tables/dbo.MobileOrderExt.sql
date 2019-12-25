CREATE TABLE [dbo].[MobileOrderExt] (
  [ItemGUID] [uniqueidentifier] NOT NULL,
  [PARAMS] [nvarchar](1000) NULL,
  [DateTimeAdd] [datetime] NOT NULL CONSTRAINT [DF_MobileOrderExt_DateTimeAdd] DEFAULT (getdate()),
  [CashId] [int] NULL,
  [CashCheckNo] [int] NULL,
  [ExtNumber] [nvarchar](50) NULL,
  [ExtProvider] [nvarchar](50) NULL
)
ON [PRIMARY]
GO