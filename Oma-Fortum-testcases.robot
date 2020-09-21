*** Settings ***
Documentation  Tests for Oma Fortum app on Android (emulator & device).
...            Tests mainly basic menu functionality 
Metadata         Version    0.1  
Library  AppiumLibrary
Resource     ${CURDIR}/resources/mobile-resources.robot
Test Teardown  AppiumLibrary.Close All Applications 

*** Variables ***
${IS_FIRSTRUN}  ${FALSE}

*** Test Cases ***

Test Android With Emulator
        [Tags]  android  emulator
        Init Android Emulator
        Test Demo

Test Android With Device
        [Tags]  android  device
        Init Android Device
        Test Demo