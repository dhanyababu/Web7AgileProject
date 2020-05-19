*** Settings ***
Documentation   This is test suite of ProjectAgileWeb7 webpage testing with external account login
Resource        ../Tests/Resources/WEB7-153-keywords.robot
Library         SeleniumLibrary
Test Setup      Open Browser To Start Page
Test Teardown   End Web Test


*** Variables ***
${BROWSER} =  chrome
${URL} =     https://localhost:44364/


*** Test Cases ***
Verify external link is redirecting
         [Documentation]            Test to verify that External account link provided in the home page is working and check
         ...                        external account link is redirecting to another page to link google account
         [Tags]                     Test WEB7-181
         Goto Login page
         Click External link
         Verify external page


Verify external account invalid login
         [Documentation]            Test to verify that verify external login by using an invalid google id and
         ...                        verify result should not be able to login
         [Tags]                     Test WEB7-230
         Goto Login page
         Click External link
         Verify external page
         Login with Empty id         ${EMPTY}
         Login with Invalid Id       dhanyababu@hotmail.com



Verify external account register with new id
         [Documentation]            Test to verify that verify external login by using an valid id and
         ...                        verify result should not be able to login
         [Tags]                     Test WEB7-229
         Goto Login page
         Click External link
         Register with external id     web7agile@gmail.com    Test123$


Verify hotel booking by using registered external account
        [Documentation]            Test to verify that verify that hotel booking by using already registered external account
        ...                        Entry Criteria:Register an account using external registration link
        ...                        Firstrun test case Tag-Test WEB7-229
         [Tags]                    Test WEB7-209
         Goto Login page
         Click External link
         Login with external id    web7agile@gmail.com    Test123$
         Search hotel
         See details
         Book room
         Enter payment details
         Confirm booking


Verify external account registration with already registered email id
         [Documentation]            Test to verify that verify that an external account registration where that email id is
         ...                        already registered in the webapp.Here registering web7agile@gmail.com account first
         ...                        then again trying to register thorugh external account
         ...                        Entry Criteria: Delete the account already registered with id web7agile@gmail.com
         [Tags]                     Test WEB7-229 1.1
         Goto register
         Register account          web7testing@gmail.com   Test123$
         Goto Login page
         Click External link
         Register with external existing id   web7testing@gmail.com    Test123$









