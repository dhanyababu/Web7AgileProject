*** Settings ***
Library                                     SeleniumLibrary
Library                                     DateTime


*** Keywords ***
Open Browser To Start Page
        Open Browser                        about:blank                                 ${BROWSER}      options=add_argument("--ignore-certificate-errors")
        Maximize Browser Window
        Go To                                                                           ${URL}


Welcome message
        Wait Until Element Is Visible        xpath:/html/body/header/nav/div/a          timeout=10
        ${link_text_welcome} =               Get Text                                   class:display-4
        Should Be Equal                      ${link_text_welcome}                       Find your dream destination


Displayed registration
         ${link_text_registration} =         Get Text                                    xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a
         Should Be Equal                     ${link_text_registration}                   Register

Displayed login
        ${link_text_login} =                 Get Text                                    xpath:/html/body/header/nav/div/div/ul[1]/li[2]/a
        Should Be Equal                      ${link_text_login}                          Login


Goto register
        Click Element                       xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a
        Wait Until Page Contains            Register                                        timeout=10


Input valid emailid
        Wait Until Page Contains            Create a new account                          timeout=10
        Wait Until Page Contains Element    id:Input_Email                                timeout=10
        Input Text                          id:Input_Email                                dhanyaeuro@gmail.com


Input password
        Wait Until Page Contains Element    id:Input_Password                             timeout=10
        Input Text                          id:Input_Password                             Pqrs123$


Input confirm password
        Wait Until Page Contains Element    id:Input_ConfirmPassword                      timeout=10
        Input Text                          id:Input_ConfirmPassword                      Pqrs123$


Submit register
        Click Element                       xpath:/html/body/div/main/div/div[1]/form/button


Welcome user
        Wait Until Page Contains            Hello                                         timeout=10


Goto registration form
        Click Element                       xpath:/html/body/header/nav/div/div/ul[1]/li[1]/a
        Wait Until Page Contains            Manage your account                           timeout=10


Goto Profile details
        Click Element                       xpath:/html/body/div/main/div/div/div[1]/ul/li[1]
        Wait Until Page Contains            Profile                         timeout=10


Verify displayed user email
        ${link_reg_user_email}              Get Element Attribute            id:Username                     attribute=value
        Should Be Equal                     ${link_reg_user_email}           dhanyaeuro@gmail.com


Enter mobile number
        Input Text                          id:Input_PhoneNumber             077777777


Enter first name
        Input Text                          id:Input_FirstName               Dhanya


Enter last name
        Input Text                           id:Input_LastName               Babu


Enter Address
        Input Text                           id:Input_Address                abcdsgatan


Enter postcode
        Input Text                           id:Input_PostalCode             41800


Enter city
        Input Text                           id:Input_City                   Göteborg


Enter Country
        Input Text                           id:Input_Country                Sverige


Save details
        Click Button                         id:update-profile-button
        Wait Until Page Contains             Your profile has been updated                          timeout=10


Goto Email
        Click Element                        xpath:/html/body/div/main/div/div/div[1]/ul/li[2]
        Wait Until Page Contains             Manage Email                                           timeout=10


Input invalid emailid
        Input Text                           id:Input_Email                  abcd
        Click Element                        id:Input_Password
        Wait Until Element Is Visible        id:Input_Email-error            timeout=10
        ${link_email_error} =                Get Text                        id:Input_Email-error
        Should Be Equal                      ${link_email_error}             The Email field is not a valid e-mail address.


Input invalid password
        Wait Until Page Contains Element     id:Input_Password                timeout=10
        Input Text                           id:Input_Password                abcd
        Click Element                        id:Input_ConfirmPassword
        Wait Until Element Is Visible        id:Input_Password-error          timeout=10
        ${link_pwd_error} =                  Get Text                         id:Input_Password-error
        Should Be Equal                      ${link_pwd_error}                The Password must be at least 6 and at max 100 characters long.


Verify confirm password
        Input Text                           id:Input_Password                 abcdefg
        Input Text                           id:Input_ConfirmPassword          abcd
        Click Element                        xpath:/html/body/div/main/div/div[1]/form/button
        Wait Until Element Is Visible        id:Input_ConfirmPassword-error      timeout=10
        ${link_pwd_mismatch} =               Get Text                            id:Input_ConfirmPassword-error
        Should Be Equal                      ${link_pwd_mismatch}                The password and confirmation password do not match.


Register with empty email
        Input Text                           id:Input_Email                     ${EMPTY}
        Input Text                           id:Input_Password                   abcdefg
        Input Text                           id:Input_ConfirmPassword            abcdefg
        Click Element                        xpath:/html/body/div/main/div/div[1]/form/button
        Wait Until Element Is Visible        id:Input_Email-error                                       timeout=10
        ${link_email_error} =                Get Text                            id:Input_Email-error
        Should Be Equal                      ${link_email_error}                 The Email field is required.


Register with empty password
        Input Text                           id:Input_Email                      dhanyaeuro@gmail.com
        Input Text                           id:Input_Password                   ${EMPTY}
        Input Text                           id:Input_ConfirmPassword            abcdefg
        Click Element                        xpath:/html/body/div/main/div/div[1]/form/button
        Wait Until Element Is Visible         id:Input_ConfirmPassword-error     timeout=10
        ${link_pwd_mismatch} =               Get Text                            id:Input_ConfirmPassword-error
        Should Be Equal                      ${link_pwd_mismatch}                The password and confirmation password do not match.


Register with empty confirm password
        Input Text                           id:Input_Email                      dhanyaeuro@gmail.com
        Input Text                           id:Input_Password                   abcdefg
        Input Text                           id:Input_ConfirmPassword            ${EMPTY}
        Click Element                        xpath:/html/body/div/main/div/div[1]/form/button
        Wait Until Element Is Visible        id:Input_ConfirmPassword-error      timeout=10
        ${link_pwd_mismatch} =               Get Text                            id:Input_ConfirmPassword-error
        Should Be Equal                      ${link_pwd_mismatch}                The password and confirmation password do not match.

