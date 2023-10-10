*** Settings ***
Resource          ${EXECDIR}${/}Libraries${/}Browser.resource


*** Keywords ***
Open Acount Creation Page
    [Documentation]    Navigates to the page where the account can be registered
    Click Link    Registreren

Create A New Account
    [Documentation]    Creates a new account. Input: dictionary
    [Arguments]    ${user}
    Open Acount Creation Page
    Fill In New User Data    ${user}

Registration Successful
    Get Text    .result    ==    Uw registratie is afgerond
    Click    css=a >> text="Doorgaan"

Fill In New User Data
    [Documentation]    Fills in the account form (when on the account creation page)
    [Arguments]    ${user}
    Check Checkbox    id=gender-male
    Type Text    id=FirstName    ${user.firstname}
    Type Text    id=LastName    ${user.lastname}
    Type Text    id=Email    ${user.email}
    Select Date Of Birth    ${user}
    Select Newsletter    ${user}
    Type Text    id=Company    ${user.company_name}
    Type Text    id=VatNumber    ${user.vatnr}
    Type Secret    id=Password    $user.password
    Type Secret    id=ConfirmPassword    $user.password
    Click    id=register-button

Select Date Of Birth
    [Arguments]    ${user}
    Select Options By    select[name="DateOfBirthDay"]    label    ${user.birthday_day}
    Select Options By    select[name="DateOfBirthMonth"]    label    ${user.birthday_month}
    Select Options By    select[name="DateOfBirthYear"]    label    ${user.birthday_year}

Select Newsletter
    [Arguments]    ${user}
    IF    ${user.newsletter} != 0    Check Checkbox    id=Newsletter

Access My Account
    Click    css=.header a >> text=Mijn account

Select My Orders
    Access My Account
    Click    css=li.customer-orders a
    Wait For Condition    Text    css=h1    ==    Mijn account - Bestellingen
    # Page Should Contain Element    xpath://h1[(contains(., "Mijn account - Bestellingen"))]

Add Item To Cart
    [Arguments]    ${item} 
    Wait For Elements State    css=h2 a >> text=${item}    enabled
    Click    css=h2 a >> text=${item}
    Type Text  xpath=//*[@id="product_enteredQuantity_4"]  2
    Click    css=.product-essential button >> text=Bestel nu!
    Product Is Added To Cart

Cart Contains Product
    [Arguments]    ${item}
    Hover    css=span[class="cart-label"]
    Get Text    css=div[class="mini-shopping-cart"] .name    ==    ${item}

Product Is Added To Cart
    Get Text    css=div[class="bar-notification success"]    $=    Het product is toegevoegd aan uw winkelwagen
    Wait For Condition    Element Count    css=div[class="bar-notification success"]    ==    0    timeout=15s