function Get-RTFreeSpace {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [Alias('cn')]
        [string[]]$ComputerName,

        [Parameter(ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [string]$DriveType = 3
        
    )

    BEGIN {}

    PROCESS {
        foreach ($computer in $ComputerName) {
            $CimInstanceSplat = @{
                CimSession = New-CimSession -ComputerName $computer
                Query = "SELECT Capacity,FreeSpace,SystemName,Name FROM Win32_Volume WHERE drivetype='$DriveType'"
            }
            $volumes = Get-CimInstance @CimInstanceSplat

            foreach ($volume in $volumes) {
                [PSCustomObject]@{
                    ComputerName = $volume.SystemName
                    Name = $volume.Name
                    Capacity = "{0:N2}" -f ($volume.Capacity / 1GB)
                    Freespace = "{0:N2}" -f ($volume.FreeSpace / 1GB)
                    PercentFree = "{0:P0}" -f ($volume.FreeSpace / $volume.Capacity)
                }
            }
        }
    }

    END {}
}