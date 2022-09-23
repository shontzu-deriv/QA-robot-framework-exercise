*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${short_placeholder_text}    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
${long_placeholder_text}    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum malesuada congue interdum. Praesent in imperdiet magna, id congue ipsum. Nunc tempus sapien sed dolor sollicitudin sodales. Quisque gravida purus eros.


${rise_button}    //button[@id='dt_purchase_call_button']
${other_trading_platforms_textarea}    //form/div/textarea[@placeholder='If you don’t mind sharing, which other trading platforms do you use?']
${do_to_improve_textarea}    //form/div/textarea[@placeholder='What could we do to improve?']
${submit_feedback_btn}    //form/div/div/button[@type='submit']

${cancel_close_acc_btn}    //button[contains(@class,'dc-btn--secondary') and contains(*,'Go Back')]
${confirm_close_acc_btn}    //button[contains(@class,'dc-btn--primary') and contains (*,'Close account')]

*** Keywords ***
Open Deriv.com
    Open Browser  https://app.deriv.com/account/closing-account  chrome
    Set Selenium Speed    0.2
    Maximize Browser Window
Fill Login Form
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']   shon.tzu@besquare.com.my
    Input Password    //input[@type='password']    Password140114!
    Click Element    //button[@type='submit']

Close Account
    Wait Until Page Contains Element    //button[@type='submit' and contains(@class,'closing-account__button--close-account')]    30
    Click Element    //button[@type='submit' and contains(@class,'closing-account__button--close-account')]
Checkbox Validation
    Input Text    ${other_trading_platforms_textarea}    ${short_placeholder_text}
    Page Should Contain Element    //p[contains(.,'Please select at least one reason')]
    Click Element    //form/label/span[contains(@class,'dc-checkbox__label') and contains(.,'The platforms aren’t user-friendly.')]
    Click Element    //form/label/span[contains(@class,'dc-checkbox__label') and contains(.,'I prefer another trading website.')]
    Click Element    //form/label/span[contains(@class,'dc-checkbox__label') and contains(.,'The platforms lack key features or functionality.')]
    Page Should Not Contain    //p[contains(.,'Please select at least one reason')]
    Press Keys    ${other_trading_platforms_textarea}    CTRL+A+DEL

Textarea Validation
    Wait Until Element Is Enabled    ${other_trading_platforms_textarea}
    Wait Until Element Is Enabled    ${do_to_improve_textarea}
    Press Keys    ${other_trading_platforms_textarea}    CTRL+A+DEL    ${long_placeholder_text}
    Press Keys    ${other_trading_platforms_textarea}    CTRL+A+DEL    ${short_placeholder_text}
    Press Keys    ${do_to_improve_textarea}    ${short_placeholder_text}
    Wait Until Element Is Enabled    ${submit_feedback_btn}
    Click Element    ${submit_feedback_btn}

Confirm Close Account
    Wait Until Element Is Visible    //div[@id='modal_root']
    Wait Until Element Is Enabled    ${cancel_close_acc_btn}    30s
    Click Element    ${cancel_close_acc_btn}
    Wait Until Element Is Enabled    ${submit_feedback_btn}    30s
    Click Element    ${submit_feedback_btn}
    Wait Until Element Is Visible    //div[@id='modal_root']
    Wait Until Element Is Enabled    ${confirm_close_acc_btn}    30s
    Click Element    ${confirm_close_acc_btn}
    Sleep    10s

Relogin
    Wait Until Page Contains Element    //button[@id='dm-nav-login-button']
    Click Element    //button[@id='dm-nav-login-button']
    Fill Login Form


*** Test Cases ***
TC01 - Log in
    Open Deriv.com
    Fill Login Form

TC02 - Close Account
    Close Account
    
TC03 - Form validation to ensure it is properly filled
    Checkbox Validation
    Textarea Validation
    Confirm Close Account

TC03 - Try to log in again
    Relogin