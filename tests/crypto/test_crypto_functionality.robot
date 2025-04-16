*** Settings ***
Documentation    Testi CryptoLibraryn toimivuuden testaamiseen
Resource         crypto_keywords.robot

*** Test Cases ***
Test Encryption And Decryption
    [Documentation]    Testaa salaamista ja salauksen purkamista
    Test Encryption
    
    # Kryptataan käyttäjätunnukset
    ${encrypted_username}=    Encrypt My Text    d
    ${encrypted_password}=    Encrypt My Text    d
    
    # Tulostetaan tulokset
    Log    Kryptattu käyttäjätunnus: crypt:${encrypted_username}
    Log    Kryptattu salasana: crypt:${encrypted_password}
    
    # Testataan Variables-osioon sijoittamista
    Set Test Variable    ${USERNAME}    crypt:${encrypted_username}
    Set Test Variable    ${PASSWORD}    crypt:${encrypted_password}
    
    # Tarkistetaan automaattinen purku
    Log    Käyttäjätunnus (dekryptattu): ${USERNAME}
    Log    Salasana (dekryptattu): ${PASSWORD}
    
    # Varmistetaan että dekryptaus toimii
    Should Be Equal    ${USERNAME}    testikäyttäjä
    Should Be Equal    ${PASSWORD}    testisalasana