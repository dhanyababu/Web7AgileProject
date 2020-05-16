*** Settings ***
Documentation
Resource  ../Tests/Resources/keywords.robot
Library  SeleniumLibrary
Test Setup  Begin Login Test
Test Teardown  End Test


*** Variables ***
${BROWSER} =  chrome
${URL} =  https://localhost:44364/Identity/Account/Login


*** Test Cases ***
User can login to website with valid inputs
    [Documentation]
    [Tags]                                  LoginfunctionValid
    Use Valid Login


User can login to website with invalid password
    [Documentation]
    [Tags]                                  LoginfunctionInvalidPass
    Use Invalid Password


User can login to website with invalid Email
    [Documentation]
    [Tags]                                  LoginfunctionInvalidEmail
    Use Invalid Email


User can login to website with no uppercase letter in password
    [Documentation]
    [Tags]                                  LoginfunctionNoUppercase
    No Uppercase Letter In Password



