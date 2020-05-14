*** Settings ***
Documentation
Library  SeleniumLibrary
Library  DateTime


*** Keywords ***
Begin Login Test
    Open Browser                            about:blank     ${BROWSER}		options=add_argument("--ignore-certificate-errors")
    Go To                                   ${URL}
    Wait Until Page Contains                Use a local account to log in.



Use Valid Login

    Input Text                              id:Input_Email        balder@hotmail.com
    Input Text                              id:Input_Password       Balder111.
    Click Button                            xpath://*[@id="account"]/div[5]/button
    Wait Until Page Contains                Hello balder@hotmail.com!


Use Invalid Password

    Input Text                              id:Input_Email        balder@hotmail.com
    Input Text                              id:Input_Password       Balder1.
    Click Button                            xpath://*[@id="account"]/div[5]/button
    Wait Until Page Contains                Invalid login attempt.


Use Invalid Email

    Input Text                              id:Input_Email        balderq@hotmail.com
    Input Text                              id:Input_Password       Balder111.
    Click Button                            xpath://*[@id="account"]/div[5]/button
    Wait Until Page Contains                Invalid login attempt.


No Uppercase Letter In Password

    Input Text                              id:Input_Email        balder@hotmail.com
    Input Text                              id:Input_Password       balder111.
    Click Button                            xpath://*[@id="account"]/div[5]/button
    Wait Until Page Contains                Invalid login attempt.


Click Remember Me

    Click Button                            xpath://*[@id="Input_RememberMe"]
    Input Text                              id:Input_Email        balder@hotmail.com
    Input Text                              id:Input_Password     Balder111.
    Click Button                            xpath://*[@id="account"]/div[5]/button
    Wait Until Page Contains                Hello balder@hotmail.com!
    ${cookie} =  Get Cookie                 .AspNetCore.Identity.Application
    Log                                     Cookies are: ${cookie}
    ${enddate} =    Get Current Date        local  increment=14days  result_format=datetime

    Should Be Equal As Integers             ${cookie.expiry.year}   ${enddate.year}
    Should Be Equal As Integers             ${cookie.expiry.month}  ${enddate.month}




No Inputs

    Click Button                            xpath://*[@id="submit-btn"]
    Wait Until Page Contains                The Email field is required.

Input Text Into Searchbar With Dates

    Input Text                              id:search-input        Paris
    Click ELement                           id:check-in
    Press Keys                              id:check-in   CTRL+ARROW_DOWN  ENTER
    Click Element                           id:check-out
    Press Keys                              id:check-out   CTRL+ARROW_DOWN  ENTER
    Sleep                                   2s
    Click Button                            xpath://*[@id="submit-btn"]
    Wait Until Page Contains                Ritz Hotel Paris
    Wait Until Page Does Not Contain        Corinthia Hotel London
    Wait Until Page Does Not Contain        Eden Hotel Amsterdam

Input Text Into Searchbar No Dates

    Input Text                              id:search-input       Paris
    Click Button                            xpath://*[@id="submit-btn"]
    Wait Until Page Contains                Ritz Hotel Paris
    Wait Until Page Does Not Contain        Corinthia Hotel London
    Wait Until Page Does Not Contain        Eden Hotel Amsterdam

Input Invalid Text Into Searchbar

    Input Text                              id:search-input        Paros
    Click Button                            xpath://*[@id="submit-btn"]
    Wait Until Page Contains                No results

Test WiFi Filter

    Click Element                           xpath://html/body/div[1]/main/div[2]/div[1]/form/div[1]/div[1]/label
    Click Button                            xpath://html/body/div[1]/main/div[2]/div[1]/form/div[4]/input
    Wait until Page Contains                Ritz Hotel Paris
    Wait until Page Contains                Eden Hotel Amsterdam
    WAit Until Page Contains                Paris France Hotel
    Wait Until Page Does Not Contain        Corinthia Hotel London
    Click Element                           xpath:/html/body/div[1]/main/a
    Wait Until Page Contains                Corinthia Hotel London


Test Breakfast Filter

    Click Element                           xpath://html/body/div[1]/main/div[2]/div[1]/form/div[1]/div[2]/label
    Click Button                            xpath://html/body/div[1]/main/div[2]/div[1]/form/div[4]/input
    Wait until Page Contains                Ritz Hotel Paris
    Wait Until Page Does Not Contain        Paris France Hotel
    Wait Until Page Does Not Contain        Corinthia Hotel London
    Sleep                                   2s
    Click Element                           xpath:/html/body/div[1]/main/a
    Sleep                                   2s
    Wait Until Page Contains                Corinthia Hotel London
    Wait Until Page Contains                Paris France Hotel

