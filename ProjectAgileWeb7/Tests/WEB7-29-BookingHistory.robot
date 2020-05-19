*** Settings ***
Documentation   This is test suite of ProjectAgileWeb7 webpage for verifying booking history of user
Resource        ../Tests/Resources/WEB7-29-keywords.robot
Library         SeleniumLibrary
Test Setup      Open Browser To Start Page
Test Teardown   End Web Test


*** Variables ***
${BROWSER} =  chrome
${URL} =     https://localhost:44364/


*** Test Cases ***
Verify booking history
    [Documentation]                 Test to verify that registered user can book hotel rooms and in my bookings page
    ...                             user can see bookings history and details
    [Tags]                          Test WEb7-49
    Goto register
    Register account                testingaccount@gmail.com          Test123$
    Search hotel
    See details
    Enter booking details
    Enter payment details
    Confirm booking
    Goto my bookings
    Verify Booking details


Verify available hotel rooms displayed
    [Documentation]                 Test to verify that available hotel rooms displyed before and after booking
    ...                             and here verifying that after room booking ,displayed room number decreased by one or not
    ...                             Entry Criteria:Account register with user id-testingaccount@gmail.com
    ...                             password-Test123$
    [Tags]                          Test WEb7-255
    Goto login
    login registered account        testingaccount@gmail.com          Test123$
    Search hotel
    See details
    Verify available room number
    Book room
    verify booking in history
    Goto home
    Search hotel
    See details
    Verify available room decreased by one



