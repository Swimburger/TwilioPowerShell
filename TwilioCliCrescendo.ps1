Import-Module Microsoft.PowerShell.Crescendo

$NewConfiguration = @{
  '$schema' = 'https://aka.ms/PowerShell/Crescendo/Schemas/2021-11'
  Commands = @()
}

Function Add-CommandDefaults{
  param(
    $Command
  )
  
  $LogLevelParameter = New-ParameterInfo -Name 'LogLevel' -OriginalName '-l='
  $LogLevelParameter.ParameterType = 'string'
  $LogLevelParameter.NoGap = $True
  $LogLevelParameter.ParameterSetName = 'Default'
  $Command.Parameters += $LogLevelParameter

  $ProfileParameter = New-ParameterInfo -Name Profile -OriginalName '--profile='
  $ProfileParameter.ParameterType = 'string'
  $ProfileParameter.NoGap = $True
  $ProfileParameter.ParameterSetName = 'Default'
  $Command.Parameters += $ProfileParameter

  $AccountSidParameter = New-ParameterInfo -Name AccountSid -OriginalName '--account-sid='
  $AccountSidParameter.ParameterType = 'string'
  $AccountSidParameter.NoGap = $True
  $AccountSidParameter.ParameterSetName = 'Default'
  $Command.Parameters += $AccountSidParameter

  $JsonOutHandler = New-OutputHandler
  $JsonOutHandler.ParameterSetName = 'Default'
  $JsonOutHandler.Handler = '$args[0] | ConvertFrom-Json'
  $JsonOutHandler.HandlerType = 'Inline'  
  $Command.OutputHandlers += $JsonOutHandler
}

Function Create-GetPhoneNumberCommand{
  $Command = New-CrescendoCommand -Verb Get -Noun PhoneNumber -OriginalName twilio
  $Command.OriginalCommandElements = @('phone-numbers:list', '-o=json')

  Add-CommandDefaults $Command

  $Command
}

Function Create-UpdatePhoneNumberCommand{
  $Command = New-CrescendoCommand -Verb Update -Noun PhoneNumber -OriginalName twilio
  $Command.OriginalCommandElements = @('phone-numbers:update', '-o=json')
  
  Add-CommandDefaults $Command

  $PhoneNumberSidParameter = New-ParameterInfo -Name PhoneNumber -OriginalName ''
  $PhoneNumberSidParameter.ParameterType = 'string'
  $PhoneNumberSidParameter.NoGap = $True
  $PhoneNumberSidParameter.ParameterSetName = 'Default'
  $PhoneNumberSidParameter.Mandatory = $True
  $Command.Parameters += $PhoneNumberSidParameter

  $SmsFallBackMethodParameter = New-ParameterInfo -Name SmsFallbackMethod -OriginalName '--sms-fallback-method='
  $SmsFallBackMethodParameter.ParameterType = 'string'
  $SmsFallBackMethodParameter.NoGap = $True
  $SmsFallBackMethodParameter.ParameterSetName = 'Default'
  $Command.Parameters += $SmsFallBackMethodParameter

  $SmsFallBackUrlParameter = New-ParameterInfo -Name SmsFallbackUrl -OriginalName '--sms-fallback-url='
  $SmsFallBackUrlParameter.ParameterType = 'string'
  $SmsFallBackUrlParameter.NoGap = $True
  $SmsFallBackUrlParameter.ParameterSetName = 'Default'
  $Command.Parameters += $SmsFallBackUrlParameter
  
  $SmsMethodParameter = New-ParameterInfo -Name SmsMethod -OriginalName '--sms-method='
  $SmsMethodParameter.ParameterType = 'string'
  $SmsMethodParameter.NoGap = $True
  $SmsMethodParameter.ParameterSetName = 'Default'
  $Command.Parameters += $SmsMethodParameter

  $SmsUrlParameter = New-ParameterInfo -Name SmsUrl -OriginalName '--sms-url='
  $SmsUrlParameter.ParameterType = 'string'
  $SmsUrlParameter.NoGap = $True
  $SmsUrlParameter.ParameterSetName = 'Default'
  $Command.Parameters += $SmsUrlParameter

  $VoiceFallbackMethodParameter = New-ParameterInfo -Name VoiceFallbackMethod -OriginalName '--voice-fallback-method='
  $VoiceFallbackMethodParameter.ParameterType = 'string'
  $VoiceFallbackMethodParameter.NoGap = $True
  $VoiceFallbackMethodParameter.ParameterSetName = 'Default'
  $Command.Parameters += $VoiceFallbackMethodParameter

  $VoiceFallbackUrlParameter = New-ParameterInfo -Name VoiceFallbackUrl -OriginalName '--voice-fallback-url='
  $VoiceFallbackUrlParameter.ParameterType = 'string'
  $VoiceFallbackUrlParameter.NoGap = $True
  $VoiceFallbackUrlParameter.ParameterSetName = 'Default'
  $Command.Parameters += $VoiceFallbackUrlParameter

  $VoiceMethodParameter = New-ParameterInfo -Name VoiceMethod -OriginalName '--voice-method='
  $VoiceMethodParameter.ParameterType = 'string'
  $VoiceMethodParameter.NoGap = $True
  $VoiceMethodParameter.ParameterSetName = 'Default'
  $Command.Parameters += $VoiceMethodParameter

  $VoiceUrlParameter = New-ParameterInfo -Name VoiceUrl -OriginalName '--voice-url='
  $VoiceUrlParameter.ParameterType = 'string'
  $VoiceUrlParameter.NoGap = $True
  $VoiceUrlParameter.ParameterSetName = 'Default'
  $Command.Parameters += $VoiceUrlParameter

  $Command
}

$NewConfiguration.Commands += Create-GetPhoneNumberCommand
$NewConfiguration.Commands += Create-UpdatePhoneNumberCommand


$NewConfiguration | ConvertTo-Json -Depth 5 | Out-File .\TwilioCliCrescendo.json

Export-CrescendoModule -ConfigurationFile .\TwilioCliCrescendo.json -ModuleName Twilio.psm1 -Force

Import-Module .\Twilio.psd1 -Force

$PhoneNumber = Get-PhoneNumber -LogLevel debug -Verbose

$UpdateParameters = @{
  PhoneNumber = $PhoneNumber.sid
  SmsFallbackMethod = $PhoneNumber.smsFallbackMethod
  SmsFallbackUrl = $PhoneNumber.smsFallbackUrl
  SmsMethod = $PhoneNumber.smsMethod
  SmsUrl = $PhoneNumber.smsUrl
  VoiceFallbackMethod = $PhoneNumber.voiceFallbackMethod
  VoiceFallbackUrl = $PhoneNumber.voiceFallbackUrl
  VoiceMethod = $PhoneNumber.voiceMethod
  VoiceUrl = $PhoneNumber.voiceUrl
}

Update-PhoneNumber -LogLevel debug -Verbose @UpdateParameters
  