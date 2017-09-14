function ConvertTo-StaticIPConfig
{
  Get-WmiObject -Class Win32_NetworkAdapterConfiguration |
    Where-Object {$_.IPEnabled -and $_.DHCPEnabled} |
      ForEach-Object
      {
        $_.SetDNSServerSearchOrder($_.DNSServerSearchOrder)
        $_.SetDynamicDNSRegistration('TRUE')
        $_.EnableStatic($_.IPAddress[0], $_.IPSubnet[0])
        $_.SetGateways($_.DefaultIPGateway)
      }
}
