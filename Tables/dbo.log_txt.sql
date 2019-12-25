CREATE TABLE [dbo].[log_txt] (
  [date_add] [datetime] NULL,
  [nvaCardNum] [nvarchar](10) NULL,
  [number] [char](7) NULL,
  [txtScreen] [nvarchar](max) NULL,
  [txtPrint] [nvarchar](max) NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO