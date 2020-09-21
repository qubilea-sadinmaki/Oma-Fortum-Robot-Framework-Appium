*** Settings ***
Library	 OperatingSystem
Library	 String
Library  Collections
Library  AppiumLibrary
Resource  ${CURDIR}/mobile-locators.robot   


*** Variables ***
 

*** Keywords *** 
Init Android Emulator
    Open Application  http://localhost:4723/wd/hub 
    ...  automationName=UIAutomator2
    ...  platformName=Android  
    ...  platformVersion=11
    ...  fullReset=false  
    ...  noReset=true  
    ...  deviceName=emulator-5554 
    ...  app=${CURDIR}/apks/OmaFortumAndroid11Emulator.apk
    ...  appPackage=air.com.fortum.FortumValpasMobile

Init Android Device
    Open Application  http://localhost:4723/wd/hub 
    ...  automationName=UIAutomator2
    ...  platformName=Android  
    ...  platformVersion=10
    ...  fullReset=false  
    ...  noReset=true  
    ...  deviceName=MUENW19813001810 
    ...  app=${CURDIR}/apks/OmaFortumAndroid10Device.apk
    ...  appPackage=air.com.fortum.FortumValpasMobile

Log App Details
    ${activity}=  AppiumLibrary.Get Activity
    ${contexts}=  AppiumLibrary.Get Contexts 
    BuiltIn.Log To Console  ${activity} 
    BuiltIn.Log To Console  ${contexts} 

Test Demo
    Log App Details
    BuiltIn.Run Keyword If    ${IS_FIRSTRUN}    Activate Demomode
    AppiumLibrary.Wait Until Page Contains  Testitie 1 A 2  45
    Test Main Nav 
    Test Side Nav

Activate Demomode
    BuiltIn.Log To Console    Activating Demomode
    AppiumLibrary.Wait Until Page Contains Element    ${LOGO}  45
    AppiumLibrary.Long Press    ${LOGO}  3000

Close Poll
    AppiumLibrary.Wait Until Page Contains Element  ${CLOSE_POLL_BTN}  45
    AppiumLibrary.Click Element    ${CLOSE_POLL_BTN}

Test Main Nav
    @{items}=    BuiltIn.Set Variable  ${MAIN_NAV_ELEMENTS}
    ${l}=  BuiltIn.Get Length    ${items}
    
    FOR  ${i}  IN RANGE  0  ${l}
        ${item}=  Collections.Get From List    ${items}  ${i}  
        Test Main Nav Item    ${item}
    END

Test Side Nav
    ${items}=  BuiltIn.Set Variable  ${SIDE_NAV_ELEMENTS}
    ${l}=  BuiltIn.Get Length    ${items}
    
    FOR  ${i}  IN RANGE  0  ${l}
        ${item}=  Collections.Get From List    ${items}  ${i}  
        Test Side Nav Item    ${item}
    END
    
Test Main Nav Item
    [Arguments]   ${item} 
    Swipe Down To Tile  accessibility_id=${item.aid}  50
    Sleep  250ms
    # AppiumLibrary.Click Element    accessibility_id=${item.aid}
    AppiumLibrary.Tap    accessibility_id=${item.aid}    x_offset=None    y_offset=None    count=3
    AppiumLibrary.Wait Until Page Contains Element    accessibility_id=${item.pageHeader}  45
    Sleep  250ms
    BuiltIn.Run Keyword    ${item.addKeyword}    ${item}
    AppiumLibrary.Go Back 
    AppiumLibrary.Wait Until Page Does Not Contain Element    accessibility_id=${item.pageHeader}  45
    Sleep  250ms

Test Side Nav Item
    [Arguments]   ${item}
    AppiumLibrary.Click Element    ${SIDE_NAV_BTN} 
    AppiumLibrary.Wait Until Page Contains Element  accessibility_id=${item.aid}  45
    AppiumLibrary.Click Element    accessibility_id=${item.aid}
    AppiumLibrary.Wait Until Page Contains Element    accessibility_id=${item.pageHeader}  45
    Sleep  250ms
    BuiltIn.Run Keyword    ${item.addKeyword}    ${item}
    AppiumLibrary.Go Back 
    AppiumLibrary.Wait Until Page Does Not Contain Element    accessibility_id=${item.pageHeader}  45
    Sleep  250ms

Test Page
    [Arguments]   ${item}
    Log To Console  Page ${item.pageHeader} load success

Test Page Invoice
    [Arguments]   ${item}
    Log To Console  Page ${item.pageHeader} load success
    # History invoice toggle content  >> Open invoice PDF
    Swipe Down To Tile    accessibility_id=History invoice toggle content
    AppiumLibrary.Click Element    accessibility_id=History invoice toggle content
    AppiumLibrary.Wait Until Element Is Visible    accessibility_id=Open invoice PDF
    Sleep  1s
    AppiumLibrary.Click Element    accessibility_id=History invoice toggle content

Swipe Down To Tile
    [Documentation]  swipe_length is percent of screen height (max, 80)
    [Arguments]   ${LookinForTile}  ${swipe_length}=50
    ${offset}  BuiltIn.Evaluate  ${swipe_length}/2  
    ${start_x}  BuiltIn.Evaluate    50 + ${offset}
    ${end_x}  BuiltIn.Evaluate    50 - ${offset} 
    Log To Console  Looking for ${LookinForTile} with swipelength:${swipe_length}, start_x:${start_x}, end_x:${end_x}
    Sleep   250ms

    FOR  ${i}  IN RANGE  10
        ${Status}  ${Value}  Run Keyword and Ignore Error  AppiumLibrary.Page Should Contain Element  ${LookinForTile}
        Run Keyword If   '${Status}' != 'PASS'
        ...   Run Keywords
        ...   Sleep   250ms
        ...   AND   Run Keyword And Ignore Error    Swipe By Percent    50    ${start_x}    50    ${end_x}    500
        Exit For Loop If  '${Status}' == 'PASS'
    END

    Set Suite Variable  ${Status}
    # Run Keyword If   '${Status}' != 'PASS'  Do return Sweep x-y
    Run Keyword If   '${Status}' != 'PASS'   FAIL  Tile Not Found



