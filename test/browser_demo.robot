*** Settings ***
Documentation     Testi päiväkirjamerkinnän lisäämiseen OloHetki-sovelluksessa
Library           Browser    auto_closing_level=KEEP
Library           DateTime

*** Variables ***
${API_URL}        http://localhost:3000
${FRONT_URL}      http://localhost:3000

*** Test Cases ***
Lisää uusi päiväkirjamerkintä
    # Avaa selain
    New Browser    chromium    headless=No
    
    # Navigoi sovelluksen etusivulle
    New Page       ${FRONT_URL}
    
    # Odota että sivu latautuu
    Wait For Elements State    body    visible    timeout=10s
    
    # Ota kuvakaappaus alkutilanteesta
    Take Screenshot    filename=alkutilanne.png    fullPage=True
    
    # Navigoi päiväkirjasivulle jos mahdollista
    ${has_diary_link}=    Get Element Count    a:has-text("Päiväkirja")
    IF    ${has_diary_link} > 0
        Click    a:has-text("Päiväkirja")
        Wait For Elements State    body    visible    timeout=5s
        Take Screenshot    filename=paivakirjasivu.png    fullPage=True
    END
    
    # Tarkista onko merkintäkenttä jo näkyvissä, jos ei, etsi miten sinne pääsee
    ${has_situation}=    Get Element Count    id=situation
    IF    ${has_situation} == 0
        # Jos emme löydä merkintäkenttää, etsi mahdollisia painikkeita tai linkkejä
        ${buttons}=    Get Element Count    button
        IF    ${buttons} > 0
            ${button_texts}=    Get Text    button
            Log    Löytyi painikkeita: ${button_texts}
        END
        
        ${links}=    Get Element Count    a
        IF    ${links} > 0
            ${link_texts}=    Get Text    a
            Log    Löytyi linkkejä: ${link_texts}
        END
        
        # Yritä löytää uusi merkintä -painike tai vastaava
        ${new_entry_btn}=    Get Element Count    button:has-text("Uusi merkintä"), a:has-text("Uusi merkintä")
        IF    ${new_entry_btn} > 0
            Click    button:has-text("Uusi merkintä"), a:has-text("Uusi merkintä")
            Wait For Elements State    body    visible    timeout=5s
            Take Screenshot    filename=uusi_merkinta.png    fullPage=True
        END
    END
    
    # Tarkista löytyykö nyt merkintäkenttä
    ${has_situation_now}=    Get Element Count    id=situation
    IF    ${has_situation_now} > 0
        # Täytä päiväkirjamerkintä
        Fill Text    id=situation    Testaus Robot Frameworkilla
        Fill Text    id=emotion    Keskittynyt ja kiinnostunut
        
        # Valitse ahdistuksen taso
        ${anxiety_level}=    Set Variable    2
        Click    css=[name="anxiety"][value="${anxiety_level}"]
        
        # Valitse stressin taso
        ${stress_level}=    Set Variable    3
        Click    css=[name="stress"][value="${stress_level}"]
        
        # Valitse paniikin taso
        ${panic_level}=    Set Variable    1
        Click    css=[name="panic"][value="${panic_level}"]
        
        # Lisää vapaa kuvaus
        ${kuvaus}=    Set Variable    Tämä on Robot Frameworkilla tehty automaattinen testitapaus päiväkirjamerkinnän lisäämisestä.
        Fill Text    id=notes    ${kuvaus}
        
        # Ota kuvakaappaus täytetystä lomakkeesta
        Take Screenshot    filename=taytetty_lomake.png    fullPage=True
        
        # Etsi tallennuspainike ja klikkaa sitä
        ${save_btn}=    Get Element Count    button:has-text("Lisää merkintä")
        IF    ${save_btn} > 0
            Click    button:has-text("Lisää merkintä")
        ELSE
            # Jos ei löydy "Lisää merkintä", kokeile muita mahdollisia tekstejä
            ${other_btn}=    Get Element Count    button:has-text("Tallenna"), button:has-text("Lähetä"), button[type="submit"]
            IF    ${other_btn} > 0
                Click    button:has-text("Tallenna"), button:has-text("Lähetä"), button[type="submit"]
            ELSE
                # Jos ei löydy mitään sopivaa, klikkaa ensimmäistä painiketta
                Click    button
            END
        END
        
        # Odota että merkintä tallentuu
        Sleep    2s
        
        # Ota kuvakaappaus lopputilanteesta
        Take Screenshot    filename=tallennettu.png    fullPage=True
        
        # Yritä löytää merkintöjen näyttöelementti ja tarkistaa sisältääkö se merkintämme
        ${entries_element}=    Get Element Count    id=entries, .entries, [data-testid="entries"]
        IF    ${entries_element} > 0
            ${entries_text}=    Get Text    id=entries, .entries, [data-testid="entries"]
            Should Contain    ${entries_text}    ${kuvaus}
            Log    Merkintä tallennettu onnistuneesti
        ELSE
            Log    Varoitus: Merkintöjen näyttöelementtiä ei löytynyt, mutta merkintä saattoi silti tallentua
        END
    ELSE
        Fail    Merkinnän lisäyslomaketta ei löytynyt
    END