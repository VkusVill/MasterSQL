CREATE TABLE [dbo].[arc_Cards_coupon] (
  [Number] [nchar](7) NOT NULL,
  [Tovari_str] [nvarchar](max) NULL,
  [Cupon_str] [nvarchar](max) NULL,
  [Prices_str] [nvarchar](max) NULL,
  [Date_coup_from] [date] NULL,
  [Date_coup_to] [date] NULL,
  [date_ins] [datetime] NOT NULL CONSTRAINT [DF_arc_Cards_coupon_date_ins] DEFAULT (getdate()),
  [LovePr_today_str] [nvarchar](max) NULL,
  [LovePr_tomor_str] [nvarchar](max) NULL,
  [Date_LovePr_to] [date] NULL,
  [proc_sk_ab] [int] NULL,
  [proc_sk_lt] [int] NULL,
  [id] [bigint] IDENTITY,
  CONSTRAINT [PK_arc_Cards_coupon] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO