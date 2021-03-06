$name = Read-Host "Enter the AD account that should be removed from assignment"
$pool = Read-Host "Enter the View desktop pool name to search"
Write-Host "Searching for $name in $pool ..."
$success = 0

ForEach ($vm in (Get-DesktopVM -pool_id $pool))
	{
	If ($vm.user_displayname -match $name)
		{
		Remove-UserOwnership -machine_id $vm.machine_id
		Write-Host "$name has been unassigned from a desktop named $($vm.Name) in pool $pool"
		$success = 1
		}
	}

If ($success -eq 0) {Write-Host "Could not find $name in $pool"}