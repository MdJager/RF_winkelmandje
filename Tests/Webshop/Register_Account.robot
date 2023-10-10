*** Settings ***
Resource          ${EXECDIR}${/}Resources${/}Webshop.resource
Force Tags        Regression


*** Test Cases ***
As a customer I can create a new account when it has not been registered
    [Setup]    Delete Unique Account If Email Is Registered    ${new_account}[email]
    Navigate To The Webshop
    Create A New Account    ${new_account}
    Registration Successful
    User Is Logged In    ${new_account}

As a customer I recieve an error when email has been registered for an account
    Navigate To The Webshop
    Create A New Account    ${new_account}
    Warning Message Is Shown    Het ingevoerde emailadres bestaat al

As a customer I want to see my previous orders
    [Setup]    Insert Specific User    ${registered_account}
    Navigate To The Webshop
    Login With User    ${registered_account}
    Access My Account
    Select My Orders

As a customer I want to add an item to my shopping basket
    [Tags]  Bestellen
    [Setup]    Run Keywords    Insert specific user    ${registered_account}    AND    Delete All Orders From Specific Customer    ${registered_account}
    Navigate To The Webshop
    Login With User    ${registered_account}
    Add Item To Cart    Apple MacBook Pro 13-inch
    Cart Contains Product    Apple MacBook Pro 13-inch
