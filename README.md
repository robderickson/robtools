# RobTools
A PowerShell module with miscellaneous wrappers to quickly perform common tasks. 

# Get-RTDhcpLeaseFromComputerName

## SYNOPSIS
Gets DHCP lease information for the matching computer name.

## SYNTAX

```
Get-RTDhcpLeaseFromComputerName [-ComputerName] <String[]> [[-DhcpServer] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
A wrapper for the DhcpServer module's cmdlets to get DHCP lease information for the matching computer name. If a DHCP server or array of DHCP servers is provided in the DhcpServer parameter, all leases in all scopes on the specified server(s) are searched. If no DHCP servers are provided in the DhcpServer parameter, all leases in all scopes on servers returned by Get-DhcpServerInDC are searched.

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
Aliases: cn

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -DhcpServer
Name or IP address of the server or servers you want to search for lease information.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Server

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

# Get-RTFreeSpace

## SYNOPSIS
Get free space of disks on the specified computer.

## SYNTAX

```
Get-RTFreeSpace [-ComputerName] <String[]> [[-DeviceID] <String>] [[-DriveType] <String>] [<CommonParameters>]
```

## DESCRIPTION
A wrapper to query the Win32_LogicalDisk WMI class and report drive space of disks on the specified computer. By default, this command returns available space of all local disks on the specified computer.

## EXAMPLES

### Example 1
```
PS C:\> Get-RTFreeSpace -ComputerName localhost

Freespace    : 12.85
Size         : 60.00
ComputerName : localhost
PercentFree  : 21 %
DeviceID     : C:

Freespace    : 9.88
Size         : 10.00
ComputerName : localhost
PercentFree  : 99 %
DeviceID     : D:
```

Gets drive space statistics of all local disks on localhost.

### Example 2
```
PS C:\> Get-RTFreeSpace -ComputerName localhost -DeviceID C:

Freespace    : 12.85
Size         : 60.00
ComputerName : localhost
PercentFree  : 21 %
DeviceID     : C:
```

### Example 2
```
PS C:\> Get-RTFreeSpace -ComputerName localhost -DriveType 4

Freespace    : 953.54
Size         : 1,024.00
ComputerName : localhost
PercentFree  : 93 %
DeviceID     : H:
```

Gets drive space statistics of all network disks on localhost.

## PARAMETERS

### -ComputerName
Name of computer to get logical disk statistics from.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: cn

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -DeviceID
ID of the logical disk to get statistics from (typically drive letter).

```yaml
Type: String
Parameter Sets: (All)
Aliases: DriveLetter

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -DriveType
Integer representing type of logical disks to get statistics from.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

