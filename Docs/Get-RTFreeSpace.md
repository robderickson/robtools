---
external help file: RobTools-help.xml
Module Name: RobTools
online version: 
schema: 2.0.0
---

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

