CREATE TRIGGER addCreditCard
ON TCreditCard
AFTER INSERT AS
BEGIN  
    UPDATE 
        TCreditCard SET nUserId = nCreditCardId
        WHERE nCreditCardId = (SELECT TOP 1 nCreditCardId FROM TCreditCard
                                ORDER BY nCreditCardId DESC);
    
    UPDATE 
        TCreditCard SET cCardHolder = (SELECT CONCAT(cName, ' ' , cSurname) FROM TUser
                                        WHERE TUser.nUserId = (SELECT TOP 1 nCreditCardId FROM TCreditCard
                                                                ORDER BY nCreditCardId DESC))
        WHERE nCreditCardId = (SELECT TOP 1 nCreditCardId FROM TCreditCard
                                ORDER BY nCreditCardId DESC);
END;
