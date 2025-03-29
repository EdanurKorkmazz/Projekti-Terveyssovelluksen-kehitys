*** Settings ***
Documentation     Testi uuden päiväkirjamerkinnän tekemiseen OloHetki-sovelluksessa
Library           Browser    auto_closing_level=KEEP
Resource          Keywords.robot

*** Test Cases ***
Lisää Uusi Päiväkirjamerkintä
    # Avaa selain ja kirjaudu
    New Browser    chromium    headless=No
    Kirjaudu Sisään
    
    # Siirry päiväkirjasivulle
    Click    text=Päiväkirja
    Wait For Elements State    h1    visible
    Get Text    h1    ==    Tunnepäiväkirja
    
    # Täytä päiväkirjamerkintä
    Fill Text    id=situation    Testaus Robot Frameworkilla
    Fill Text    id=emotion    Keskittynyt ja kiinnostunut
    
    # Valitse ahdistuksen taso
    ${anxiety_level}=    Set Variable    2
    Check Checkbox    css=[name="anxiety"][value="${anxiety_level}"]
    
    # Valitse stressin taso
    ${stress_level}=    Set Variable    3
    Check Checkbox    css=[name="stress"][value="${stress_level}"]
    
    # Valitse paniikin taso
    ${panic_level}=    Set Variable    1
    Check Checkbox    css=[name="panic"][value="${panic_level}"]
    
    # Lisää vapaa kuvaus
    ${kuvaus}=    Set Variable    Tämä on Robot Frameworkilla tehty automaattinen testitapaus päiväkirjamerkinnän lisäämisestä.
    Fill Text    id=notes    ${kuvaus}
    
    # Lisää merkintä
    Click    text=Lisää merkintä
    
    # Tarkista että merkintä on lisätty
    Wait For Elements State    css=#entries    visible
    Get Text    css=#entries    contains    ${kuvaus}

*** Keywords ***
Kirjaudu Sisään
    New Page    http://localhost:3000
    
    # Odota että kirjautumissivu latautuu
    Wait For Elements State    css=.login-container    visible 
    
    # Kirjaudu sisään
    Fill Text    id=username    testuser
    Type Secret    id=password    $Password
    Click    css=button[type="submit"]
    
    # Varmista että kirjautuminen onnistui
    Wait For Elements State    css=header    visible
    Get Text    css=header    ==    OloHetki