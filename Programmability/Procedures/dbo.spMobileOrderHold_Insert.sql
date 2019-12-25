SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spMobileOrderHold_Insert]
  @uiGUID uniqueidentifier,
  @nvaPARAMS nvarchar(1000),
  @bitIsCardVerified bit,
  @nvaRemoteIP nvarchar(15)
AS
UPDATE
  MobileOrderHold
SET
  PARAMS = @nvaPARAMS,
  IsProcessed = 1,
  IsCardVerified = @bitIsCardVerified,
  RemoteIP = @nvaRemoteIP
WHERE ItemGUID = @uiGUID
      AND IsProcessed = 0

BEGIN TRY
  DECLARE @ExtProvider nvarchar(50) = N'YaC'
  DECLARE @CharPos int = CHARINDEX(@ExtProvider, @nvaPARAMS)

  IF @CharPos = 0
  BEGIN
	SET @ExtProvider = N'PaS'
	SET @CharPos = CHARINDEX(@ExtProvider, @nvaPARAMS)
  END

  IF @CharPos > 0
  BEGIN
    INSERT INTO [MobileOrderExt] (
      [ItemGUID],
      [PARAMS],
      [CashId],
      [CashCheckNo],
      [ExtNumber],
      [ExtProvider]
    )
    SELECT
      ItemGUID,
      @nvaPARAMS,
      CashID,
      CashCheckNo,
      SUBSTRING(@nvaPARAMS, @CharPos, CHARINDEX('"', SUBSTRING(@nvaPARAMS, @CharPos, 100)) - 1),
      @ExtProvider
    FROM MobileOrderHold
    WHERE ItemGUID = @uiGUID
  END
END TRY
BEGIN CATCH
  INSERT jobs..error_jobs (
    id_job,
    message,
    number_step,
    date_add
  )
  SELECT
    555,
    ERROR_MESSAGE(),
    100,
    GETDATE()
END CATCH
GO