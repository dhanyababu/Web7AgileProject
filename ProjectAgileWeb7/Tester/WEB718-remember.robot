*** Settings ***
Documentation
Resource  ../Tester/Resources/keywords.robot
Library  SeleniumLibrary
Test Setup  Begin Login Test
Test Teardown  End Test


*** Variables ***
${BROWSER} =  chrome
${URL} =  https://localhost:44364/Identity/Account/Login
${cookie} =


*** Test Cases ***

User Can Save Their Login Info
    [Documentation]
    [Tags]
    Click Remember Me
