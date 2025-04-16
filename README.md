# Tietokanta taulut
![Tietokanta](</public/img/Näyttökuva 2025-03-09 221740.png>)

![Taulut:](</public/img/Näyttökuva 2025-03-09 221531-1.png>)


# Projekti-Terveyssovelluksen-kehitys
## Tehtävä 1: 
### Ohjeistetut asunnukset on tehty.
![Asennukset](</public/img/Asennukset.png>)

## Tehtävä 2: 
### Kirjautumistesti omalle terveyspäiväkirja-sovellukselle on tehty.
#### Toteutus:
#### -Tiedosto: browser_demo.robot
#### -Testaa kirjautumista annetuilla tunnuksilla
#### -Varmistaa että käyttäjä ohjataan kirjautumisen jälkeen etusivulle
![2](</public/img/tehtävä 2.png>)

## Tehtävä 3: 
###  Testattiin web-lomake-elementtien Selenium-testisivulla.
#### Toteutus:
#### -browser_test_demo.robot - Testaa lomake-elementtejä
#### -Keywords.robot - Sisältää testin käyttämät muuttujat
![3](</public/img/tehtävä 3.png>)

## Tehtävä 4: 
### Testi lisää uuden päiväkirjamerkinnän OloHetki-sovellukseen.
#### Toteutus:
#### -Tiedosto: test/browser_demo.robot
#### -Käyttää aiemmin luotua Keywords.robot-tiedostoa kirjautumistunnuksille
#### -Testaa sovelluksen päätoiminnallisuutta - päiväkirjamerkintöjen lisäämistä
#### -En saanut testiä läpäistyä hyväksitysti. Työstin noin 4 päivää, joten jatkan muita tehtäviä ja palaan tähän tehtävään myöhemmin.
![4](</public/img/tehtävä 4.png>)


## Tehtävä 5: 
### Tässä tehtävässä toteutetaan kirjautumistesti OloHetki-sovellukselle, joka hyödyntää .env-tiedostoon tallennettuja käyttäjätunnuksia ja salasanoja. Tämä on turvallinen tapa säilyttää arkaluontoisia tietoja, koska .env-tiedostot voidaan jättää versionhallinnan ulkopuolelle.
#### -Tiedosto: robot --outputdir outputs tests/front/login_env_test.robot
![5](</public/img/teht 5.png>)

## Tehtävä 6: 
### Tässä tehtävässä toteutin kirjautumistestin OloHetki-sovellukselle, joka käyttää CryptoLibrary-kirjastoa käyttäjätunnuksen ja salasanan salaamiseen. Tämä on turvallisempi tapa kuin käyttää tavallisia .env-tiedostoja, koska tunnukset ovat salattuna testin lähdekoodissa.
#### -login_crypto_test.robot - Pääasiallinen kirjautumistesti, joka käyttää kryptattuja tunnuksia
#### -generate_credentials.robot - Apuskripti uusien salattujen tunnusten luomiseen
#### - Ei läpäise testiä jatkan työstämistä!

![6](</public/img/teht 6.png>)

