*** Settings ***
library    SeleniumLibrary

*** Variables ***

${url}                             https://th.trip.com/?locale=en-TH&curr=THB
${browser}                         gc

${locator_findBooking}             id=header_action_ordersearch
${locator_btn_searchEmail}         id=trip_main_content
${locator_email}                   xpath=//*[@id="__next"]/div[2]/div/div/div[2]/div[3]/div/form/div/div[1]/div/input
${locator_getverifyCode}           xpath=//*[@id="__next"]/div[2]/div/div/div[2]/div[3]/div/form/div/div[2]/div/button
${locator_msg_invalidemail}        xpath=//*[@id="__next"]/div[2]/div/div/div[2]/div[3]/div/form/div/div[1]/div[2]/span


*** Keywords ***

Open default page

    set selenium speed          1s
    open browser                ${url}   ${browser}
    Maximize Browser Window
    Wait Until Page Contains    Find bookings

Verify Find booking page
    Wait Until Page Contains    Find bookings
    Click Element               ${locator_findBooking}
    Wait Until Page Contains    Enter the email you used to book and we'll send you a verification code

Verify Input Email Pass
    Wait Until Element Is Visible  ${locator_email}
    Input Text                     ${locator_email}      glost2662@gmail.com
    Click Element                  ${locator_getverifyCode}
    Wait Until Page Contains       Please check your email to find the 6-digit verification code and enter it below

Verify Input Email Fail
    Wait Until Element Is Visible  ${locator_email}
    Input Text                     ${locator_email}      ddd
    Click Element                  ${locator_getverifyCode}
    Wait Until Page Contains       Please provide a valid email

Verify Required Email Field
    Wait Until Element Is Visible  ${locator_email}
    Click Element                  ${locator_getverifyCode}
    Wait Until Page Contains       Please enter a valid email address


*** Test Cases ***

TC_Open default page
    Open default page
    Verify Find booking page
    Close Browser

TC_Verify Input Email Pass
    Open default page 
    Verify Find booking page
    Verify Input Email Pass
    Close Browser

TC_Verify Input Email Fail
    Open default page
    Verify Find booking page
    Verify Input Email Fail
    Close Browser

TC_Required Email Field
    Open default page
    Verify Find booking page
    Verify Required Email Field
    Close Browser


