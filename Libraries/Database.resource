*** Settings ***
Library         OperatingSystem
Library         DateTime
Library         DatabaseLibrary
Library         KeePassLibrary
Library         FakerLibrary
Resource        ${EXECDIR}${/}Resources${/}Environments${/}Webshopsz_${ENV}.resource


*** Variables ***
&{KP}             kdbx=${EXECDIR}${/}Resouces${/}Bin${/}Keepass${/}Keepass_db.kdbx    key=keepass_db.key


*** Keywords ***
Connect To Shop DB
    [Documentation]    Connects to the shop database, needed when you want to create, read, update or delete accounts.
    ...                The database user/password is stored in the keepass database.
    Connect To Database    dbConfigFile=${DBCONFIGFILE}

Delete Unique Account If Email Is Registered
    [Documentation]    Deletes an account with specific e-mail
    [Arguments]    ${email}
    [Teardown]    Disconnect From Database
    Log    Verify if a user is present in database with given email `${email}`
    Connect To Shop DB
    ${result}=    Read Unique User Based On Email     ${email}
    ${amount}=    Get Length    ${result}
    Log    If email adress has been registered, remove it
    IF    ${amount} != 0
        Delete Unique User Based On Email    ${email}
    END

Read Unique User Based On Email
    [Documentation]    Selects accounts with given e-mail account from the database
    [Arguments]    ${email}
    ${select_query}=    Set Variable    SELECT * FROM ${DBNAME}.dbo.Customer WHERE Email = '${email}';
    ${result}=    Query    ${select_query}
    [Return]    ${result}

Insert Specific User
    [Documentation]    Inserts a new account into the database. If the account already exists,
    ...                the account is un-deleted if necessary
    [Arguments]    ${customer}
    [Teardown]    Disconnect From Database
    Connect To Shop DB
    # Check if customer already exists
    @{exists}=    Query    SELECT Username, Deleted FROM ${DBNAME}.dbo.Customer WHERE Username = '${customer.username}'    returnAsDict=True
    IF    len(${exists})!=0
           Execute Sql String    UPDATE ${DBNAME}.dbo.Customer SET Deleted = 'False' WHERE Username = '${customer.username}'
           RETURN
    END
    ${uuid}=    FakerLibrary.Uuid 4
    ${datetime}=    Get Current Date
    Execute Sql String    INSERT INTO ${DBNAME}.dbo.Customer (Username, Email, BillingAddress_Id, ShippingAddress_Id, CustomerGuid, IsTaxExempt, AffiliateId, VendorId, HasShoppingCartItems, RequireReLogin, FailedLoginAttempts, Active, Deleted, IsSystemAccount, CreatedOnUtc, LastActivityDateUtc, RegisteredInStoreId) VALUES ('${customer.username}','${customer.email}',7,7,'${uuid}',0,0,0,0,0,0,1,0,0,'${datetime}','${datetime}',1);
    @{customerid}=    Query    SELECT Id FROM ${DBNAME}.dbo.Customer WHERE CustomerGuid='${uuid}'    returnAsDict=True
    Execute Sql String    INSERT INTO ${DBNAME}.dbo.CustomerPassword (CustomerId, Password, PasswordFormatId, PasswordSalt,CreatedOnUtc) VALUES (${customerid}[0][Id], '${customer.password}', 0, NULL, '${datetime}');
    Execute Sql String    INSERT INTO ${DBNAME}.dbo.Customer_CustomerRole_Mapping (Customer_Id, CustomerRole_Id) VALUES (${customerid}[0][Id],3);
    # TODO Uitzoeken waarom dit niet kan:
    # ${insert_query}=    Set Variable    INSERT INTO ${db_shop.db_name}.dbo.GenericAttribute (KeyGroup, Key, Value, EntityId, StoreId) VALUES ('Customer','FirstName','${customer.firstname}',${customerid}[0][Id], 0), ('Customer','LastName','${customer.lastname}',${customerid}[0][Id], 0);
    # Execute Sql String    ${insert_query}

Delete Unique User Based On Email
    [Documentation]    Deletes an account with specific e-mail (account is present)
    [Arguments]    ${email}
    ${delete_query}=    Set Variable    DELETE FROM ${DBNAME}.dbo.Customer WHERE Email = '${email}';
    Execute Sql String    ${delete_query}

Delete All Orders From Specific Customer
    [Documentation]    Deletes all orders from the included customer
    [Arguments]    ${customer}
    [Teardown]    Disconnect From Database
    Connect To Shop DB
    @{id}=   Query    SELECT Id FROM ${DBNAME}.dbo.Customer WHERE Username = '${customer.email}'    returnAsDict=True
    ${delete_query}=    Set Variable    DELETE FROM ${DBNAME}.dbo.ShoppingCartItem WHERE CustomerId = '${id}[0][Id]';
    Execute Sql String    ${delete_query}
