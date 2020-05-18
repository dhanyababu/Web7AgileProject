*** Settings ***
Documentation
Library  SeleniumLibrary
Library  DateTime
Library  String


*** Keywords ***
Begin Login Test
    Open Browser                            about:blank     ${BROWSER}
    Go To                                   ${URL}
    Wait Until Page Contains                Use a local account to log in.

Use Valid Login

    Input Text                              id:Input_Email        balder@hotmail.com
    Input Text                              id:Input_Password       Balder111.
    Click Button                            xpath://*[@id="account"]/div[5]/button
    Wait Until Page Contains                Hello balder@hotmail.com!

Book Room

    Go To                                   https://localhost:44364/
    Input Text                              id:search-input        Paris
    Click ELement                           id:check-in
    Press Keys                              id:check-in   CTRL+ARROW_DOWN  ENTER
    Click Element                           id:check-out
    Press Keys                              id:check-out   CTRL+ARROW_DOWN  ENTER
    Sleep                                   4s
    Click Button                            xpath://*[@id="submit-btn"]
    Sleep                                   4s
    Click Element                           xpath://html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[2]/a
    Sleep                                   4s
    Click Element                           xpath:/html/body/div[1]/main/div[2]/div[1]/div[2]/table/thead/tr[4]/td[4]/a
    Sleep                                   4s

Login While Booking Room
    Input Text                              id:user_Email                       balder@hotmail.com
    Input Text                              id:user_PhoneNumber                 0789898989
    Sleep                                   2s
    Click Element                           xpath:/html/body/div/main/a
    Sleep                                   2s
    Click Element                           xpath://html/body/div/main/form/div/div/div/input[1]
    Sleep                                   2s
    Input Text                              id:CardHolderFirstName              Balder
    Input Text                              id:CardHolderLastName               Baldar
    Input Text                              id:CardNumber                       2354653685647354
    Click Element                           xpath://*[@id="ExpirationDate"]
    Press Keys                              id:ExpirationDate           6       ENTER
    Input Text                              id:CVV                              364
    Sleep                                   2s
    Click Element                           xpath://*[@id="btn submit-btn"]
    Sleep                                   2s
    Wait Until Page Contains                Booking Reference

Check If Card-Date Input Appears
    Input Text                              id:user_Email                       balder@hotmail.com
    Input Text                              id:user_PhoneNumber                 0789898989
    Sleep                                   2s
    Click Element                           xpath:/html/body/div/main/a
    Wait Until Page Contains                Card Expiration Date:
    Wait Until Page Contains Element        id:ExpirationDate

Verify Exp Date Is Up To Date
    Input Text                              id:user_Email                       balder@hotmail.com
    Input Text                              id:user_PhoneNumber                 0789898989
    Sleep                                   2s
    Click Element                           xpath:/html/body/div/main/a
    ${xyz}=     Get Text                    xpath://*[@id="ExpirationDate"]/option[1]
    Log                                     ${xyz}
    ${current_month} =                   Get Current Date      local      result_format=%m
    ${current_date_without_zero}=         Replace String Using Regexp      ${current_month}     ^0           ${EMPTY}
    ${current_year} =                   Get Current Date       local      result_format=%Y
    Should Be Equal As Strings            ${xyz}         ${current_date_without_zero} / ${current_year}


End Test
    Close Browser