*** Settings ***
Library                                  SeleniumLibrary
Library                                  RequestsLibrary



*** Keywords ***
Open Browser To Start Page
        Open Browser                     about:blank      ${BROWSER}        options=add_argument("--ignore-certificate-errors")
        Maximize Browser Window
        Go To                                             ${URL}
        Set Selenium Speed                                1
        Wait Until Page Contains                          Find your dream destination        timeout=10


Verify image is visible
        [Arguments]                      ${element id}
        Wait Until Page Contains         Find your dream destination     timeout=10
        Page Should Contain Image        ${element id}
        Element Should Be Visible        ${element id}


Verify src of first image
        [Arguments]                      ${element id}
        ${img src}=                      Get element attribute           ${element id}           attribute=src
        Should Be Equal                  ${img src}                      https://localhost:44364/pictures/ritz.jpg
        Execute Javascript               window.open()
        Switch Window                    locator=NEW
        Go To                            https://localhost:44364/pictures/ritz.jpg
        ${image_title}=                  Get Title
        should be equal                  ${image_title}                  ritz.jpg (1280×854)
        Sleep                            5
        Close Window
        Select Window                    - ProjectAgileWeb7
        

Verify src of second image
        [Arguments]                      ${element id}
        ${img src}=                      Get element attribute           ${element id}            attribute=src
        Should Be Equal                  ${img src}                      https://localhost:44364/pictures/corinthia.jpg
        Execute Javascript               window.open()
        Switch Window                    locator=NEW
        Go To                            https://localhost:44364/pictures/corinthia.jpg
        ${image_title}=                  Get Title
        should be equal                  ${image_title}                  corinthia.jpg (1280×853)
        Sleep                            5
        Close Window
        Select Window                    - ProjectAgileWeb7


Verify src of third image
        [Arguments]                      ${element id}
        ${img src}=                      Get element attribute           ${element id}             attribute=src
        Should Be Equal                  ${img src}                      https://localhost:44364/pictures/eden.jpg
        Execute Javascript               window.open()
        Switch Window                    locator=NEW
        Go To                            https://localhost:44364/pictures/eden.jpg
        ${image_title}=                  Get Title
        should be equal                  ${image_title}                  eden.jpg (1024×683)
        Sleep                            5
        Close Window
        Select Window                    - ProjectAgileWeb7

