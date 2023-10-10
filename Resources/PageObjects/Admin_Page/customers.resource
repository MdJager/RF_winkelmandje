*** Settings ***
Library           String
Resource          ${EXECDIR}${/}Libraries${/}Browser.resource


** Variables ***
${klanten}    Admin/Customer/List


*** Keywords ***
Edit customer
    [Documentation]    Puts a check mark to the desired customer. Input: dictionary
    [Arguments]    ${customer}
    Get Element States   css=tr >> text=${customer.email}    contains    visible
    Click    //tbody/tr[contains(., "${customer.email}")]//a

Delete selected customer
    [Documentation]    Clicks the delete button
    Wait For Condition    Element States    id=customer-delete    contains    visible
    Click    id=customer-delete
    Click Button: Verwijder

Delete customer with name
    [Documentation]    Removes the account from the database. Input: dictionary
    [Arguments]    ${customer}
    Select From Navigation    ${klanten}
    Search customer by email    ${customer}
    Edit customer    ${customer}
    Delete selected customer
    Get Text    css=div.alert-success    $=    De klant is met succes verwijderd

Search customer by email
    [Arguments]    ${customer}
    # Wait For Condition    Element States    id=SearchEmail    contains    visible
    Type Text    id=SearchEmail    ${customer.email}
    Click Button: Zoek

Select from navigation
    [Documentation]    Select an option from the left menu
    [Arguments]    ${url} 
    Go To    ${SHOP_URL}/${url}
    Wait For Condition    Text    css=h1.float-left    ==    Klanten
