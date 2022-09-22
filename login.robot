*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${login_button}    //button[@id='dt_login_button']

${select_symbols}    //div[@class='cq-menu-btn']
${synthetic_indices}  //div[contains(@class,'sc-mcd__filter__item') and contains(.,'Synthetic Indices')]  
${volatility_10_1s_Index}    //*[contains(@class,'1HZ10V')]
${rise_button}    //button[@id='dt_purchase_call_button']

${forex}  //div[contains(@class,'sc-mcd__filter__item') and contains(.,'Forex')]  
${AUDUSD}    //*[contains(@class,'frxAUDUSD')]

${contract_type}    //div[@id='dt_contract_dropdown']
${higher_lower_button}    //div[@id='dt_contract_high_low_item']
${lower_button}    //button[@id='dt_purchase_put_button']

*** Keywords ***
# Task 1 Login To Deriv
Login To Deriv
    Open Browser  https://app.deriv.com/  chrome
    Set Selenium Speed    0.05
    Maximize Browser Window
    Wait Until Page Contains Element    dt_login_button    30
    Wait Until Element Is Enabled    ${rise_button}    30
    Click Element    dt_login_button
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']   shon.tzu@besquare.com.my
    Input Password    //input[@type='password']    Password140114!
    Click Element    //button[@type='submit']
    
Switch To Demo
    Wait Until Page Contains Element    ${rise_button}    30 
    Click Element    //div[@id='dt_core_account-info_acc-info']
    # todo1: DEMO (VRTC) should NOT be visible --> meaning currently in REAL acc
    Wait Until Page Contains Element    //div[contains(@id,"dt_CR")]    30  
    Click Element    //li[@id='dt_core_account-switcher_demo-tab']
    # todo2: REAL (dt_cr) should NOT be visible --> meaning currently in DEMO acc
    Wait Until Page Contains Element   //div[contains(@id,"VRTC")]    30
    Click Element    //div[@class='dc-content-expander__content']

# Task 2 Buy Rise Contract
Buy Rise Contract
    # volatility 10 (1s) Index
    Wait Until Element Is Enabled    ${select_symbols}    30
    Click Element    ${select_symbols}
    Wait Until Element Is Enabled    ${synthetic_indices}    30
    Click Element    ${synthetic_indices}
    Wait Until Element Is Enabled    ${volatility_10_1s_Index}    30
    Click Element    ${volatility_10_1s_Index}
    
    # 5 ticks
    # 10USD Stake
    # Rise
    Wait Until Element Is Enabled    ${rise_button}    30
    Click Button    ${rise_button}
    
# Task 3 Buy Lower Contract
Buy Lower Contract
    # AUD/USD
    Wait Until Element Is Enabled    ${select_symbols}    30
    Click Element    ${select_symbols}
    Wait Until Element Is Enabled    ${forex}    30
    Click Element    ${forex}
    Wait Until Element Is Enabled    ${AUDUSD}    30
    Click Element    ${AUDUSD}
    Wait Until Element Is Enabled    ${contract_type}    30
    Click Element    ${contract_type}
    Wait Until Element Is Enabled    ${higher_lower_button}    30
    Click Element    ${higher_lower_button}

    # Barrier: Default
    # Duration: 4 Days
    Wait Until Page Contains Element    //input[@class='dc-input__field']    10
    Press Keys   //input[@class='dc-input__field']    CTRL+A+DEL    4

    # Payout: 15.50 USD
    Wait Until Page Contains Element    //button[@id='dc_payout_toggle_item']    10
    Click Element    //button[@id='dc_payout_toggle_item']
    Click Element       //input[@id='dt_amount_input']
    Wait Until Page Contains Element    //button[@id='dc_payout_toggle_item']    10
    Press Keys   //button[@id='dc_payout_toggle_item']    CTRL+A+DEL    15.50

    # Lower
    Wait Until Element Is Enabled    ${lower_button}    30
    Click Element    ${lower_button}

# Task 4 Check Relative Barrier
# Check Relative Barrier


# Task 5 Check Multiplier Contract Parameter
# Check Multiplier Contract Parameter


*** Test Cases ***
Start Test
    Login To Deriv
    Switch To Demo
    Buy Rise Contract
    Buy Lower Contract
    # Check Relative Barrier
    # Check Multiplier Contract Parameter