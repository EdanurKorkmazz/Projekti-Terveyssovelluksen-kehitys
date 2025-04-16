*** Settings ***
Documentation    Apuavainsanat kryptattujen tunnusten käyttöön
Library          CryptoLibrary    password=d    variable_decryption=True    #vaihda "oma_salasana" omaan salasanaasi

*** Keywords ***
Encrypt My Text
    [Arguments]    ${text}
    ${encrypted}=    Encrypt    ${text}
    [Return]    ${encrypted}

Test Encryption
    [Documentation]    Testaa salauksen toimivuutta
    ${clear_text}=    Set Variable    testiteksti
    ${encrypted}=    Encrypt My Text    ${clear_text}
    Log    Alkuperäinen teksti: ${clear_text}
    Log    Salattu teksti: ${encrypted}
    Log    Salattu muodossa 'crypt:${encrypted}'
    
    # Testataan automaattista purkua
    ${test_var}=    Set Variable    crypt:${encrypted}
    Log    Purettu automaattisesti: ${test_var}
    Should Be Equal    ${test_var}    ${clear_text}