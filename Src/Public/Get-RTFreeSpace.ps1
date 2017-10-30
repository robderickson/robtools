function Get-RTFreeSpace {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('cn')]
        [string[]]$ComputerName,

        [Parameter()]
        [Alias('DriveLetter')]
        [string]$DeviceID,

        [Parameter()]
        [string]$DriveType = 3
        
    )

    BEGIN {}

    PROCESS {
        foreach ($computer in $ComputerName) {
            $disks = Get-WmiObject -query "SELECT deviceid,freespace,size FROM win32_logicaldisk WHERE drivetype='$DriveType'" -ComputerName $computer |
                select DeviceID,Freespace,Size,@{n='PercentFree';e={"{0:P0}" -f ($_.freespace / $_.size)}}
            
            if ($DeviceID) {
                $disks = $disks | Where-Object {$_.DeviceID -eq $DeviceID}
            }

            foreach ($disk in $disks) {
                $info = @{
                    ComputerName = $computer
                    DeviceID = $disk.DeviceID
                    Size = "{0:N2}" -f ($disk.Size / 1GB)
                    Freespace = "{0:N2}" -f ($disk.Freespace / 1GB)
                    PercentFree = $disk.PercentFree
                }
                $obj = New-Object -TypeName PSObject -Property $info
                Write-Output $obj
            }
        }
    }

    END {}
}