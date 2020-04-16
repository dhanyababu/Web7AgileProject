*** Keywords ***
Begin Login Test
    Open Browser                            about:blank     ${BROWSER}
    Go To                                   ${URL}
    


Use Valid Login
    Input Text                              id:Input_Email        abramane424@gmail.com
    Input Text                              id:Input_Password       Balder111.
    Click Button                            xpath://*[@id="login-submit"]
    Wait Until Page Contains                Hello abramane424@gmail.com!


Use Invalid Password
    Input Text                              id:Input_Email        abramane424@gmail.com
    Input Text                              id:Input_Password       Balder1.
    Click Button                            xpath://*[@id="login-submit"]
    Wait Until Page Contains                Invalid login attempt.


Use Invalid Email
    Input Text                              id:Input_Email        abramane42@gmail.com
    Input Text                              id:Input_Password       Balder111.
    Click Button                            xpath://*[@id="login-submit"]
    Wait Until Page Contains                Invalid login attempt.


No Uppercase Letter In Password
    Input Text                              id:Input_Email        abramane424@gmail.com
    Input Text                              id:Input_Password       balder111.
    Click Button                            xpath://*[@id="login-submit"]
    Wait Until Page Contains                Invalid login attempt.


End Test
    Close Browser