Login with valid deatils
        Input Text                          id:Input_Email                        dhanyaeuro@gmail.com
        Input Text                          id:Input_Password                     Pqrs123$
        Click Element                       xpath://*[@id="account"]/div[5]/button
        Wait Until Page Contains            Hello                             timeout=10


Goto password
        Click Element                        xpath:/html/body/div/main/div/div/div[1]/ul/li[2]
        Wait Until Page Contains             Change password                        timeout=10


Change password
        Wait Until Page Contains             Change password                        timeout=10
        Wait Until Page Contains Element     id:Input_OldPassword                   timeout=10
        Wait Until Page Contains             Current password                       timeout=10
        Input Text                           id:Input_OldPassword                   Pqrs123$
        Wait Until Page Contains Element     id:Input_NewPassword                   timeout=10
        Wait Until Page Contains             New password                           timeout=10
        Input Text                           id:Input_NewPassword                   Abcd123$
        Wait Until Page Contains Element     id:Input_ConfirmPassword               timeout=10
        Wait Until Page Contains             Confirm new password                   timeout=10
        Input Text                           id:Input_ConfirmPassword               Abcd123$
        Click Element                        xpath://*[@id="change-password-form"]/button
        Wait Until Page Contains             Your password has been changed.         timeout=10
        Wait Until Page Contains             Logout                                  timeout=10
        Wait Until Page Contains Element     xpath: //*[contains(text(), "Logout")]   timeout=10
        Click Element                        xpath: //*[contains(text(), "Logout")]
        Sleep                                5
        Wait Until Page Contains             Find your dream destination             timeout=10


Verify change password
        Wait Until Page Contains Element    xpath:/html/body/header/nav/div/div/ul[1]/li[2]     timeout=10
        Click Element                       xpath: //*[contains(text(), "Login")]
        Wait Until Page Contains            Log in                                   timeout=10
        Wait Until Page Contains            Email                                    timeout=10
        Wait Until Page Contains Element    id:Input_Email                           timeout=10
        Input Text                          id:Input_Email                           dhanyaeuro@gmail.com
        Wait Until Page Contains Element    id:Input_Password                        timeout=10
        Input Text                          id:Input_Password                        Abcd123$
        Click Element                       xpath://*[@id="account"]/div[5]/button
        Wait Until Page Contains            Hello                                    timeout=10
        Click Element                       xpath:/html/body/header/nav/div/div/ul[1]/li[2]/form/button
        Wait Until Page Contains            Find your dream destination              timeout=10


Login with new password
        Wait Until Page Contains            Log in                                   timeout=10
        Wait Until Page Contains            Email                                    timeout=10
        Wait Until Page Contains Element    id:Input_Email                           timeout=10
        Input Text                          id:Input_Email                           testaccount@gmail.com
        Wait Until Page Contains Element    id:Input_Password                        timeout=10
        Input Text                          id:Input_Password                        Test123$
        Click Element                       xpath://*[@id="account"]/div[5]/button
        Wait Until Page Contains            Hello                                    timeout=10


Verify invalid current password
        Wait Until Page Contains             Change password                        timeout=10
        Wait Until Page Contains Element    id:Input_OldPassword                    timeout=10
        Input Text                          id:Input_OldPassword                    Pqrs123$
        Wait Until Page Contains Element    id:Input_NewPassword                    timeout=10
        Input Text                          id:Input_NewPassword                    Abcd123$
        Wait Until Page Contains Element    id:Input_ConfirmPassword                timeout=10
        Input Text                          id:Input_ConfirmPassword                Abcd123$
        Click Element                       xpath://*[@id="change-password-form"]/button
        Wait Until Page contains             Incorrect password.                    timeout=10


Verify invalid confirm password
        Wait Until Page Contains Element    id:Input_OldPassword                   timeout=10
        Input Text                          id:Input_OldPassword                   Test123$
        Input Text                          id:Input_NewPassword                   Pqrs123$
        Input Text                          id:Input_ConfirmPassword               Pqrs123
        Click Element                       xpath://*[@id="change-password-form"]/button
        ${link_invalid_cur_pwd}=            Get Text                               id:Input_ConfirmPassword-error
        Should Be Equal                     ${link_invalid_cur_pwd}                The new password and confirmation password do not match.


Verify invalid new password
        Wait Until Page Contains Element    id:Input_OldPassword                   timeout=10
        Input Text                          id:Input_OldPassword                   Test123$
        Input Text                          id:Input_NewPassword                   Pqrs
        Click Element                       id:Input_ConfirmPassword
        ${link_invalid_new_pwd}=            Get Text                               id:Input_NewPassword-error
        Should Be Equal                     ${link_invalid_new_pwd}                The New password must be at least 6 and at max 100 characters long.


Goto Login
        Wait Until Page Contains Element    xpath:/html/body/header/nav/div/div/ul[1]/li[2]/a         timeout=10
        Click Element                       xpath:/html/body/header/nav/div/div/ul[1]/li[2]/a
        Wait Until Page Contains            Log in                                                  timeout=10



Verify new user link
        Click Element                       xpath://*[@id="account"]/div[6]/p[2]/a
        Wait Until Page Contains            Register                                         timeout=10
        Element Should Be Visible           id:Input_Email
        Element Should Be Visible           id:Input_Password
        Element Should Be Visible           id:Input_ConfirmPassword
        Element Should Be Visible           xpath:/html/body/div/main/div/div[1]/form/button




End Web Test
        Close Browser
