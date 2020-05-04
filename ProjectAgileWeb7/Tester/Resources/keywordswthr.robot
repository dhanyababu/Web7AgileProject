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

Check Weather Appearance

    Click Element                           xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[2]/a
    Wait Until Page Contains Element               xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div

End Test
    Close Browser