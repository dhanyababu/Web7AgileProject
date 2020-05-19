*** Settings ***
Documentation   This is test suite of ProjectAgileWeb7 webpage for verifying map location displayed
Resource        ../Tests/Resources/WEB7-35-keywords.robot
Library         SeleniumLibrary
Test Setup      Open Browser To Start Page
Test Teardown   End Web Test


*** Variables ***
${BROWSER} =  chrome
${URL} =     https://localhost:44364/


*** Test Cases ***
Verify Location image is displayed
        [Documentation]                         Test to verify that in the hotel details page  google image is present
        [Tags]                                  Test WEb7-160
        Goto hotel details                      London
        Googlemap image is displayed


Verify Location image is displayed subtestcase
        [Documentation]                         Test to verify that in the hotel details page  google image is present
        [Tags]                                  Test WEb7-160 1.1
        Goto hotel details                      Paris
        Googlemap image is displayed


Verify Location link is working
        [Documentation]                         Test to verify that in the hotel details page, google image is present and
        ...                                     that image should contain link that should be redireting to the map
        [Tags]                                  Test WEb7-161
        Goto hotel details                      Paris
        Verify page contains link               https://www.bing.com/maps/directions?cp=48.866954~2.360468&sty=r&lvl=16&rtp=~pos.48.866954_2.360468____&amp;FORM=MBEDLD
        Verifying Hypertext reference link      https://www.bing.com/maps/directions?cp=48.866954~2.360468&sty=r&lvl=16&rtp=~pos.48.866954_2.360468____&amp;FORM=MBEDLD
        Verify link is redirecting or not


Verify Location link is working sub testcase
         [Documentation]                        Test to verify that in the hotel details page, google image is present and
        ...                                     that image should contain link that should be redireting to the map
        [Tags]                                  Test WEb7-161 1.1
        Goto hotel details                      London
        Verify page contains link               https://www.bing.com/maps/directions?cp=51.506753~-0.124422&sty=r&lvl=16&rtp=~pos.51.506753_-0.124422____&amp;FORM=MBEDLD
        Verifying Hypertext reference link      https://www.bing.com/maps/directions?cp=51.506753~-0.124422&sty=r&lvl=16&rtp=~pos.51.506753_-0.124422____&amp;FORM=MBEDLD
        Verify link is redirecting or not