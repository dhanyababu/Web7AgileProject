*** Settings ***
Library                                     SeleniumLibrary
Library                                     DateTime


*** Keywords ***
Open Browser To Start Page
        Open Browser                        about:blank                     ${BROWSER}	  options=add_argument("--ignore-certificate-errors")
        Maximize Browser Window
        Go To                                                               ${URL}


Welcome message
        Wait Until Element Is Visible        xpath:/html/body/header/nav/div/a              timeout=10
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
        Wait Until Page Contains               Hello                             timeout=10


Goto registration form
        Click Element                         xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a
        Wait Until Page Contains              Manage your account


Goto Profile details
        #Sleep                                   3s
        Click Element                          xpath:/html/body/div/main/div/div/div[1]/ul/li[1]
        Wait Until Page Contains               Profile


Verify displayed user email
        ${link_reg_user_email}                 Get Element Attribute            id:Username                     attribute=value
        Should Be Equal                        ${link_reg_user_email}           dhanyaeuro@gmail.com


Enter mobile number
        Input Text                             id:Input_PhoneNumber             077777777


Enter first name
        Input Text                             id:Input_FirstName               Dhanya


Enter last name
        Input Text                              id:Input_LastName               Babu


Enter Address
        Input Text                              id:Input_Address                abcdsgatan


Enter postcode
        Input Text                              id:Input_PostalCode             41800


Enter city
        Input Text                              id:Input_City                   Göteborg


Enter Country
        Input Text                             id:Input_Country                 Sverige


Save details
        Click Button                            id:update-profile-button
        Wait Until Page Contains                Your profile has been updated


Goto personal details
        Sleep                                   3s
        Click Element                           xpath:/html/body/div/main/div/div/div[1]/ul/li[5]


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
        ${link_email_verify} =                 Get Element Attribute          id:Email                 attribute=value
        Should Be Equal                        ${link_email_verify}            dhanyaeuro@gmail.com


Send verification email
        Click Button                            id:email-verification
        Wait Until Page Contains                Verification email sent. Please check your email        timeout=10


Enter new email
        Input Text                              id:Input_NewEmail              mailmedhanyarineesh@gmail.com
        Click Button                            id:change-email-button
        Wait Until Page Contains               Confirmation link to change email sent                   timeout=10


Input invalid emailid
        Input Text                              id:Input_Email                  abcd
        Click Element                           id:Input_Password
        Wait Until Element Is Visible            id:Input_Email-error                                   timeout=10
        ${link_email_error} =                   Get Text                        id:Input_Email-error
        Should Be Equal                        ${link_email_error}              The Email field is not a valid e-mail address.


Input invalid password
        Input Text                           id:Input_Password                  abcd
        Click Element                        id:Input_ConfirmPassword
        Wait Until Element Is Visible        id:Input_Password-error                                    timeout=10
        ${link_pwd_error} =                  Get Text                          id:Input_Password-error
        Should Be Equal                       ${link_pwd_error}                 The Password must be at least 6 and at max 100 characters long.


Verify confirm password
        Input Text                           id:Input_Password                   abcdefg
        Input Text                           id:Input_ConfirmPassword            abcd
        Click Element                        xpath:/html/body/div/main/div/div[1]/form/button
        Wait Until Element Is Visible        id:Input_ConfirmPassword-error                             timeout=10
        ${link_pwd_mismatch} =               Get Text                            id:Input_ConfirmPassword-error
        Should Be Equal                      ${link_pwd_mismatch}                The password and confirmation password do not match.


Register with empty email
        Input Text                           id:Input_Email                     ${EMPTY}
        Input Text                           id:Input_Password                   abcdefg
        Input Text                           id:Input_ConfirmPassword            abcdefg
        Click Element                        xpath:/html/body/div/main/div/div[1]/form/button
        Wait Until Element Is Visible        id:Input_Email-error                                   timeout=10
        ${link_email_error} =                Get Text                            id:Input_Email-error
        Should Be Equal                      ${link_email_error}                 The Email field is required.


Register with empty password
        Input Text                           id:Input_Email                      dhanyaeuro@gmail.com
        Input Text                           id:Input_Password                   ${EMPTY}
        Input Text                           id:Input_ConfirmPassword            abcdefg
        Click Element                        xpath:/html/body/div/main/div/div[1]/form/button
        Wait Until Element Is Visible         id:Input_ConfirmPassword-error                        timeout=10
        ${link_pwd_mismatch} =               Get Text                            id:Input_ConfirmPassword-error
        Should Be Equal                      ${link_pwd_mismatch}                The password and confirmation password do not match.


Register with empty confirm password
        Input Text                           id:Input_Email                      dhanyaeuro@gmail.com
        Input Text                           id:Input_Password                   abcdefg
        Input Text                           id:Input_ConfirmPassword            ${EMPTY}
        Click Element                        xpath:/html/body/div/main/div/div[1]/form/button
        Wait Until Element Is Visible        id:Input_ConfirmPassword-error                         timeout=10
        ${link_pwd_mismatch} =               Get Text                            id:Input_ConfirmPassword-error
        Should Be Equal                      ${link_pwd_mismatch}                The password and confirmation password do not match.

Goto password
        Click Element                        xpath:/html/body/div/main/div/div/div[1]/ul/li[3]
        Wait Until Page Contains             Change password                        timeout=10


Change password
        Input Text                           id:Input_OldPassword                   Pqrs123$
        Input Text                           id:Input_NewPassword                   Abcd123$
        Input Text                           id:Input_ConfirmPassword               Abcd123$
        Click Element                        xpath://*[@id="change-password-form"]/button
        Wait Until Page Contains             Your password has been changed.         timeout=10
        Click Element                        xpath:/html/body/header/nav/div/div/ul[1]/li[2]/form/button
        Wait Until Page Contains             Welcome                                  timeout=10


Verify change password
        Click Element                       xpath:/html/body/header/nav/div/div/ul[1]/li[2]/a
        Wait Until Page Contains            Log in                                          timeout=10
        Input Text                          id:Input_Email                                  dhanyaeuro@gmail.com
        Input Text                          id:Input_Password                               Abcd123$
        Click Element                       xpath://*[@id="account"]/div[5]/button
        Wait Until Page Contains            Hello                             timeout=10
        Click Element                       xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a
        Wait Until Page Contains            Manage your account                             timeout=10
        Click Element                       xpath:/html/body/div/main/div/div/div[1]/ul/li[5]
        Wait Until Page Contains            Personal Data                                   timeout=10
        Click Element                       xpath://*[@id="delete"]
        Wait Until Page Contains            Delete Personal Data                            timeout=10
        Input Text                          id:Input_Password                               Abcd123$
        Click Element                       xpath://*[@id="delete-user"]/button
        ${link_text_welcome} =              Get Text                                        class:display-4
        Should Be Equal                     ${link_text_welcome}                            Welcome



Goto Login
        Wait Until Element Is Visible       xpath:/html/body/header/nav/div/div/ul[1]/li[2]/a            timeout=10
        Click Element                       xpath:/html/body/header/nav/div/div/ul[1]/li[2]/a
        Wait Until Page Contains            Log in                                          timeout=10



Verify new user link
        Click Element                       xpath://*[@id="account"]/div[6]/p[2]/a
        Wait Until Page Contains            Register                                         timeout=10
        Element Should Be Visible           id:Input_Email
        Element Should Be Visible           id:Input_Password
        Element Should Be Visible           id:Input_ConfirmPassword
        Element Should Be Visible           xpath:/html/body/div/main/div/div[1]/form/button




End Web Test
        Close Browser
