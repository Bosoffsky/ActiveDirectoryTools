$ldapquery = "(&(objectClass=computer))"
$dnsdomain = $env:USERDNSDOMAIN.Split('.')
$root = "DC=$($dnsdomain[0]),DC=$($dnsdomain[1])"
$ldap = New-Object System.DirectoryServices.DirectorySearcher
$ldap.SearchRoot = New-Object System.DirectoryServices.DirectoryEntry("LDAP://$($env:LOGONSERVER.TrimStart('\\')).$($env:USERDNSDOMAIN):636/$($root)")
$ldap.Filter = $ldapquery
$ldap.PropertiesToLoad.Add('name')
$ldap.PropertiesToLoad.Add('ms-mcs-admpwd')
$ldap.PropertiesToLoad.Add('ms-mcs-admpwdexpirationtime')
$ldap.SearchScope = "Subtree"

$ldap.FindAll().Properties | % {
    if ($_.'ms-mcs-admpwd' -ne $null) {
        Write-Host "$($_.name)  -  $($_.'ms-mcs-admpwd')  -  $($([datetime]::FromFileTime([convert]::ToInt64($_.'ms-mcs-admpwdexpirationtime',10))))"
    }
   
}