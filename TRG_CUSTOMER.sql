CREATE OR REPLACE TRIGGER TRG_CUSTOMER
BEFORE INSERT OR UPDATE ON CUSTOMER
FOR EACH ROW 
DECLARE
BEGIN

     IF (:NEW.CREDITS < 0) THEN 
        RAISE_APPLICATION_ERROR (-20005, 'The credits ' || :NEW.CREDITS || 'has to be greater or equal to 0'); 
    END IF; 


    IF (:NEW.BIRTHDATE >= SYSDATE) THEN  
        raise_application_error (-20006, 'The birthdate ' || :new.BIRTHDATE || 'must be below the current date'); 
    END IF;
    

    
    IF (UPDATING) THEN    
      IF(:old.BIRTHDATE <> :NEW.BIRTHDATE) THEN 
        RAISE_APPLICATION_ERROR(-20007, 'The birthdate' || :NEW.BIRTHDATE || 'cannot be updated - NO CHANGE'); 
      END IF; 
    END IF;
    
    IF (:NEW.EMAIL <> '%@%') THEN 
       RAISE_APPLICATION_ERROR (-20008, 'The email ' || :NEW.EMAIL ||  'must contain the character @'); 
    END IF;  
    
END TRG_CUSTOMER;

