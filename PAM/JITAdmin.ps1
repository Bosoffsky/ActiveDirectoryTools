# Check 


Enable-ADOptionalFeature "Privileged Access Management Feature" -Scope ForestOrConfigurationSet -Target <Forest-Root-domain>
Add-ADGroupMember -Identity <Group> -Members User -MemberTimeToLive (New-TimeSpan -Seconds 3600)