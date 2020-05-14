*** Settings ***
Documentation
Library  SeleniumLibrary
Library  DateTime


*** Keywords ***
Begin Login Test
    Open Browser                            about:blank     ${BROWSER}
    Go To                                   ${URL}
    Wait Until Page Contains                Use a local account to log in.

End Test
    Close Browser

Use Valid Login

    Input Text                              id:Input_Email        balder@hotmail.com
    Input Text                              id:Input_Password       Balder111.
    Click Button                            xpath://*[@id="account"]/div[5]/button
    Wait Until Page Contains                Hello balder@hotmail.com!

Mark As Favourite
    Sleep                                   2s
    Click Element                           xpath://*[@id="favorite-button"]
    Sleep                                   2s
    Click Element                           xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a
    Click Element                           xpath:/html/body/div/main/div/div/div[1]/ul/li[5]/a
    Sleep                                   2s
    Wait Until Page Contains                Ritz Hotel Paris

Delete Favourite

    Click Element                           xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a
    Click Element                           xpath:/html/body/div/main/div/div/div[1]/ul/li[5]/a
    Wait Until Page Contains                Ritz Hotel Paris
    Click Element                           xpath://*[@id="favorite-button"]
    Sleep                                   2s
    Wait Until Page Does Not Contain Element        Ritz Hotel Paris

Multiple Favourite
    Sleep                                   4s
    Click Element                           xpath:/html/body/div[1]/main/div[2]/div[2]/div[1]/div/div[1]/div[2]/div[1]/h2/span/a
    Sleep                                   4s
    Click Element                           xpath:/html/body/div[1]/main/div[2]/div[2]/div[3]/div/div[1]/div[2]/div[1]/h2/span/a
    Sleep                                   4s
    Click Element                           xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a
    Sleep                                   4s
    Click Element                           xpath:/html/body/div/main/div/div/div[1]/ul/li[5]/a
    Sleep                                   4s
    Wait Until Page Contains                Ritz Hotel Paris
    Sleep                                   4s
    Wait Until Page Contains                Eden Hotel Amsterdam

Delete Multiple Favourite

    Click Element                           xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a
    Sleep                                   4s
    Click Element                           xpath:/html/body/div/main/div/div/div[1]/ul/li[5]/a
    Wait Until Page Contains                Ritz Hotel Paris
    Sleep                                   4s
    Click Element                           xpath:/html/body/div/main/div/div[1]/div/div[1]/div[2]/div[1]/h2/span/a
    Sleep                                   4s
    Click Element                           xpath:/html/body/div/main/div/div/div/div[1]/div[2]/div[1]/h2/span/a
    Sleep                                   4s
    Wait Until Page Does Not Contain Element        Ritz Hotel Paris
    Sleep                                           5s
    Wait Until Page Does Not Contain Element        Eden Hotel Amsterdam