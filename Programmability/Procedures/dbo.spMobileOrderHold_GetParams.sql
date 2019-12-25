SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spMobileOrderHold_GetParams]
	@UUID [uniqueidentifier]
	,@CashCheckNo [INT]
	,@PARAMS [nvarchar](1000) = '' OUTPUT
	,@IsCardVerified INT = 0 OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT @PARAMS = [PARAMS], @IsCardVerified = IsCardVerified FROM [frontol].[dbo].[MobileOrderHold] (NOLOCK) WHERE [ItemGUID] = @UUID AND [IsProcessed] = 1
	IF @PARAMS <> ''
	BEGIN
		UPDATE [frontol].[dbo].[MobileOrderHold] SET CashCheckNo = @CashCheckNo WHERE [ItemGUID] = @UUID
	END
END
GO