# Remove users from groups when disabled
#
# Author: Corey Deli
# Date: 3/11/2017
#
# This script relies on the use of Alias's. If you would like to use full wording please remove the following characters, % ?
# You would replace the characters like so
#
# % = ForEach-Object
# ? = Where-Object
Import-Module ActiveDirectory

$GroupOU = # Remove this comment and add the pathing for the group OU(s) in your structre (OU=Groups,DC=Contoso,DC=com)

Get-ADGroup -Filter 'GroupCategory -eq "Security" -or GroupCategory -eq "Distribution"' -SearchBase $searchOU | 
	ForEach-Object{{ $group = $_}
	Get-ADGroupMember -Identity $group -Recursive | 
	ForEach-Object { 
		Get-ADUser -Identity $_.distinguishedName -Properties Enabled | Where-Object {$_.Enabled -eq $false}} | 
		ForEach-Object {-Object{ $user = $_}
			$UserName = $user.Name
			$GroupName = $group.Name
		Remove-ADGroupMember -Identity $group -Member $user -Confirm:$false
	}
}