CREATE TABLE [dbo].[pandomat] (
  [id] [int] IDENTITY,
  [term_no] [varchar](20) NULL,
  [address] [varchar](100) NULL,
  [note] [varchar](50) NULL,
  [op_batch_id] [varchar](100) NULL,
  [card_no] [bigint] NULL,
  [vending_time] [datetime] NOT NULL,
  [bar_code] [bigint] NULL,
  [capcity] [int] NULL,
  [weight] [int] NULL,
  [prod_name] [varchar](100) NULL,
  [prod_desc] [varchar](100) NULL,
  [company_name] [varchar](100) NULL,
  [address2] [varchar](100) NULL,
  [bonuscard] [char](7) NULL
)
ON [PRIMARY]
GO