-- This trigger will be discarded after adding one (1) credit card to each user

CREATE TRIGGER addCreditCard
ON TCreditCard
AFTER INSERT AS
BEGIN  
    UPDATE 
        -- Set the current user ID on the card we are adding to be the same as the cards ID
        TCreditCard SET nUserId = nCreditCardId
        -- 
        WHERE nCreditCardId = (SELECT TOP 1 nCreditCardId FROM TCreditCard
                                ORDER BY nCreditCardId DESC);
    
    UPDATE 
        TCreditCard SET cCardHolder = (SELECT CONCAT(cName, ' ' , cSurname) FROM TUser
                                        WHERE TUser.nUserId = (SELECT TOP 1 nCreditCardId FROM TCreditCard
                                                                ORDER BY nCreditCardId DESC))
        WHERE nCreditCardId = (SELECT TOP 1 nCreditCardId FROM TCreditCard
                                ORDER BY nCreditCardId DESC);
END;