Verify first hotel
        ${hotel_name}=                  Get Text                        xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[1]/div[2]/div[1]/h2
        Should Be Equal                 ${hotel_name}                   Ritz Hotel Paris
        Locator Should Match X Times    xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[1]/div[2]/div[2]/*    5
        ${place_link}=                  Get Text                        xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[1]/div[2]/div[3]/p[1]
        Should Be Equal                 ${place_link}                   15 Place Vendôme, 75001, Paris, France
        ${distance_link}=               Get Text                        xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[1]/div[2]/div[3]/p[2]
        Should Be Equal                 ${distance_link}                Distance from centre: 6.3 km.
        ${discription_link}=            Get Text                        xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[1]/div[2]/div[4]
        Should Be Equal                 ${discription_link}             Located in Paris, 500 m from Opéra Garnier, Ritz Paris features a selection of bars and restaurants, a garden and a business centre.
        Element Should Contain          xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[1]/div[2]/div[5]         Facilities:
        Element Should Be Visible       xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[2]/a
        ${extern_link}=                 Get Text                        xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[1]/div[2]/div[6]/p/a
        Should Be Equal                 ${extern_link}                  https://www.ritzparis.com/en-GB
        Click Element                   xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[1]/div[2]/div[6]/p/a
        Title Should Be                 Ritz Paris: Luxury Hotel 5 stars Place Vendôme
        Go Back
        Wait Until Page Contains        Find your dream destination     timeout=10


Verify second hotel
        ${hotel_name}=                 Get Text                         xpath:/html/body/div[1]/main/div[2]/div[2]/div[2]/div/div[1]/div[2]/div[1]/h2
        Should Be Equal                 ${hotel_name}                   Corinthia Hotel London
        Locator Should Match X Times    xpath:/html/body/div[1]/main/div[2]/div[2]/div[2]/div/div[1]/div[2]/div[2]/*    5
        ${place_link}=                  Get Text                        xpath:/html/body/div[1]/main/div[2]/div[2]/div[2]/div/div[1]/div[2]/div[3]/p[1]
        Should Be Equal                 ${place_link}                   Whitehall Place, SW1A 2BD, London, United Kingdom
        ${distance_link}=               Get Text                        xpath:/html/body/div[1]/main/div[2]/div[2]/div[2]/div/div[1]/div[2]/div[3]/p[2]
        Should Be Equal                 ${distance_link}                Distance from centre: 1.6 km.
        ${discription_link}=            Get Text                        xpath:/html/body/div[1]/main/div[2]/div[2]/div[2]/div/div[1]/div[2]/div[4]
        Should Be Equal                 ${discription_link}             The luxurious Corinthia Hotel is located in one of London’s most prestigious areas, moments from Trafalgar Square and Whitehall. It features elegant restaurants, 2 bars, a florist and the world's first hotel concession for Harrods.
        Element Should Contain          xpath:/html/body/div[1]/main/div[2]/div[2]/div[2]/div/div[1]/div[2]/div[5]         Facilities:
        Element Should Be Visible       xpath:/html/body/div[1]/main/div[2]/div[2]/div[2]/div/div[2]/a
        ${extern_link}=                 Get Text                        xpath:/html/body/div[1]/main/div[2]/div[2]/div[2]/div/div[1]/div[2]/div[6]/p/a
        Should Be Equal                 ${extern_link}                  https://www.corinthia.com/london/
        Click Element                   xpath:/html/body/div[1]/main/div[2]/div[2]/div[2]/div/div[1]/div[2]/div[6]/p/a
        Title Should Be                 Corinthia London | Luxury Hotel in London | Corinthia Hotels - Corinthia
        Go Back
        Wait Until Page Contains        Find your dream destination     timeout=10


Verify third hotel
        ${hotel_name}=                  Get Text                        xpath:/html/body/div[1]/main/div[2]/div[2]/div[3]/div/div[1]/div[2]/div[1]/h2
        Should Be Equal                 ${hotel_name}                   Eden Hotel Amsterdam
        Locator Should Match X Times    xpath:/html/body/div[1]/main/div[2]/div[2]/div[3]/div/div[1]/div[2]/div[2]/*    4
        ${place_link}=                  Get Text                        xpath:/html/body/div[1]/main/div[2]/div[2]/div[3]/div/div[1]/div[2]/div[3]/p[1]
        Should Be Equal                 ${place_link}                   Amstelstraat 17, 1017 DA, Amsterdam, Netherlands
        ${distance_link}=               Get Text                        xpath:/html/body/div[1]/main/div[2]/div[2]/div[3]/div/div[1]/div[2]/div[3]/p[2]
        Should Be Equal                 ${distance_link}                Distance from centre: 0.9 km.
        ${discription_link}=            Get Text                        xpath:/html/body/div[1]/main/div[2]/div[2]/div[3]/div/div[1]/div[2]/div[4]
        Should Be Equal                 ${discription_link}             Located in the heart of the city center, Eden Hotel Amsterdam offers warm-colored rooms. The famous Rembrandt Square is right around the corner. The central station is 10 minutes away by tram.
        Element Should Contain          xpath:/html/body/div[1]/main/div[2]/div[2]/div[3]/div/div[1]/div[2]/div[5]        Facilities
        Element Should Be Visible       xpath:/html/body/div[1]/main/div[2]/div[2]/div[3]/div/div[2]/a
        ${extern_link}=                 Get Text                        xpath:/html/body/div[1]/main/div[2]/div[2]/div[3]/div/div[1]/div[2]/div[6]/p/a
        Should Be Equal                 ${extern_link}                  https://www.edenhotelamsterdam.com/en/
        Click Element                   xpath:/html/body/div[1]/main/div[2]/div[2]/div[3]/div/div[1]/div[2]/div[6]/p/a
        Title Should Be                 Eden Hotel Amsterdam 4* | Along the famous Amstel | 10% discount
        Go Back
        Wait Until Page Contains        Find your dream destination     timeout=10


Change window size value
        [Arguments]                      ${width}                       ${height}
        Set Window Size                  ${width}                       ${height}





End Web Test
        Close Browser