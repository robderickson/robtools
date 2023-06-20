function Get-RTADObject {
    <#
    .SYNOPSIS
    Query Active Directory for objects without the ActiveDirectory module.
    
    .DESCRIPTION
    Use LDAP filter syntax and the System.DirectoryServices.DirectorySearcher class to query Active Directory for
    objects without the ActiveDirectory module. Use the ComputerName parameter and Credential parameter to query
    against a specific domain controller and/or with alternate credentials.
    
    .PARAMETER LdapFilter
    An LDAP search filter using the syntax defined in RFC2254. See:
    - https://docs.microsoft.com/en-us/windows/win32/adsi/search-filter-syntax
    - https://datatracker.ietf.org/doc/html/rfc2254
    
    .PARAMETER ComputerName
    A domain controller or domain to query. If not specified, the current domain is used.
    
    .PARAMETER Credential
    A PSCredential object to use for authentication.
    
    .EXAMPLE
    Get-RTADObject -LdapFilter '(&(objectClass=User)(!(userAccountControl:1.2.840.113556.1.4.803:=2)))'

    This example searches for all enabled user accounts in the current domain.

    .EXAMPLE
    Get-RTADObject -LdapFilter '(&(objectClass=User)(samaccountname=dduck))' -ComputerName 'dc1'

    This example searches for the user account with the samAccountName 'dduck' on the domain
    controller 'dc1'.

    .EXAMPLE
    $params = @{
        LdapFilter = 'department=Human Resources'
        ComputerName = 'example.com'
        Credential = (Get-Credential)
    }
    Get-RTADObject @params

    This example searches for all objects with a department value of 'Human Resources' in the
    example.com domain using alternate credentials.

    .OUTPUTS
    System.Management.Automation.PSCustomObject

    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = 'An LDAP search filter.')]
        [string]$LdapFilter,

        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = 'The name of a domain controller or domain to query.')]
        [string]$ComputerName,

        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = 'A PSCredential object to use for authentication.')]
        [PSCredential]$Credential
    )

    process {
        if ($ComputerName) {
            $bindingServer = $ComputerName
        } else {
            $bindingServer = [adsi]::new().distinguishedName
        }
        if ($Credential) {
            $binding = New-Object System.DirectoryServices.DirectoryEntry("LDAP://$($bindingServer)", $Credential.UserName, $Credential.GetNetworkCredential().Password)
        } else {
            $binding = New-Object System.DirectoryServices.DirectoryEntry("LDAP://$($bindingServer)")
        }

        $directorySearcher = New-Object System.DirectoryServices.DirectorySearcher($binding)
        $directorySearcher.SearchScope = 'subtree'
        $directorySearcher.PageSize = 1000
        $directorySearcher.SizeLimit = 100000
        $directorySearcher.Filter = $LdapFilter        

        $result = $directorySearcher.FindAll()

        foreach ($item in $result) {
            $object = @{}
            $item.Properties.Keys | ForEach-Object {
                $object[$_] = $item.Properties[$_][0]
            }
            [pscustomobject]$object
        }
    }
}