Test Room Service Filter

    Click Element                           xpath://html/body/div[1]/main/div[2]/div[1]/form/div[1]/div[3]/label
    Click Button                            xpath://html/body/div[1]/main/div[2]/div[1]/form/div[4]/input
    Wait until Page Contains                Eden Hotel Amsterdam
    Wait until Page Does Not Contain        Ritz Hotel Paris
    Wait Until Page Does Not Contain        Paris France Hotel
    Wait Until Page Does Not Contain        Corinthia Hotel London
    Sleep                                   2s
    Click Element                           xpath:/html/body/div[1]/main/a
    Sleep                                   2s
    Wait Until Page Contains                Corinthia Hotel London
    Wait Until Page Contains                Paris France Hotel
    Wait until Page Contains                Ritz Hotel Paris
    Wait until Page Contains                Eden Hotel Amsterdam

Test Fitness Center Filter

    Click Element                           xpath://html/body/div[1]/main/div[2]/div[1]/form/div[1]/div[4]/label
    Click Button                            xpath://html/body/div[1]/main/div[2]/div[1]/form/div[4]/input
    Wait until Page Does Not Contain        Eden Hotel Amsterdam
    Wait until Page Does Not Contain        Ritz Hotel Paris
    Wait Until Page Does Not Contain        Paris France Hotel
    Wait Until Page Contains                Corinthia Hotel London
    Sleep                                   2s
    Click Element                           xpath:/html/body/div[1]/main/a
    Sleep                                   2s
    Wait Until Page Contains                Corinthia Hotel London
    Wait Until Page Contains                Paris France Hotel
    Wait until Page Contains                Ritz Hotel Paris
    Wait until Page Contains                Eden Hotel Amsterdam

Test Pool Filter

    Click Element                           xpath://html/body/div[1]/main/div[2]/div[1]/form/div[1]/div[5]/label
    Click Button                            xpath://html/body/div[1]/main/div[2]/div[1]/form/div[4]/input
    Wait until Page Does Not Contain        Corinthia Hotel London
    Wait until Page Does Not Contain        Ritz Hotel Paris
    Wait Until Page Does Not Contain        Paris France Hotel
    Wait Until Page Contains                Eden Hotel Amsterdam
    Sleep                                   2s
    Click Element                           xpath:/html/body/div[1]/main/a
    Sleep                                   2s
    Wait Until Page Contains                Corinthia Hotel London
    Wait Until Page Contains                Paris France Hotel
    Wait until Page Contains                Ritz Hotel Paris
    Wait until Page Contains                Eden Hotel Amsterdam

Test Sauna Filter

    Click Element                           xpath://html/body/div[1]/main/div[2]/div[1]/form/div[1]/div[5]/label
    Click Button                            xpath://html/body/div[1]/main/div[2]/div[1]/form/div[4]/input
    Wait until Page Does Not Contain        Corinthia Hotel London
    Wait until Page Does Not Contain        Ritz Hotel Paris
    Wait Until Page Does Not Contain        Paris France Hotel
    Wait Until Page Contains                Eden Hotel Amsterdam
    Sleep                                   2s
    Click Element                           xpath:/html/body/div[1]/main/a
    Sleep                                   2s
    Wait Until Page Contains                Corinthia Hotel London
    Wait Until Page Contains                Paris France Hotel
    Wait until Page Contains                Ritz Hotel Paris
    Wait until Page Contains                Eden Hotel Amsterdam

Three Star Filter

    Click Element                           xpath://html/body/div[1]/main/div[2]/div[1]/form/div[2]/div[1]/label
    Click Button                            xpath://html/body/div[1]/main/div[2]/div[1]/form/div[4]/input
    Wait until Page Does Not Contain        Corinthia Hotel London
    Wait until Page Does Not Contain        Ritz Hotel Paris
    Wait Until Page Does Not Contain        Eden Hotel Amsterdam
    Wait Until Page Contains                Paris France Hotel
    Sleep                                   2s
    Click Element                           xpath:/html/body/div[1]/main/a
    Sleep                                   2s
    Wait Until Page Contains                Corinthia Hotel London
    Wait Until Page Contains                Paris France Hotel
    Wait until Page Contains                Ritz Hotel Paris
    Wait until Page Contains                Eden Hotel Amsterdam

Four Star Filter

    Click Element                           xpath://html/body/div[1]/main/div[2]/div[1]/form/div[2]/div[2]/label
    Click Button                            xpath://html/body/div[1]/main/div[2]/div[1]/form/div[4]/input
    Wait until Page Does Not Contain        Corinthia Hotel London
    Wait until Page Does Not Contain        Ritz Hotel Paris
    Wait Until Page Does Not Contain        Paris France Hotel
    Wait Until Page Contains                Eden Hotel Amsterdam
    Sleep                                   2s
    Click Element                           xpath:/html/body/div[1]/main/a
    Sleep                                   2s
    Wait Until Page Contains                Corinthia Hotel London
    Wait Until Page Contains                Paris France Hotel
    Wait until Page Contains                Ritz Hotel Paris
    Wait until Page Contains                Eden Hotel Amsterdam

