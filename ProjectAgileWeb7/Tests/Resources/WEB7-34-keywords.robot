*** Settings ***
Library                                  SeleniumLibrary
Library                                  DateTime
Library                                  String
Library                                  BuiltIn


*** Keywords ***
Open Browser To Start Page
        Open Browser                     about:blank        ${BROWSER}        options=add_argument("--ignore-certificate-errors")
        Maximize Browser Window
        Go To                                               ${URL}
        Set Selenium Speed                                  1
        Wait Until Page Contains                            Find your dream destination                         timeout=10


Goto register
        Click Element                                       xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a
        Wait Until Page Contains                            Register                                              timeout=10


Register account
        [Arguments]                                         ${reg_email_id}                                       ${reg_pwd}
        Input Text                                          id:Input_Email                                        ${reg_email_id}
        Input Text                                          id:Input_Password                                     ${reg_pwd}
        Input Text                                          id:Input_ConfirmPassword                              ${reg_pwd}
        Click Element                                       xpath:/html/body/div/main/div/div[1]/form/button
        Wait Until Page Contains                            Hello                                                 timeout=10


Search hotel
        Wait Until Element Is Visible                       id:search-input                                       timeout=10
        Input Text                                          id:search-input                                       London
        Click Element                                       id:check-in
        Press Keys                                          id:check-in                                           CTRL+ARROW_DOWN     ENTER
        Click Element                                       id:check-out
        Press Keys                                          id:check-out                                          CTRL+ARROW_DOWN     ENTER
        Click Element                                       id:submit-btn
        Wait Until Page Contains                            See details


See details
        Click Element                                       xpath: //*[contains(text(), "See details")]
        Wait Until Page contains                            Book a room                                            timeout=10


Verify price per night
        ${price_SEK_disp}=                                  Get Text                                               xpath:/html/body/div[1]/main/div[2]/div[1]/div[2]/table/thead/tr[3]/td[2]
        ${price_per_night_SEK_disp}=                        Fetch From Left                                        ${price_SEK_disp}       S
        ${price_per_night_SEK}=                             convert to number                                      ${price_per_night_SEK_disp}
        Set Suite Variable                                  ${price_per_night_SEK}


Book room
       Click Element                                       xpath:/html/body/div[1]/main/div[2]/div[1]/div[2]/table/thead/tr[3]//*[contains(text(), "Book a room")]
       Wait Until Page contains                            Personal details                                         timeout=20
       ${email_id}=                                        Get Value                                                id:user_Email
       should be equal                                     testing@gmail.com                                        ${email_id}
       Input Text                                          id:user_PhoneNumber                                      987654321
       Click Element                                       xpath:/html/body/div/main/a
       Wait Until Page contains                            Step 2: Payment details                                  timeout=10


Select SEK currency
       Click Element                                        id:Currency
       Click Element                                        xpath://*[@id="Currency"]/option[1]


Verify SEK Payment details
       ${price_per_night_text}=                           Get Text                                                xpath:/html/body/div/main/form/div/div/label[1]
       ${price_per_night_number}                          convert to number                                        ${price_per_night_text}      1
       should be equal                                    ${price_per_night_SEK}                                   ${price_per_night_number}
       ${total_nights_text}=                              Get Text                                                 xpath:/html/body/div/main/form/div/div[@class='card-body']
       ${substring}=                                      Fetch From Left                                          ${total_nights_text}         Total
       ${total_nights}=                                   Fetch From Right                                         ${substring}                 nights:
       ${total_nights_number}=                            convert to integer                                       ${total_nights}
       ${total_price_text}=                               Get Text                                                 xpath:/html/body/div/main/form/div/div/label[3]
       ${total_price_number_SEK}=                         convert to number                                        ${total_price_text}
       Set Suite Variable                                 ${total_price_number_SEK}
       ${calculated_price_SEK}=                           Evaluate                                                 ${total_nights_number} * ${price_per_night_SEK}
       should be equal                                    ${calculated_price_SEK}                                  ${total_price_number_SEK}


Select USD currency
       Click Element                                      id:Currency
       Click Element                                      xpath://*[@id="Currency"]/option[2]


Verify USD Payment details
       [Arguments]                                        ${USD_value}
       ${price_per_night_text}=                           Get Text                                                 xpath:/html/body/div/main/form/div/div/label[1]
       ${price_per_night_number}                          convert to number                                        ${price_per_night_text}     0
       ${price_per_night_USD}=                            Evaluate                                                 ${price_per_night_SEK} * ${USD_value}
       ${price_per_night_USD_number}=                     Convert To Number                                        ${price_per_night_USD}       0
       Should Be Equal                                    ${price_per_night_USD_number}                            ${price_per_night_number}
       ${total_price_text}=                               Get Text                                                 xpath:/html/body/div/main/form/div/div/label[3]
       ${total_price_number_USD}=                         convert to number                                        ${total_price_text}         0
       ${calculated_price_USD}=                           Evaluate                                                 ${total_price_number_SEK} * ${USD_value}
       ${calculated_price_USD_number}=                    convert to number                                        ${calculated_price_USD}        0
       should be equal                                    ${calculated_price_USD_number}                           ${total_price_number_USD}


