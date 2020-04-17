*** Settings ***
Documentation   This is test suite of ProjectAgileWeb7 webpage
Resource        ../Tests/Resources/keywords.robot
Library         SeleniumLibrary
Test Setup      Open Browser To Start Page
Test Teardown   End Web Test


*** Variables ***
${BROWSER} =  chrome
${URL} =     https://localhost:44364/


*** Test Cases ***
Verification of Home page
    [Documentation]             Test to verify that Home page is displayed and registration and login button is present
    [Tags]                      Test 1
    Welcome message
    Displayed registration
    Displayed login


Valid Registration
    [Documentation]             Test to verify that registration page with valid details
    [Tags]                      Test 2
    Goto register
    Input valid emailid
    Input password
    Input confirm password
    Submit register




