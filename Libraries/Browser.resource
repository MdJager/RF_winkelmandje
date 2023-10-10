*** Settings ***
Library         Browser
Resource        ${EXECDIR}${/}Resources${/}Environments${/}Webshopsz_test.resource
Resource        ${EXECDIR}${/}Resources${/}Global_Variables.resource
Resource        ${EXECDIR}${/}Resources${/}Testdata/customers.resource

*** Keywords ***
Navigate To The Webshop
    [Documentation]    Opens a browser to the shop url
    Open Shop URL    ${SHOP_URL}

Navigate To The Webshop Admin Page
    [Documentation]    Opens a browser to the admin url
    Open Shop URL    ${ADMIN_URL}

Open Shop URL
    [Arguments]    ${url}
    New Browser    browser=${BROWSER}    args=["--start-maximized"]    headless=${HEADLESS}
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page    url=${url}
    Set Browser Timeout    ${TIMEOUT}
    Click    id=eu-cookie-ok
    Wait Until Network Is Idle

User Is Logged In
    [Documentation]    Verifies that the user is logged in. Input: dictionary
    [Arguments]    ${user}
    Wait For Elements State    css=h2 >> text=Welcome to our store

Click Button: ${name}
    Click    css=button >> text=${name}

Warning Message Is Shown
    [Arguments]    ${message}
    Get Text    css=div.message-error li    ==    ${message}

Login With User
    [Documentation]    Logs in with a registered user. Input: dictionary
    [Arguments]    ${user}
    Open Acount Login Page
    Type Text    id=Email    ${user.email}
    Type Secret    id=Password    $user.password
    Click Button: Inloggen

Login With Admin
    [Documentation]    Logs in with the admin user
    Open Acount Login Page
    Type Text    id=Email    ${admin_account.email}
    Type Secret    id=Password    $admin_account.password
    Click Button: Inloggen

Open Acount Login Page
    [Documentation]    Opens the Returning customers page
    Click Link    Inloggen

Click Link
    [Arguments]    ${name}
    Click    css=a >> text="${name}"
