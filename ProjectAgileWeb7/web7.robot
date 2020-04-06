*** Settings ***
Documentation
Library  SeleniumLibrary

*** Test Cases ***
User can login to website with valid inputs
    [Documentation]
    [Tags]                                  LoginfunctionValid
    Open Browser                            about:blank     chrome
    Go To                                   https://localhost:44364/Identity/Account/Login
    Wait Until Page Contains                Use a local account to log in.
    Input Text                              id:Input_Email        abramane424@gmail.com
    Input Text                              id:Input_Password       Balder111.
    Click Button                            xpath://*[@id="login-submit"]
    Wait Until Page Contains                Hello abramane424@gmail.com!
    Close Browser

User can login to website with invalid password
    [Documentation]
    [Tags]                                  LoginfunctionInvalidPass
    Open Browser                            about:blank     chrome
    Go To                                   https://localhost:44364/Identity/Account/Login
    Wait Until Page Contains                Use a local account to log in.
    Input Text                              id:Input_Email        abramane424@gmail.com
    Input Text                              id:Input_Password       Balder1.
    Click Button                            xpath://*[@id="login-submit"]
    Wait Until Page Contains                Invalid login attempt.
    Close Browser

User can login to website with invalid Email
    [Documentation]
    [Tags]                                  LoginfunctionInvalidEmail
    Open Browser                            about:blank     chrome
    Go To                                   https://localhost:44364/Identity/Account/Login
    Wait Until Page Contains                Use a local account to log in.
    Input Text                              id:Input_Email        abramane42@gmail.com
    Input Text                              id:Input_Password       Balder111.
    Click Button                            xpath://*[@id="login-submit"]
    Wait Until Page Contains                Invalid login attempt.
    Close Browser

User can login to website with no uppercase letter in password
    [Documentation]
    [Tags]                                  LoginfunctionNoUppercase
    Open Browser                            about:blank     chrome
    Go To                                   https://localhost:44364/Identity/Account/Login
    Wait Until Page Contains                Use a local account to log in.
    Input Text                              id:Input_Email        abramane424@gmail.com
    Input Text                              id:Input_Password       balder111.
    Click Button                            xpath://*[@id="login-submit"]
    Wait Until Page Contains                Invalid login attempt.
    Close Browser



