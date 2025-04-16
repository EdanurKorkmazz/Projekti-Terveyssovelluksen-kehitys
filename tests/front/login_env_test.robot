*** Settings ***
Documentation     Yksinkertainen sivu-analyysi debuggausta varten
Library           Browser
Library           OperatingSystem
Library           DateTime
Library           ../../utils/env_loader.py

*** Test Cases ***
Analysoi Kirjautumissivu
    # Lataa .env-tiedoston sisältö
    Load Dotenv
    ${front_url}=    Get Environment Variable    FRONT_URL
    
    # Avaa sivu
    New Browser    chromium    headless=No
    New Page       ${front_url}
    
    # Odota hetki että sivu latautuu
    Sleep    3s
    
    # Ota kuvakaappaus ja tallenna sivun HTML
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    Take Screenshot    filename=sivu_analyysi_${timestamp}.png    fullPage=True
    
    # Kerää tietoa sivun rakenteesta
    ${body_text}=    Get Text    body
    Log    Sivun teksti: ${body_text}
    
    # Etsi yleisiä lomake-elementtejä
    ${forms}=        Get Element Count    form
    ${inputs}=       Get Element Count    input
    ${passwords}=    Get Element Count    input[type="password"]
    ${buttons}=      Get Element Count    button
    ${submit_btns}=  Get Element Count    button[type="submit"], input[type="submit"]
    
    Log    Lomakkeita: ${forms}
    Log    Input-kenttiä: ${inputs}
    Log    Salasana-kenttiä: ${passwords}
    Log    Painikkeita: ${buttons}
    Log    Submit-painikkeita: ${submit_btns}
    
    # Jos löytyy input-kenttiä, tarkistetaan niiden tyypit
    IF    ${inputs} > 0
        Log    Analysoidaan input-kenttien tyypit:
        ${input_types}=    Evaluate JavaScript    document.querySelectorAll('input'), 
        ...    (inputs) => Array.from(inputs).map(i => ({type: i.type, id: i.id, name: i.name, class: i.className}))
        Log    Input-kenttien tiedot: ${input_types}
    END
    
    # Jos löytyy nappeja, tarkistetaan niiden tekstit
    IF    ${buttons} > 0
        Log    Analysoidaan painikkeiden tekstit:
        ${button_texts}=    Get Text    button
        Log    Painikkeiden tekstit: ${button_texts}
    END
    
    # Tarkistetaan onko sivulla otsikoita
    ${headings}=     Get Element Count    h1, h2, h3
    IF    ${headings} > 0
        Log    Löytyi otsikoita: ${headings}
        ${heading_texts}=    Get Text    h1, h2, h3
        Log    Otsikoiden tekstit: ${heading_texts}
    END
    
    # Tarkistetaan onko navigaatiota
    ${nav}=    Get Element Count    nav
    IF    ${nav} > 0
        Log    Löytyi nav-elementti
        ${nav_links}=    Get Element Count    nav a
        Log    Navigaation linkkien määrä: ${nav_links}
    END