Five Star Filter

    Click Element                           xpath://html/body/div[1]/main/div[2]/div[1]/form/div[2]/div[3]/label
    Click Button                            xpath://html/body/div[1]/main/div[2]/div[1]/form/div[4]/input
    Wait until Page Contains                Corinthia Hotel London
    Wait until Page Contains                Ritz Hotel Paris
    Wait Until Page Does Not Contain        Paris France Hotel
    Wait Until Page Does Not Contain        Eden Hotel Amsterdam
    Sleep                                   2s
    Click Element                           xpath:/html/body/div[1]/main/a
    Sleep                                   2s
    Wait Until Page Contains                Corinthia Hotel London
    Wait Until Page Contains                Paris France Hotel
    Wait until Page Contains                Ritz Hotel Paris
    Wait until Page Contains                Eden Hotel Amsterdam

1km Filter

    Click Element                           xpath://html/body/div[1]/main/div[2]/div[1]/form/div[3]/div[1]/label
    Click Button                            xpath://html/body/div[1]/main/div[2]/div[1]/form/div[4]/input
    Wait until Page Contains                Eden Hotel Amsterdam
    Wait until Page Does Not Contain        Ritz Hotel Paris
    Wait Until Page Does Not Contain        Paris France Hotel
    Wait Until Page Does Not Contain        Corinthia Hotel London
    Sleep                                   2s
    Click Element                           xpath:/html/body/div[1]/main/a
    Sleep                                   2s
    Wait Until Page Contains                Corinthia Hotel London
    Wait Until Page Contains                Paris France Hotel
    Wait until Page Contains                Ritz Hotel Paris
    Wait until Page Contains                Eden Hotel Amsterdam

3km Filter

    Click Element                           xpath://html/body/div[1]/main/div[2]/div[1]/form/div[3]/div[2]/label
    Click Button                            xpath://html/body/div[1]/main/div[2]/div[1]/form/div[4]/input
    Wait until Page Contains                Eden Hotel Amsterdam
    Wait Until Page Contains                Corinthia Hotel London
    Wait until Page Does Not Contain        Ritz Hotel Paris
    Wait Until Page Does Not Contain        Paris France Hotel
    Sleep                                   2s
    Click Element                           xpath:/html/body/div[1]/main/a
    Sleep                                   2s
    Wait Until Page Contains                Corinthia Hotel London
    Wait Until Page Contains                Paris France Hotel
    Wait until Page Contains                Ritz Hotel Paris
    Wait until Page Contains                Eden Hotel Amsterdam

5km Filter

    Click Element                           xpath://html/body/div[1]/main/div[2]/div[1]/form/div[3]/div[3]/label
    Click Button                            xpath://html/body/div[1]/main/div[2]/div[1]/form/div[4]/input
    Wait until Page Contains                Eden Hotel Amsterdam
    Wait Until Page Contains                Corinthia Hotel London
    Wait Until Page Contains                Paris France Hotel
    Wait until Page Does Not Contain        Ritz Hotel Paris
    Sleep                                   2s
    Click Element                           xpath:/html/body/div[1]/main/a
    Sleep                                   2s
    Wait Until Page Contains                Corinthia Hotel London
    Wait Until Page Contains                Paris France Hotel
    Wait until Page Contains                Ritz Hotel Paris
    Wait until Page Contains                Eden Hotel Amsterdam

10km Filter

    Click Element                           xpath://html/body/div[1]/main/div[2]/div[1]/form/div[3]/div[4]/label
    Click Button                            xpath://html/body/div[1]/main/div[2]/div[1]/form/div[4]/input
    Wait until Page Contains                Eden Hotel Amsterdam
    Wait Until Page Contains                Corinthia Hotel London
    Wait Until Page Contains                Paris France Hotel
    Wait until Page Contains                Ritz Hotel Paris
    Sleep                                   2s
    Click Element                           xpath:/html/body/div[1]/main/a
    Sleep                                   2s
    Wait Until Page Contains                Corinthia Hotel London
    Wait Until Page Contains                Paris France Hotel
    Wait until Page Contains                Ritz Hotel Paris
    Wait until Page Contains                Eden Hotel Amsterdam


Change Window Size
    [Arguments]                      ${width}                       ${height}
    Set Window Size                  ${width}                       ${height}


End Test
    Close Browser