CREATE TABLE [dbo].[Types_Operation] (
  [table_operation] [nchar](50) NOT NULL,
  [field_operation] [nchar](50) NOT NULL,
  [code_operation] [int] NOT NULL,
  [name_operation] [nchar](30) NOT NULL,
  [type_operation] [int] NOT NULL,
  [znak] [smallint] NOT NULL,
  [for_user_vv] [smallint] NOT NULL,
  [row_rep] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Types_Operation_row_rep] DEFAULT (newid()),
  [type_ch] [smallint] NULL,
  [is_photo] [smallint] NOT NULL CONSTRAINT [DF_Types_Operation_is_photo] DEFAULT (0),
  CONSTRAINT [PK_Types_Operation] PRIMARY KEY CLUSTERED ([table_operation], [field_operation], [code_operation])
)
ON [PRIMARY]
GO