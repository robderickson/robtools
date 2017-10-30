function Get-RTDhcpLeaseFromComputerName {
    [CmdletBinding()]
    param(
        [string[]]$ComputerName = $env:COMPUTERNAME,
        [string[]]$DhcpServer = (Get-DhcpServerInDC | Select-Object -ExpandProperty ipaddress | Select-Object -ExpandProperty ipaddresstostring)
    )

    PROCESS {
        foreach ($computer in $ComputerName) {
            foreach ($server in $DhcpServer) {
                $Scopes = Get-DhcpServerv4Scope -ComputerName $server
                foreach ($scope in $Scopes) {
                    Get-DhcpServerv4Lease -ComputerName $server -ScopeId $scope.scopeid | Where-Object {$_.Hostname -match $computer}
                }              
            }
        }
    }
}