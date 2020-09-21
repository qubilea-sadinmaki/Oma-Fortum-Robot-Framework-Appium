*** Settings ***
Library	 OperatingSystem
Library	 String
Library  Collections


*** Variables ***
${json_path}  ../data/oma_fortum_ui.json
${LOGO}    accessibility_id=Header logo
${DEMO_HEADER}    accessibility_id=Dashboard selected contract address
${CLOSE_POLL_BTN}  accessibility_id=Close NPS feedback modal
${EXIT_DEMO_BTN}  accessibility_id=Logout from demo mode
${SIDE_NAV_BTN}  accessibility_id=Open side navigation
${CLOSE_SIDE_NAV_BTN}  accessibility_id=Dashboard side navi item

# MAIN NAV

&{SOLAR_PRODUCTION}  aid=Solar production tile  pageHeader=Solar navigation title  addKeyword=Test Page  addArg=no
&{FIKSU_ENERGY_MONITORING}  aid=Ffe consumption tile  pageHeader=Ffe navigation title  addKeyword=Test Page  addArg=no
&{ELECTRICITY_CONSUMPTION}  aid=Electricity consumption tile  pageHeader=Consumption electricity navigation title  addKeyword=Test Page  addArg=no
# Consumption chart toggle temperature
&{ELECTRICITY_PRICE}  aid=Spot price tile  pageHeader=Spot price navigation title  addKeyword=Test Page  addArg=no
&{INVOICES_OPEN}  aid=Invoices tile  pageHeader=Invoices navigation title  addKeyword=Test Page Invoice  addArg=no
# (click) History invoice toggle content  >> Open invoice PDF
&{CONTRACTS}  aid=Contracts tile  pageHeader=Contracts navigation title  addKeyword=Test Page  addArg=no
&{HOME_INSURANCE}  aid=Insurance tile  pageHeader=Insurance navigation title  addKeyword=Test Page  addArg=no
@{MAIN_NAV_ELEMENTS}  ${SOLAR_PRODUCTION}  ${FIKSU_ENERGY_MONITORING}  ${ELECTRICITY_CONSUMPTION}  ${ELECTRICITY_PRICE}  ${INVOICES_OPEN}  ${CONTRACTS}  ${HOME_INSURANCE}

# SIDE NAV
&{NOTIFICATIONS}  aid=MessageInbox side navi item  pageHeader=Inbox navigation title  addKeyword=Test Page  addArg=no
&{CONSUMPTION ALERT}  aid=Consumption alert side navi item  pageHeader=Alerts navigation title  addKeyword=Test Page  addArg=no
&{WHATS NEW}  aid=Change log side navi item  pageHeader=Changelog navigation title  addKeyword=Test Page  addArg=no
&{CUSTOMER SERVICE}  aid=Customer support side navi item  pageHeader=Customer support navigation title  addKeyword=Test Page  addArg=no
&{COLLECT SUN HOURS}  aid=Join sunny side navi item  pageHeader=Join sunny navigation title  addKeyword=Test Page  addArg=no
@{SIDE_NAV_ELEMENTS}  ${NOTIFICATIONS}  ${CONSUMPTION ALERT}  ${WHATS NEW}  ${CUSTOMER SERVICE}  ${COLLECT SUN HOURS}  