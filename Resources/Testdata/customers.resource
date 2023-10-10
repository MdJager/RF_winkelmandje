*** Settings ***
Documentation     Dictionaries for the accounts of the (to be) registered visitors.

*** Variables ***
&{admin_account}         username=dyon.vermeulen@bartosz.nl       email=dyon.vermeulen@bartosz.nl       password=bartosz      firstname=Dyon      lastname=Vermeulen
&{registered_account}    username=rein.hochstenbach@bartosz.nl    email=rein.hochstenbach@bartosz.nl    password=bartosz      firstname=Rein      lastname=Hochstenbach    telephone=123456789    newsletter=${1}
&{new_account}           username=johnny@fab.fr                   email=johnny@fab.fr                   password=Wachtwrd1    firstname=Johnny    lastname=Fabulous
...                      birthday_day=10                          birthday_month=oktober                birthday_year=1971    company_name=Fabulous Inc    vatnr=123456789    newsletter=${1}
...                      streetaddress=waterway 8                 zip_postal_code=1234 AB               county=Zuid Holland   city=Den Haag       country=Netherlands
&{insert_account}        username=Insert                          email=insert@bartosz.nl               password=654321
