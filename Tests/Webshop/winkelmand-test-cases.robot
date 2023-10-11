*** Settings ***
Resource        ${EXECDIR}${/}Resources${/}Webshop.resource

Force Tags      regression

*** Variables ***

${item}    Apple MacBook Pro 13-inch
${number_of_items}    -2

*** Test Cases ***

Test case 1

    Winkelmand vullen    ${item}    ${number_of_items}
    Item in winkelmand check
    Navigate To Shopping Cart
    


*** Keywords ***

Add Items To Cart
    [Arguments]    ${item}    ${number_of_items}
    Wait For Elements State    css=h2 a >> text=${item}    enabled
    Click    css=h2 a >> text=${item}
    fill Text  xpath=//*[@id="product_enteredQuantity_4"]  ${number_of_items}
    Click    css=.product-essential button >> text=Bestel nu!

Winkelmand vullen
    [Arguments]    ${item}    ${number_of_items}
    Navigate To The Webshop
    Add Items To Cart    ${item}    ${number_of_items}



Check of winkelwagen leeg is
    Get Text    xpath=/html/body/div[6]/div[3]    ==    Uw winkelwager is leeg!

Check of prijs klopt
    ${bedrag_product}    Get Text    xpath=//*[@id="price-value-4"]

Item in winkelmand check
    Get Text    xpath=/html/body/div[6]/div[1]/div[1]/div[2]/div[1]/ul/li[4]/a/span[2]    !=    0