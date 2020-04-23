*** Settings ***
Documentation
Library  SeleniumLibrary
Library  DateTime


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

    Click Button                            xpath://*[@id="account"]/div[5]/button
    Wait Until Page Contains                The Email field is required.


End Test
    Close Browser