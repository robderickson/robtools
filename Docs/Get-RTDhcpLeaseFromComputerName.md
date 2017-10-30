---
external help file: RobTools-help.xml
Module Name: RobTools
online version: 
schema: 2.0.0
---

# Get-RTDhcpLeaseFromComputerName

## SYNOPSIS
Gets DHCP lease information for the matching computer name.

## SYNTAX

```
Get-RTDhcpLeaseFromComputerName [[-ComputerName] <String[]>] [[-DhcpServer] <String[]>]
```

## DESCRIPTION
Gets DHCP lease information for the matching computer name. If a DHCP server or array of DHCP servers is provided in the DhcpServer parameter, all leases in all scopes on the specified server(s) are searched. If no DHCP servers are provided in the DhcpServer parameter, all leases in all scopes on servers returned by Get-DhcpServerInDC are searched.

## EXAMPLES

### Example 1
```
PS C:\> Get-RTDhcpLeaseFromComputerName -ComputerName windowslaptop

IPAddress       ScopeId         ClientId             HostName             AddressState         LeaseExpiryTime
---------       -------         --------             --------             ------------         ---------------
10.0.0.15       10.0.0.0        ab-cd-ef-01-23-45    windowslaptop.con... Active               11/7/2017 11:38:53 AM
10.1.1.38       10.1.1.0        fe-dc-ba-54-32-10    windowslaptop.con... Active               11/7/2017 10:12:23 AM
```

Finds one or more leases in all scopes on all servers returned by Get-DhcpServerInDC where HostName matches 'windowslaptop.'

### Example 2
```
PS C:\> Get-RTDhcpLeaseFromComputerName -ComputerName windowswk -DhcpServer dhcp01

IPAddress       ScopeId         ClientId             HostName             AddressState         LeaseExpiryTime
---------       -------         --------             --------             ------------         ---------------
10.0.0.47       10.0.0.0        90-78-56-ef-cd-ab    windowswk.contoso... Active               11/4/2017 8:32:17 AM
```

Finds one or more leases in all scopes on the dhcp01 DHCP server where HostName matches 'windowswk.'

## PARAMETERS

### -ComputerName
Name of the computer or computers you want to get lease information for.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DhcpServer
Name or IP address of the server or servers you want to search for lease information.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

