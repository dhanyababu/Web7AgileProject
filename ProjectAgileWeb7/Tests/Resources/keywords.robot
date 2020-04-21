*** Settings ***
Library                                     SeleniumLibrary
Library                                     DateTime


*** Keywords ***
Open Browser To Start Page
        Open Browser                        about:blank                     ${BROWSER}
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
        Click Element                        xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a


Input valid emailid
        Input Text                           id:Input_Email                  dhanyaeuro@gmail.com


Input password
        Input Text                           id:Input_Password               Pqrs123$


Input confirm password
        Input Text                           id:Input_ConfirmPassword        Pqrs123$


Submit register
        Click Element                        xpath:/html/body/div/main/div/div[1]/form/button


Welcome user
        Wait Until Page Contains               Hello


Goto registration form
        Click Element                         xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a
        Wait Until Page Contains              Manage your account


Goto Profile details
        #Sleep                                   3s
        Click Element                          xpath:/html/body/div/main/div/div/div[1]/ul/li[1]
        Wait Until Page Contains               Profile


Verify displayed user email
        ${link_reg_user_email}                 Get Element Attribute       id:Username     attribute=value
        Should Be Equal                        ${link_reg_user_email}      dhanyaeuro@gmail.com


Enter mobile number
        Input Text                             id:Input_PhoneNumber         077777777


Enter first name
        Input Text                             id:Input_FirstName           Dhanya


Enter last name
        Input Text                              id:Input_LastName           Babu


Enter Address
        Input Text                              id:Input_Address            abcdsgatan


Enter postcode
        Input Text                              id:Input_PostalCode         41800


Enter city
        Input Text                              id:Input_City               Göteborg


Enter Country
        Input Text                             id:Input_Country            Sverige


Save details
        Click Button                            id:update-profile-button
        Wait Until Page Contains               Your profile has been updated


Goto personal details
        Sleep                                   3s
        Click Element                         xpath:/html/body/div/main/div/div/div[1]/ul/li[5]


Delete user
        Wait Until Page Contains                Personal Data                               timeout=10
        Click Element                           xpath://*[@id="delete"]
        Wait Until Page Contains                Delete Personal Data                        timeout=10
        Input Text                              id:Input_Password                           Pqrs123$
        Click Element                           xpath://*[@id="delete-user"]/button
        ${link_text_welcome} =                  Get Text                                    class:display-4
         Should Be Equal                        ${link_text_welcome}                        Welcome


Goto Email
        Click Element                           xpath:/html/body/div/main/div/div/div[1]/ul/li[2]
        Wait Until Page Contains                Manage Email                                timeout=10


Verify email displayed in verification
        ${link_email_verify} =                 Get Element Attribute            id:Email        attribute=value
        Should Be Equal                        ${link_email_verify}             dhanyaeuro@gmail.com


Send verification email
        Click Button                            id:email-verification
        Wait Until Page Contains                Verification email sent. Please check your email      timeout=10


Enter new email
        Input Text                              id:Input_NewEmail              mailmedhanyarineesh@gmail.com
        Click Button                            id:change-email-button
        Wait Until Page Contains               Confirmation link to change email sent. Please check your email.         timeout=10



End Web Test
        Close Browser