Select EUR currency
       Click Element                                      id:Currency
       Click Element                                      xpath://*[@id="Currency"]/option[3]


Verify EUR Payment details
       [Arguments]                                        ${EUR_value}
       ${price_per_night_text}=                           Get Text                                                 xpath:/html/body/div/main/form/div/div/label[1]
       ${price_per_night_number}                          convert to number                                        ${price_per_night_text}      0
       ${price_per_night_EUR}=                            Evaluate                                                 ${price_per_night_SEK} * ${EUR_value}
       ${price_per_night_EUR_number}=                     convert to number                                        ${price_per_night_EUR}      0
       Should Be Equal                                    ${price_per_night_EUR_number}                            ${price_per_night_number}
       ${total_price_text}=                               Get Text                                                 xpath:/html/body/div/main/form/div/div/label[3]
       ${total_price_number_EUR}=                         convert to number                                        ${total_price_text}      0
       ${calculated_price_EUR}=                           Evaluate                                                 ${total_price_number_SEK} * ${EUR_value}
       ${calculated_price_EUR_number}=                    convert to number                                        ${calculated_price_EUR}     0
       should be equal                                    ${calculated_price_EUR_number}                           ${total_price_number_EUR}


Select RON currency
       Click Element                                      id:Currency
       Click Element                                      xpath://*[@id="Currency"]/option[4]



Verify RON Payment details
       [Arguments]                                        ${RON_value}
       ${price_per_night_text}=                           Get Text                                                 xpath:/html/body/div/main/form/div/div/label[1]
       ${price_per_night_number}                          convert to number                                        ${price_per_night_text}      0
       ${price_per_night_RON}=                            Evaluate                                                 ${price_per_night_SEK} * ${RON_value}
       ${price_per_night_RON_number}=                     convert to number                                        ${price_per_night_RON}          0
       Should Be Equal                                    ${price_per_night_RON_number}                            ${price_per_night_number}
       ${total_price_text}=                               Get Text                                                 xpath:/html/body/div/main/form/div/div/label[3]
       ${total_price_number_RON}=                         convert to number                                        ${total_price_text}      0
       ${calculated_price_RON}=                           Evaluate                                                 ${total_price_number_SEK} * ${RON_value}
       ${calculated_price_RON_number}                     convert to number                                        ${calculated_price_RON}     0
       should be equal                                    ${calculated_price_RON_number}                           ${total_price_number_RON}


Select CZK currency
       Click Element                                      id:Currency
       Click Element                                      xpath://*[@id="Currency"]/option[5]


Verify CZK Payment details
       [Arguments]                                        ${CZK_value}
       ${price_per_night_text}=                           Get Text                                                 xpath:/html/body/div/main/form/div/div/label[1]
       ${price_per_night_number}                          convert to number                                        ${price_per_night_text}      0
       ${price_per_night_CZK}=                            Evaluate                                                 ${price_per_night_SEK} * ${CZK_value}
       ${price_per_night_CZK_number}=                     convert to number                                        ${price_per_night_CZK}      0
       Should Be Equal                                    ${price_per_night_CZK_number}                            ${price_per_night_number}
       ${total_price_text}=                               Get Text                                                 xpath:/html/body/div/main/form/div/div/label[3]
       ${total_price_number_CZK}=                         convert to number                                        ${total_price_text}      0
       ${calculated_price_CZK}=                           Evaluate                                                 ${total_price_number_SEK} * ${CZK_value}
       ${calculated_price_CZK_number}=                    convert to number                                        ${calculated_price_CZK}        0
       should be equal                                    ${calculated_price_CZK_number}                           ${total_price_number_CZK}


Confirm Payment in CZK
       Select Radio Button                                  Type                                                   MasterCard
       Input Text                                           id:CardHolderFirstName                                 Web7
       Input Text                                           id:CardHolderLastName                                  Testing
       Input Text                                           id:CardNumber                                          1234567891234567
       Click Element                                        id:ExpirationDate
       Click Element                                        xpath://*[@id="ExpirationDate"]/option[8]
       Input Text                                           id:CVV                                                 123
       Click Element                                        id:btn submit-btn
       Wait Until Page Contains                             Your booking has been completed successfully!          timeout=10


Goto my bookings
       Click Element                                        xpath: //*[contains(text(), "Hello")]
       Wait Until Page Contains                             My Bookings                                             timeout=10
       Click Element                                        xpath:/html/body/div/main/div/div/div[1]/ul/li[4]
       Wait Until Page Contains                             My Bookings                                             timeout=10


Verify Booking
       ${Booking_status}=                                   Get Text                                                xpath:/html/body/div/main/div/div/p/span
       Should Be Equal                                      Accepted                                                ${Booking_status}
       Element Should Contain                               xpath:/html/body/div/main/div/div/div[2]/div[2]/div[5]/span                 CZK




End Web Test
        Close Browser
