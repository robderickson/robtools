function New-RandomPwd {
    [CmdletBinding()]
    param(
        [int]$Length = 16,
        [switch]$ExcludeAmbiguousCharacters,
        [switch]$ExcludeSpecialCharacters,
        [switch]$ExcludeNumbers,
        [switch]$ExcludeUpperCase
    )

    $Chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+-=[]\{}|;:><?,./0123456789'
    
    if ($ExcludeAmbiguousCharacters) {
        $ExcludedChars += 'BDglIOqQSZ12058|'
    }
    if ($ExcludeSpecialCharacters) {
        $ExcludedChars += '!@#$%^&*()_+-=[]\{}|;:><?,./'
    }
    if ($ExcludeNumbers) {
        $ExcludedChars += '0123456789'
    }
    if ($ExcludeUpperCase) {
        $ExcludedChars += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    }

    $hashtable = [ordered]@{}
    foreach ($char in $Chars.ToCharArray()) {
        $hashtable.Add($char, $null)
    }
    if ($ExcludedChars) {
        foreach ($char in $ExcludedChars.ToCharArray()) {
            $hashtable.Remove($char)
        }
    }
    $Chars = -join $hashtable.Keys

    ([string]$Chars[(1..$Length | ForEach-Object { Get-Random -Maximum $Chars.Length })]).Replace(' ', $null)
}