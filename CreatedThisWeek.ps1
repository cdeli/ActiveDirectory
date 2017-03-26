#########################################
# Author: Corey Deli                    #
#                                       #
# Date: March 23, 2017                  #
#                                       #
# Purpose: Send admin email for all new #
# and groups created within last week.  #
#                                       #
# Version: 1.1                          #
#########################################

$week = (Get-Date).AddDays(-7)
$today = (Get-Date).ToString()

# HTML to make the design pretty and not cluttered
$a = $a + "<style>BODYBODY{background-color:Lavender ;}TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}`
TH{border-width: 1px;padding: 5px;border-style: solid;border-color: black;background-color:thistle}TD{border-width: 1px;padding: 5px;border-style: solid;`
border-color: black;background-color:PaleGoldenrod} </style><!--mce:0-->"

# Settings for email
$smtp = "mail.contoso.com"
$port = "587"
$to = "to@contoso.com"
$from = "from@contoso.com"
$subject = "New Users and New Groups created this week"

# Import active directory in order ot pull list of "new"
Import-Module ActiveDirectory

# Run report on users created in the last week
$Users = Get-ADUser -Filter * -Properties * | Where-Object { $_.whenCreated -ge $week } | Sort-Object | `
Select-Object Name,EmployeeID,Title,Department,Mail,physicalDeliveryOfficeName,StreetAddress,City,State,PostalCode,TelephoneNumber,Mobile,whenCreated `
| ConvertTo-Html -Head $a -Body "<H2>Users that have been created during the week of $week.</H2>"

# Run report on all groups created in the last week
$group = Get-ADGroup -Filter * -Properties * | Where-Object { $_.whenCreated -ge $week } | Sort-Object | Select-Object Name,Mail,Description,whenCreated `
| ConvertTo-Html -Head $a -Body "<H2>Groups that have been created during the week of $week.</H2>"

$body = "Creation period from $week to $today ." 
$body += "`n" 
$body += $Users
$body += "`n" 
$body += $group
$body += "`n" 

Send-MailMessage -SmtpServer $smtp -Port $port -To $to -From $from -Subject $subject -Body $body -BodyAsHtml