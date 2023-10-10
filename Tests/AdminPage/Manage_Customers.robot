*** Settings ***
Resource        ${EXECDIR}${/}Resources${/}Admin_Page.resource
Resource        ${EXECDIR}${/}Resources${/}Testdata${/}customers.resource
Force Tags      Regression


**** Test Cases ***
As an admin I want to be able to remove customers
    [Tags]    test
    [Setup]    Insert Specific User    ${insert_account}
    Navigate To The Webshop Admin Page
    Login With Admin
    Delete Customer With Name    ${insert_account}
