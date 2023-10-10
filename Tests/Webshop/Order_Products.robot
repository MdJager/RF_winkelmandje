*** Settings ***
Resource        ${EXECDIR}${/}Resources${/}Webshop.resource

Force Tags      regression


*** Test Cases ***
Macbook bestellen
    [Documentation]    Simpele bestelling zonder de extra opties
    [Tags]    bestellen    regressie
    Navigate To The Webshop
    Add Item To Cart    Apple MacBook Pro 13-inch
    Navigate To Shopping Cart
    Agree To Conditions and Checkout
    Select Guest Logout
    Enter Guest Customer Information
    #Enter Order Information
    #Confirm Order
