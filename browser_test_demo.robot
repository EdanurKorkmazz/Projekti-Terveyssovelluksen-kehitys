*** Settings ***
Documentation     Testaa Web form-esimerkkisivun eri kenttien toimintaa
Library           Browser    auto_closing_level=KEEP
Resource          Keywords.robot

*** Test Cases ***
Test Web Form
    New Browser    chromium    headless=No  
    New Page       https://www.selenium.dev/selenium/web/web-form.html 
    Get Title      ==    Web form  
    
    # Perustekstikentät
    Type Text      [name="my-text"]        ${Username}    delay=0.1 s 
    Type Secret    [name="my-password"]    $Password      delay=0.1 s
    Type Text      [name="my-textarea"]    ${Message}     delay=0.1 s
    
    # Pudotusvalikko (select)
    Select Options By    select[name="my-select"]    text    Two
    
    # Datalist-elementti
    Type Text      [name="my-datalist"]    San Francisco    delay=0.1 s
    
    # Valintaruutu (checkbox)
    Check Checkbox    id=my-check-1
    
    # Radiopainike (radio button)
    Check Checkbox    id=my-radio-1
    
    # Lomakkeen lähetys
    Click With Options    button    delay=2 s
    Get Text       id=message    ==    Received!