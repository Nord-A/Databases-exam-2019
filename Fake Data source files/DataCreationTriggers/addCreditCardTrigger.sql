-- This trigger will be discarded after adding one (1) credit card to each user

CREATE TRIGGER addCreditCard
ON TCreditCard
AFTER INSERT AS
BEGIN  
	IF EXISTS(SELECT * FROM TUser WHERE nUserID = (SELECT TOP 1 nCreditCardId FROM TCreditCard ORDER BY nCreditCardId DESC))
	BEGIN
    UPDATE 
        -- Set the current userId on the card we are adding to be the same as the cards ID
        TCreditCard SET nUserId = nCreditCardId
        -- Select the latest added creditcard by sorting on the auto incremented nCreditCardId and selecting top 1
        WHERE nCreditCardId = (SELECT TOP 1 nCreditCardId FROM TCreditCard
                                ORDER BY nCreditCardId DESC)
        -- Check if the credit card ID exists as a user Id in the Uer table
    
    UPDATE 
        -- Set the current cCardHolder on the card we are adding to be the same as the name and surname of the user 
        -- with the UserId of the creditcard we added above
        TCreditCard SET cCardHolder = (SELECT CONCAT(cName, ' ' , cSurname) FROM TUser
                                       -- Select the latest added creditcard by sorting on the auto incremented nCreditCardId and selecting top 1
                                        WHERE TUser.nUserId = (SELECT TOP 1 nCreditCardId FROM TCreditCard
                                                                ORDER BY nCreditCardId DESC))
                                        
        -- Select the latest added creditcard by sorting on the auto incremented nCreditCardId and selecting top 1
        WHERE nCreditCardId = (SELECT TOP 1 nCreditCardId FROM TCreditCard
                                ORDER BY nCreditCardId DESC);
	END
	ELSE DELETE FROM TCreditCard WHERE nCreditCardId = (SELECT TOP 1 nCreditCardId FROM TCreditCard ORDER BY nCreditCardId DESC);
END;
