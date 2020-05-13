*** Settings ***
Library                                  SeleniumLibrary
Library                                  DateTime



*** Keywords ***
Open Browser To Start Page
        Open Browser                     about:blank         ${BROWSER}                      options=add_argument("--ignore-certificate-errors");add_argument("--disable-web-security");add_argument("--allow-running-insecure-content");add_argument("--incognito");add_argument("--lang=en-us")
        Maximize Browser Window
        Go To                                                ${URL}
        Set Selenium Speed                                   1
        Wait Until Page Contains                             Find your dream destination        timeout=10


Goto Login page

        Click Element                                        xpath:/html/body/header/nav/div/div/ul[1]/li[2]/a
        Wait Until Page Contains                             Use another service to log in


Click External link
        Click Element                                        xpath://*[@id="external-account"]/div/p/button
        Sleep           20


Verify external page
         Wait Until Page Contains                           Logga in Fortsätt till Agile project       timeout=10
         Title should be                                     Logga in – Google Konton



Login with Empty id
        [Arguments]                                           ${google_id}
        Input text                                           id:identifierId                                ${google_id}
        Click Element                                        xpath://*[@id="identifierNext"]/span
        ${email_error}=                                      Get Text                                       xpath://*[@id="view_container"]/div/div/div[2]/div/div[1]/div/form/span/section/div/div/div[1]/div/div[2]/div[2]/div
        Should Be Equal                                      Ange en e-postadress eller ett telefonnummer   ${email_error}



Login with Invalid Id
        [Arguments]                                          ${google_id}
        Input text                                           id:identifierId                                  ${google_id}
        Click Element                                        xpath://*[@id="identifierNext"]/span
        Wait Until Page Contains                             Inget sådant Google-konto hittades


Register with external id
       [Arguments]                                          ${google_id}                                        ${google_pwd}
       Click Element                                        id:identifierId
       Input text                                           id:identifierId                                     ${google_id}
       Click Element                                        xpath://*[@id="identifierNext"]/span
       Wait Until Page Contains                             Ange ditt lösenord                                   timeout=20
        Sleep                                                20
       Click Element                                        id:password
       Input text                                           xpath://*[@id="password"]/div[1]/div/div[1]/input    ${google_pwd}

       Click Element                                        xpath://*[@id="passwordNext"]/span

       Wait Until Page Contains                             Associate your Google account                        timeout=30
       ${Registered_id}=                                    Get Value                                            id:Input_Email
       Should Be Equal                                      web7agile@gmail.com                                  ${Registered_id}
       Click Element                                        xpath:/html/body/div/main/div/div/form/button
       Wait Until Element Contains                          xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a    Hello web7agile@gmail.com!     timeout=20
       Click Element                                        xpath: //*[contains(text(), "Logout")]
       Wait Until Page Contains                             Login                                                timeout=10


Login with external id
       [Arguments]                                          ${google_id}                                        ${google_pwd}
       Click Element                                        id:identifierId
       Input text                                           id:identifierId                                     ${google_id}
       Click Element                                        xpath://*[@id="identifierNext"]/span
       Wait Until Page Contains                             Ange ditt lösenord                                   timeout=20
       Click Element                                        id:password
       Input text                                           xpath://*[@id="password"]/div[1]/div/div[1]/input    ${google_pwd}
       Click Element                                        xpath://*[@id="passwordNext"]/span
       Wait Until Element Contains                          xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a    Hello web7agile@gmail.com!     timeout=20


Search hotel
       Wait Until Element Is Visible                        id:search-input                                      timeout=10
       Input Text                                           id:search-input                                      Amsterdam
       Click Element                                        id:check-in
       Press Keys                                           id:check-in                                          CTRL+ARROW_DOWN     ENTER
       Click Element                                        id:check-out
       Press Keys                                           id:check-out                                         CTRL+ARROW_DOWN     ENTER
       Click Element                                        id:submit-btn
       Wait Until Page Contains                             See details


See details
       Click Element                                        xpath: //*[contains(text(), "See details")]
       Wait Until Page contains                             Book a room                                           timeout=10


Book room
       Click Element                                        xpath:/html/body/div[1]/main/div[2]/div[1]/div[2]/table/thead//*[contains(text(), "Book a room")]
       Wait Until Page contains                             Personal details                                       timeout=20
       ${email_id}=                                         Get Value                                              id:user_Email
       should be equal                                      web7agile@gmail.com                                    ${email_id}
       Input Text                                           id:user_PhoneNumber                                    987654321
       Click Element                                        xpath:/html/body/div/main/a
       Wait Until Page contains                             Step 2: Payment details                                timeout=10


Enter payment details

       Select Radio Button                                  Type                                                   Visa
       Input Text                                           id:CardHolderFirstName                                 Dhanya
       Input Text                                           id:CardHolderLastName                                  Babu
       Input Text                                           id:CardNumber                                          1234567891234567
       Click Element                                        id:ExpirationDate
       Click Element                                        xpath://*[@id="ExpirationDate"]/option[8]
       Input Text                                           id:CVV                                                 123
       Click Element                                        id:btn submit-btn
       Wait Until Page Contains                             Your booking has been completed successfully!          timeout=10


Confirm booking
       Click Element                                        xpath: //*[contains(text(), "Hello")]
       Wait Until Page Contains                             My Bookings                                             timeout=10
       Click Element                                        xpath:/html/body/div/main/div/div/div[1]/ul/li[4]
       Wait Until Page Contains                             My Bookings                                             timeout=10
       ${Booking_status}=                                   Get Text                                                xpath:/html/body/div/main/div/div/p/span
       Should Be Equal                                      Accepted                                                ${Booking_status}


Goto register
       #
        Set Selenium Speed                                   1
        Click Element                                       xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a
        Wait Until Page Contains                            Register                                                timeout=10


Register account
        [Arguments]                                         ${google_id}                                             ${google_pwd}
        Input Text                                          id:Input_Email                                           ${google_id}
        Input Text                                          id:Input_Password                                        ${google_pwd}
        Input Text                                          id:Input_ConfirmPassword                                 ${google_pwd}
        Click Element                                       xpath:/html/body/div/main/div/div[1]/form/button
        Wait Until Page Contains                            Hello web7testing@gmail.com                              timeout=10
        Click Element                                       xpath: //*[contains(text(), "Logout")]
        Wait Until Page Contains                            Login                                                    timeout=10


Register with external existing id
       [Arguments]                                         ${google_id}                                              ${google_pwd}
       Click Element                                        id:identifierId
       Input text                                           id:identifierId                                          ${google_id}
       Click Element                                        xpath://*[@id="identifierNext"]/span
       Wait Until Page Contains                             Ange ditt lösenord                                       timeout=20
       Click Element                                        id:password
       Input text                                           xpath://*[@id="password"]/div[1]/div/div[1]/input        ${google_pwd}
       Click Element                                        xpath://*[@id="passwordNext"]/span
       Wait Until Page Contains                             Associate your Google account                            timeout=30
       ${Registered_id}=                                    Get Value                                                id:Input_Email
       Should Be Equal                                      web7testing@gmail.com                                    ${Registered_id}
       Click Element                                        xpath:/html/body/div/main/div/div/form/button
       Wait Until Page Contains                             User name 'web7testing@gmail.com' is already taken       timeout=10



End Web Test
        Close Browser
