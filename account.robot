*** Settings ***
Library  SeleniumLibrary

*** Variables ***
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

Select Reason
    Sleep    3s
    Click Element    //form/label/span[contains(@class,'dc-checkbox__label') and contains(.,'The platforms aren’t user-friendly.')]
    Click Element    //form/label/span[contains(@class,'dc-checkbox__label') and contains(.,'I prefer another trading website.')]
    Click Element    //form/label/span[contains(@class,'dc-checkbox__label') and contains(.,'The platforms lack key features or functionality.')]
    
Other Feedback
    Wait Until Element Is Enabled    ${other_trading_platforms_textarea}
    Wait Until Element Is Enabled    ${do_to_improve_textarea}
    Input Text    ${other_trading_platforms_textarea}    competitor name
    Input Text    ${do_to_improve_textarea}    fix the lag
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
    Select Reason
    Other Feedback
    Confirm Close Account

TC03 - Try to log in again
    Relogin