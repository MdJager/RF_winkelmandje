*** Settings ***
Resource        ${EXECDIR}${/}Resources${/}Webshop.resource

Force Tags      regression


*** Test Cases ***
Winkelmand - toevoegen van n producten
    [Documentation]    Bestelling van 2 producten, waarbij de producten weer worden verwijderd 
    [Tags]    bestellen    regressie
    Winkelmand vullen    Apple MacBook Pro 13-inch    -2
    Product Is Added To Cart

 

Winkelmand - negatief aantal producten
    [Documentation]    Er wordt geprobeerd een product te bestellen met een negatief (-1) aantal producten
    [Tags]    bestellen    regressie
    Winkelmand vullen    Apple MacBook Pro 13-inch    1
    Get Text    xpath=//*[@id="bar-notification"]/div/p[2]    ==    Dit product is vereist in een hoeveelheid van 0
    


Winkelmand - nul producten
    [Documentation]    Er wordt geprobeerd een product te bestellen met nul producten
    [Tags]    bestellen    regressie
    Winkelmand vullen    Apple MacBook Pro 13-inch    0
    # Get Text    css=div.message-error li    ==    ${Dit product is vereist in een hoeveelheid van 0}
    Get Text    xpath=//*[@id="bar-notification"]/div   ==    Het minimum aantal voor een bestelling is 2




Verwijderen van product
    [Documentation]    Deze test voegt producten aan een winkelmand toe en verwijdert die weer
    [Tags]    verwijderen    regressie
    Winkelmand vullen    Apple MacBook Pro 13-inch    -2
    Product Is Added To Cart
    Navigate To Shopping Cart
    Click    xpath=/html/body/div[6]/div[3]/div/div/div/div[2]/div/form/div[1]/table/tbody/tr/td[7]    # check id na bugfix
    Get Url    ==    https://testnopcommerce.azurewebsites.net/cart
    #Check of winkelwagen leeg is

Product hoeveelheid aanpassen 
    [Documentation]    Deze test past de hoeveelheid producten aan als er al een product in de winkelwagen zit
    [Tags]    aanpassen    regressie
    Winkelmand vullen    Apple MacBook Pro 13-inch    -4
    Product Is Added To Cart
    Navigate To Shopping Cart
    Fill Text    xpath=/html/body/div[6]/div[3]/div/div/div/div[2]/div/form/div[1]/table/tbody/tr/td[5]    2
    
    


*** Keywords ***

Add Items To Cart
    [Arguments]    ${item}    ${number_of_items}
    Wait For Elements State    css=h2 a >> text=${item}    enabled
    Click    css=h2 a >> text=${item}
    Type Text  xpath=//*[@id="product_enteredQuantity_4"]  ${number_of_items}
    Click    css=.product-essential button >> text=Bestel nu!

Winkelmand vullen
    [Arguments]    ${item}    ${number_of_items}
    Navigate To The Webshop
    Add Items To Cart    ${item}    ${number_of_items}



Check of winkelwagen leeg is
    Get Text    xpath=/html/body/div[6]/div[3]    ==    Uw winkelwager is leeg!

Check of prijs klopt
    ${bedrag_product}    Get Text    xpath=//*[@id="price-value-4"]
