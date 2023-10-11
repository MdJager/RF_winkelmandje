*** Settings ***
Resource          ${EXECDIR}${/}Libraries${/}Browser.resource

*** Keywords ***

Navigate To Shopping Cart
    Click  css=.cart-label

Agree To Conditions and Checkout
    Check Checkbox    css=input#termsofservice
    Click    id=checkout
    

Select Guest Logout
    Click    button.checkout-as-guest-button

Enter Guest Customer Information
    Type Text   id=BillingNewAddress_FirstName   ${new_account}[firstname]  
    Type Text   id=BillingNewAddress_LastName   ${new_account}[lastname] 
    Type Text   id=BillingNewAddress_Email   ${new_account}[email] 
    Select Options By   id=BillingNewAddress_CountryId    label    Netherlands  # for Netherlands
    Select Options By   id=BillingNewAddress_StateProvinceId    label    Zuid-Holland  # for Zuid-Holland
    Type Text   id=BillingNewAddress_City   ${new_account}[city] 
    Type Text   id=BillingNewAddress_Address1   ${new_account}[streetaddress] 
    Type Text   id=BillingNewAddress_ZipPostalCode   ${new_account}[zip_postal_code] 
    Type Text   id=BillingNewAddress_PhoneNumber   0612345678

    CLick   id=checkout-step-billing >> css=.new-address-next-step-button

*** Variables ***
${guestCheckoutButton}    button.checkout-as-guest-button