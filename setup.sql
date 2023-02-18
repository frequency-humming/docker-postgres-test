BEGIN;

CREATE TABLE "GuestUser" (
    "Id" VARCHAR(30) NOT NULL,
    "App" VARCHAR(30) NOT NULL,
    "User__c" VARCHAR(30) NOT NULL,
    "Image_Type" VARCHAR(30) NOT NULL,
    "Login_Type" VARCHAR(30) NOT NULL,
    "Created_At" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO "GuestUser" ("Id","App","User__c","Image_Type","Login_Type") VALUES ('tenner','mid journey','humming','Inca','guest user');

CREATE FUNCTION notify_trigger() RETURNS trigger AS $$  
BEGIN  
    PERFORM pg_notify('salesforce', row_to_json(NEW)::text);
    RETURN NEW;
END;  
$$ LANGUAGE plpgsql;

CREATE TRIGGER salesforce AFTER INSERT ON "GuestUser"
    FOR EACH ROW EXECUTE PROCEDURE notify_trigger();

END;