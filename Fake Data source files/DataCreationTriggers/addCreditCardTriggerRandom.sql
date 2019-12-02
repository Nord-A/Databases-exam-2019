CREATE TRIGGER addCreditCard
ON TCreditCard
AFTER INSERT AS
BEGIN  
	---- Create the variables for the random number generation
	DECLARE @Random INT;
	DECLARE @Upper INT;
	DECLARE @Lower INT
 
	---- This will create a random number between 1 and 999
	SET @Lower = 1 ---- The lowest random number
	SET @Upper = 2000 ---- The highest random number
	SELECT @Random = ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)
	IF EXISTS(SELECT * FROM TUser WHERE nUserID = @Random)
	BEGIN
    UPDATE 
        -- Set the current userId on the card we are adding to be the same as the cards ID
        TCreditCard SET nUserId = @Random
        -- Select the latest added creditcard by sorting on the auto incremented nCreditCardId and selecting top 1
        WHERE nCreditCardId = (SELECT TOP 1 nCreditCardId FROM TCreditCard
                                ORDER BY nCreditCardId DESC)
        -- Check if the credit card ID exists as a user Id in the Uer table
    
    UPDATE 
        -- Set the current cCardHolder on the card we are adding to be the same as the name and surname of the user 
        -- with the UserId of the creditcard we added above
        TCreditCard SET cCardHolder = (SELECT CONCAT(cName, ' ' , cSurname) FROM TUser
                                       -- Select the latest added creditcard by sorting on the auto incremented nCreditCardId and selecting top 1
                                        WHERE TUser.nUserId = @Random)
                                        
        -- Select the latest added creditcard by sorting on the auto incremented nCreditCardId and selecting top 1
        WHERE nCreditCardId = (SELECT TOP 1 nCreditCardId FROM TCreditCard
                                ORDER BY nCreditCardId DESC);
	END
	ELSE DELETE FROM TCreditCard WHERE nCreditCardId = (SELECT TOP 1 nCreditCardId FROM TCreditCard ORDER BY nCreditCardId DESC);
END;