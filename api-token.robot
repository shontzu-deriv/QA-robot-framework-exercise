*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${login_button}    //button[@type='submit']
${create_button}   //div[@class='da-api-token__input-group']//button[@type='submit']

${read_checkbox}    //span[contains(@class,'dc-text') and contains(.,'Read')]
${payment_checkbox}    //span[contains(@class,'dc-text') and contains(.,'Payments')]
${admin_checkbox}    //span[contains(@class,'dc-text') and contains(.,'Admin')]
${trade_checkbox}    //span[contains(@class,'dc-text') and contains(.,'Trade')]
${trading_information_checkbox}    //span[contains(@class,'dc-text') and contains(.,'Trading information')]

${token_name_input}    //input[@name='token_name']

*** Keywords ***
Login To Deriv
    Open Browser  https://app.deriv.com/account/api-token  chrome
    Maximize Browser Window
    Set Selenium Speed    0.1
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']   shon.tzu@besquare.com.my
    Input Password    //input[@type='password']    Password140114!
    Click Element    ${login_button}

Min Length Validation
    Click Element    ${token_name_input}
    Press Keys    ${token_name_input}    1
    Element Should Be Visible    //div[contains(@class,'dc-field--error') and contains(.,'Length of token name must be between 2 and 32 characters.')]
Max Length Validation
    Press Keys    ${token_name_input}    CTRL+A+DEL    Lorem ipsum dolor sit amet consectetur adipiscing elit 
    Element Should Be Visible    //div[contains(@class,'dc-field--error') and contains(.,'Maximum 32 characters.')]
    
Special Symbol Validation
    Press Keys    ${token_name_input}    CTRL+A+DEL    1?
    Element Should Be Visible    //div[contains(@class,'dc-field--error') and contains(.,'Only letters, numbers, and underscores are allowed.')]
   
String Validation   
    Press Keys    ${token_name_input}    CTRL+A+DEL    123_
    Element Should Not Be Visible    //div[@class='dc-field--error']
   
Read Token
    Wait Until Page Contains Element    ${read_checkbox}    30
    Click Element    ${read_checkbox}
    Click Element    ${token_name_input}
    Press Keys    ${token_name_input}    CTRL+A+DEL    Read
    Click Element    ${create_button}

Payment Token
    Wait Until Page Contains Element    ${payment_checkbox}    30
    Click Element    ${payment_checkbox}
    Click Element    ${token_name_input}
    Press Keys    ${token_name_input}    CTRL+A+DEL    Payment
    Click Element    ${create_button}

Admin Token
    Wait Until Page Contains Element    ${admin_checkbox}    30
    Click Element    ${admin_checkbox}
    Click Element    ${token_name_input}
    Press Keys    ${token_name_input}    CTRL+A+DEL    Admin
    Click Element    ${create_button}


Trade Token
    Wait Until Page Contains Element    ${trade_checkbox}    30
    Click Element    ${trade_checkbox}
    Click Element    ${token_name_input}
    Press Keys    ${token_name_input}    CTRL+A+DEL    Trade
    Click Element    ${create_button}

Trading Information Token
    Wait Until Page Contains Element    ${trading_information_checkbox}    30
    Click Element    ${trading_information_checkbox}
    Click Element    ${token_name_input}
    Press Keys    ${token_name_input}    CTRL+A+DEL    Trading Information
    Click Element    ${create_button}

List Of Tokens
    Page Should Contain Element    //tr/td/span[contains(.,'Read')]
    Page Should Contain Element    //tr/td/span[contains(.,'Read and Trade')]

Read Trade Token
    Sleep    1s
    Click Element    ${read_checkbox}
    Click Element    ${trade_checkbox}
    Click Element    ${token_name_input}
    Press Keys    ${token_name_input}    CTRL+A+DEL    Read and Trade
    Click Element    ${create_button}

Read Trade Payment Token
    Sleep    1s
    Click Element    ${read_checkbox}
    Click Element    ${trade_checkbox}
    Click Element    ${payment_checkbox}
    Click Element    ${token_name_input}
    Press Keys    ${token_name_input}    CTRL+A+DEL    Read Trade and Pay
Copy Paste
    Wait Until Element Is Enabled    //tr[2]/td[2]/div/div[2]
    Click Element    //tr[2]/td[2]/div/div[2]
    Click Element    ${token_name_input}
    Press Keys    ${token_name_input}    CTRL+v
    Click Element    ${create_button}
Delete Token Cancel
    Wait Until Element Is Enabled    //tr[1]/td[5]
    Click Element    //tr[2]/td[5]
    Wait Until Element Is Enabled    //button[contains(@class,'dc-btn--secondary'])]
    Click Element    //button[contains(@class,'dc-btn--secondary'])]

Delete Token Yes
    Wait Until Element Is Enabled    //tr[1]/td[5]
    Click Element    //tr[2]/td[5]
    Wait Until Element Is Enabled    //button[contains(@class,'dc-btn--primary')]
    Click Element    //button[contains(@class,'dc-btn--primary')]


*** Test Cases ***
TC01 Login
    Login To Deriv

TC02 Input Validation
    Wait Until Page Contains Element    ${token_name_input}    30
    Min Length Validation
    Max Length Validation
    Special Symbol Validation
    String Validation

TC03 Check individual Checkbox
    Read Token
    Payment Token
    Admin Token
    Trade Token
    Trading Information Token

TC04 Check multiple Checkboxes
    Read Trade Token
    Read Trade Payment Token

TC05 List Tokens
    List Of Tokens

TC06 Copy Pasting Token
    Copy Paste

TC07 Delete
    Delete Token Cancel
    Delete Token Yes



    









# Should Match Regexp    ${token_name_input}    ^[A-Za-z0-9_-]{2,32}$
