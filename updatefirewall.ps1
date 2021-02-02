# run with
# Start-Process powershell -Verb runAs -ArgumentList '\\wsl$\Arch\home\cesar\code\wslxfirewall\updatefirewall.ps1'

try {
    $IPAddress = (Get-NetIPAddress -InterfaceAlias '*WSL*' -AddressFamily IPv4).IPAddress

    Get-NetFirewallRule -Direction Inbound | Where-Object {
        $_.DisplayName -eq "VcXsrv"
    } | ForEach-Object {
        Set-NetFirewallAddressFilter `
            -InputObject (Get-NetFirewallAddressFilter -AssociatedNetFirewallRule $_) `
            -LocalAddress $IPAddress
    }

    [IO.File]::WriteAllLines("\\wsl$\Arch\home\cesar\.wslip", $IPAddress)
} catch {
    Write-Error $_.Exception.ToString()
    Read-Host -Prompt "The above error occurred. Press Enter to exit."
}
