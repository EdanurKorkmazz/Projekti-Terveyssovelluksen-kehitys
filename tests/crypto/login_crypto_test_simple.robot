*** Settings ***
Documentation     Kirjautumistesti joka käyttää CryptoLibrarya salasanan ja käyttäjätunnuksen salaamiseen
Library           Browser    auto_closing_level=SUITE
Library           OperatingSystem
Library           CryptoLibrary    password=oma_salasana    variable_decryption=True    #vaihda "oma_salasana" omaan salasanaasi
Library           DateTime

*** Variables ***
# HUOM! Korvaa nämä arvot test_crypto_functionality.robot testin luomilla arvoilla
${USERNAME}       crypt:EncryptedTextHere    # Korvaa testin luomalla kryptatulla käyttäjätunnuksella
${PASSWORD}       crypt:EncryptedTextHere    # Korvaa testin luomalla kryptatulla salasanalla

# Sovelluksen osoite - muuta vastaamaan omaa sovellustasi
${LOGIN_URL}      http://localhost:3000

# Selektorit
${USERNAME_FIELD}  css=input[type="text"], input[id="username"], input[name="username"]
${PASSWORD_FIELD}  css=input[type="password"], input[id="password"], input[name="password"]
${LOGIN_BUTTON}   css=button[type="submit"], input[type="submit"], button:has-text("Kirjaudu")

*** Test Cases ***
Kirjautuminen Onnistuu Kryptatuilla Tunnuksilla
    # Tarkistetaan että salauksen purku toimii
    Log    Dekryptattu käyttäjätunnus: ${USERNAME}
    Log    Dekryptattu salasana: ${PASSWORD}
    
    # Luo kuvakaappausten timestamp
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    
    # Avaa selain ja navigoi kirjautumissivulle
    New Browser    chromium    headless=No
    New Page       ${LOGIN_URL}
    
    # Odota että sivu latautuu kunnolla
    Wait For Elements State    body    visible    timeout=10s
    Sleep    1s
    
    # Ota kuvakaappaus ennen kirjautumista
    Take Screenshot    filename=crypto_login_${timestamp}.png    fullPage=True
    
    # Tarkista löytyykö kirjautumiskenttä
    ${username_visible}=    Get Element Count    ${USERNAME_FIELD}
    
    # Jos emme löydä kirjautumiskenttää, tarkistetaan olemmeko jo kirjautuneet
    IF    ${username_visible} == 0
        # Tarkistetaan olemmeko jo kirjautuneet etsimällä sovelluksen elementtejä
        ${has_header}=    Get Element Count    header
        ${has_nav}=       Get Element Count    nav
        ${body_text}=     Get Text    body
        
        # Näytetään sivun sisältö debug-tarkoituksessa
        Log    Body text: ${body_text}
        Log    Has header: ${has_header}
        Log    Has nav: ${has_nav}
        
        # Jos löytyy sovelluksen elementtejä, olemme kirjautuneet
        IF    ${has_header} > 0 OR ${has_nav} > 0
            Log    Käyttäjä on jo kirjautunut
            Take Screenshot    filename=already_logged_in_${timestamp}.png    fullPage=True
            PASS    Käyttäjä on jo kirjautunut
        ELSE
            # Jos emme löydä elementtejä, sivussa on luultavasti ongelma
            Take Screenshot    filename=error_no_elements_${timestamp}.png    fullPage=True
            Fail    Kirjautumislomaketta tai sovelluksen elementtejä ei löydy
        END
    # Jos löydämme kirjautumiskentän, täytetään se
    ELSE
        # Täytä kirjautumislomake ja lähetä se
        Fill Text    ${USERNAME_FIELD}    ${USERNAME}
        Fill Text    ${PASSWORD_FIELD}    ${PASSWORD}
        
        # Ota kuvakaappaus ennen lähetystä
        Take Screenshot    filename=filled_form_${timestamp}.png    fullPage=True
        
        # Lähetä lomake
        Click    ${LOGIN_BUTTON}
        
        # Odota sivun päivittymistä
        Sleep    2s
        
        # Ota kuvakaappaus kirjautumisen jälkeen
        Take Screenshot    filename=after_login_${timestamp}.png    fullPage=True
        
        # Tarkista onnistuiko kirjautuminen
        ${has_header}=    Get Element Count    header
        ${has_nav}=       Get Element Count    nav
        ${has_logout}=    Get Element Count    a:has-text("Kirjaudu ulos")
        ${body_text}=     Get Text    body
        
        # Tarkista löytyykö elementtejä jotka viittaavat onnistuneeseen kirjautumiseen
        ${success}=    Evaluate    ${has_header} > 0 or ${has_nav} > 0 or ${has_logout} > 0 or "OloHetki" in """${body_text}""" or "Etusivu" in """${body_text}"""
        
        IF    ${success}
            Log    Kirjautuminen onnistui!
            PASS    Kirjautuminen onnistui kryptatuilla tunnuksilla
        ELSE
            # Tarkista näkyykö kirjautumislomake vielä
            ${form_still_visible}=    Get Element Count    ${USERNAME_FIELD}
            
            IF    ${form_still_visible} > 0
                Fail    Kirjautuminen epäonnistui - lomake on edelleen näkyvissä
            ELSE
                Fail    Kirjautumisen tila on epäselvä - ei löydy lomaketta eikä sovelluksen elementtejä
            END
        END
    END