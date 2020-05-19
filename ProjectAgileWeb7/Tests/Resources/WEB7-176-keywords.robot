*** Settings ***
Library                                  SeleniumLibrary
Library                                  String
Library                                  BuiltIn

*** Keywords ***
Open Browser To Start Page
        Open Browser                     about:blank        ${BROWSER}        options=add_argument("--ignore-certificate-errors")
        Maximize Browser Window
        Go To                                               ${URL}
        Set Selenium Speed                                   1
        Wait Until Page Contains                             Find your dream destination        timeout=10


Goto register
        Click Element                                       xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a
        Wait Until Page Contains                            Register                                              timeout=10


Register account
        [Arguments]                                         ${reg_email_id}                                       ${reg_pwd}
        Input Text                                          id:Input_Email                                        ${reg_email_id}
        Input Text                                          id:Input_Password                                     ${reg_pwd}
        Input Text                                          id:Input_ConfirmPassword                              ${reg_pwd}
        Click Element                                       xpath:/html/body/div/main/div/div[1]/form/button
        Wait Until Page Contains                            Hello testingaccount@gmail.com                        timeout=10


Search hotel
        Wait Until Element Is Visible                       id:search-input                                       timeout=10
        Input Text                                          id:search-input                                       Amsterdam
        Click Element                                       id:check-in
        Press Keys                                          id:check-in                                           CTRL+ARROW_DOWN     ENTER
        Click Element                                       id:check-out
        Press Keys                                          id:check-out                                          CTRL+ARROW_DOWN     ENTER
        Click Element                                       id:submit-btn
        Wait Until Page Contains                            See details


See details
       Click Element                                        xpath: //*[contains(text(), "See details")]
       Wait Until Page contains                             Book a room                                            timeout=10


Enter booking details
       Click Element                                        xpath:/html/body/div[1]/main/div[2]/div[1]/div[2]/table/thead//*[contains(text(), "Book a room")]
       Wait Until Page contains                             Personal details                                       timeout=20
       ${email_id}=                                         Get Value                                              id:user_Email
       should be equal                                      testingaccount@gmail.com                               ${email_id}
       Input Text                                           id:user_PhoneNumber                                    987654321
       Click Element                                        xpath:/html/body/div/main/a
       Wait Until Page contains                             Step 2: Payment details                                timeout=10


Enter payment details
       Select Radio Button                                  Type                                                   Visa
       Input Text                                           id:CardHolderFirstName                                 Test
       Input Text                                           id:CardHolderLastName                                  Account
       Input Text                                           id:CardNumber                                          1234567891234567
       Click Element                                        id:ExpirationDate
       Click Element                                        xpath://*[@id="ExpirationDate"]/option[8]
       Input Text                                           id:CVV                                                 123


Confirm booking
       Click Element                                        id:btn submit-btn
       Wait Until Page Contains                             Your booking has been completed successfully!          timeout=10


Goto my bookings
       Click Element                                        xpath: //*[contains(text(), "Hello")]
       Wait Until Page Contains                             My Bookings                                             timeout=10
       Click Element                                        xpath:/html/body/div/main/div/div/div[1]/ul/li[4]
       Wait Until Page Contains                             My Bookings                                             timeout=10


Verify Booking details
       ${Booking_status}=                                   Get Text                                                xpath:/html/body/div/main/div/div/p/span
       Should Be Equal                                      Accepted                                                ${Booking_status}


Goto login
       Wait Until Element Is Visible                        xpath:/html/body/header/nav/div/div/ul[1]/li[2]/a       timeout=10
       Click Element                                        xpath:/html/body/header/nav/div/div/ul[1]/li[2]/a
       Wait Until Page Contains                             Log in                                                  timeout=10


login registered account
        [Arguments]                                         ${login_email_id}                                       ${login_pwd}
        Input Text                                          id:Input_Email                                          ${login_email_id}
        Input Text                                          id:Input_Password                                       ${login_pwd}
        Click Element                                       xpath://*[@id="account"]/div[5]/button
        Wait Until Page Contains                            Hello                                                   timeout=10


Verify available room number
        ${Available_room_num}=                              Get Text                                                xpath:/html/body/div[1]/main/div[2]/div[1]/div[2]/table/thead/tr[2]/td[3]
        ${Avail_room_Number_before}=                        Fetch From Left                                         ${Available_room_num}      /
        Set Suite Variable                                  ${Avail_room_Number_before}



Book room
       Click Element                                        xpath:/html/body/div[1]/main/div[2]/div[1]/div[2]/table/thead/tr[2]//*[contains(text(), "Book a room")]
       Wait Until Page contains                             Personal details                                       timeout=20
       ${email_id}=                                         Get Value                                              id:user_Email
       should be equal                                      testingaccount@gmail.com                               ${email_id}
       Input Text                                           id:user_PhoneNumber                                    987654321
       Click Element                                        xpath:/html/body/div/main/a
       Wait Until Page contains                             Step 2: Payment details                                timeout=10
       Select Radio Button                                  Type                                                   MasterCard
       Input Text                                           id:CardHolderFirstName                                 Web7
       Input Text                                           id:CardHolderLastName                                  Testing
       Input Text                                           id:CardNumber                                          1234567891234567
       Click Element                                        id:ExpirationDate
       Click Element                                        xpath://*[@id="ExpirationDate"]/option[8]
       Input Text                                           id:CVV                                                 123
       Click Element                                        id:btn submit-btn
       Wait Until Page Contains                             Your booking has been completed successfully!          timeout=10


verify booking in history
       Click Element                                        xpath: //*[contains(text(), "Hello")]
       Wait Until Page Contains                             My Bookings                                             timeout=10
       Click Element                                        xpath:/html/body/div/main/div/div/div[1]/ul/li[4]
       Wait Until Page Contains                             My Bookings                                             timeout=10
       ${Booking_status}=                                   Get Text                                                xpath:/html/body/div/main/div/div/p/span
       Should Be Equal                                      Accepted                                                ${Booking_status}


Goto home
        Click Element                                       xpath:/html/body/header/nav/div/div/ul[2]/li[1]
        Wait Until Page Contains                            Find your dream destination                             timeout=10


Verify available room decreased by one
        ${Available_room_aftr_booking}=                     Get Text                                               xpath:/html/body/div[1]/main/div[2]/div[1]/div[2]/table/thead/tr[2]/td[3]
        ${Avail_room_after}=                                Fetch From Left                                        ${Available_room_aftr_booking}      /
        ${Avail_room_Number_after}=                         Convert To Integer                                     ${Avail_room_after}
        ${Avail_room_Number_calculated}=                    Evaluate                                               ${Avail_room_Number_before} - 1
        should be equal                                     ${Avail_room_Number_after}                             ${Avail_room_Number_calculated}



End Web Test
        Close Browser