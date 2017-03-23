# ActiveDirectory


## AutoRemoveGroup.ps1 script
This script is short and to the point. You can schedule this via the Task Schedule if you would like.

The purpose of this script is to scrape through AD groups that you have created and remove all users whose status are set to "Disabled"

This will help aleviate issues if a group is not being properly maintained.

## CreatedThisWeek.ps1 script
This script is created in order to send you or a group an email showing who was created in the past 7 days.

I have added additional LDAP values to this in order to pull information that we want to see in my company