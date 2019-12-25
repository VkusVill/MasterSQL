CREATE TABLE [dbo].[Cards_Discount_Special] (
  [id] [bigint] IDENTITY,
  [number] [char](7) NOT NULL,
  [Phone] [varchar](50) NOT NULL CONSTRAINT [DF_Cards_Discount_Special_Phone] DEFAULT (''),
  [one_time_discount] [bit] NOT NULL CONSTRAINT [DF_Cards_Discount_Special_one_time_discount] DEFAULT (0),
  [id_discount] [int] NOT NULL,
  [discount_proc] [smallint] NOT NULL,
  [date_start] [datetime] NOT NULL,
  [date_end] [datetime] NOT NULL,
  [descr] [varchar](1000) NULL,
  [date_add] [datetime] NOT NULL CONSTRAINT [DF__Cards_Dis__date___0207F583] DEFAULT (getdate()),
  [user_add] [varchar](100) NULL
)
ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [IX_Cards_Discount_Special_1]
  ON [dbo].[Cards_Discount_Special] ([number], [Phone], [date_start], [date_end])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Cards_Discount_Special_2]
  ON [dbo].[Cards_Discount_Special] ([id])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Cards_Discount_Special_3]
  ON [dbo].[Cards_Discount_Special] ([Phone], [one_time_discount], [date_start], [id])
  ON [PRIMARY]
GO