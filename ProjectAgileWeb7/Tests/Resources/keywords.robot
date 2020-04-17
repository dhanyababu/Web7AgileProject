*** Settings ***
Library                                     SeleniumLibrary
Library                                     DateTime


*** Keywords ***
Open Browser To Start Page
        Open Browser                        about:blank                     ${BROWSER}    options=add_argument("--ignore-certificate-errors")
        Maximize Browser Window
        Go To                                                               ${URL}


Welcome message
        ${link_text_welcome} =               Get Text                       class:display-4
        Should Be Equal                      ${link_text_welcome}           Welcome


Displayed registration
         ${link_text_registration} =          Get Text                      xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a
         Should Be Equal                      ${link_text_registration}     Register

Displayed login
        ${link_text_login} =                  Get Text                      xpath:/html/body/header/nav/div/div/ul[1]/li[2]/a
        Should Be Equal                       ${link_text_login}            Login


Goto register
        Click Element                       xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a


Input valid emailid
        Input Text                            id:Input_Email                  dhanya.babu@iths.se


Input password
        Input Text                             id:Input_Password               Iths2019$


Input confirm password
        Input Text                             id:Input_ConfirmPassword        Iths2019$


Submit register
        Click Button                            id:registerSubmit


End Web Test
        Close Browser
