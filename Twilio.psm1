# Module created by Microsoft.PowerShell.Crescendo
class PowerShellCustomFunctionAttribute : System.Attribute { 
    [bool]$RequiresElevation
    [string]$Source
    PowerShellCustomFunctionAttribute() { $this.RequiresElevation = $false; $this.Source = "Microsoft.PowerShell.Crescendo" }
    PowerShellCustomFunctionAttribute([bool]$rElevation) {
        $this.RequiresElevation = $rElevation
        $this.Source = "Microsoft.PowerShell.Crescendo"
    }
}



function Get-PhoneNumber
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(
[Parameter(ParameterSetName='Default')]
[string]$LogLevel,
[Parameter(ParameterSetName='Default')]
[string]$Profile,
[Parameter(ParameterSetName='Default')]
[string]$AccountSid
    )

BEGIN {
    $__PARAMETERMAP = @{
         LogLevel = @{
               OriginalName = '-l='
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
         Profile = @{
               OriginalName = '--profile='
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
         AccountSid = @{
               OriginalName = '--account-sid='
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
    }

    $__outputHandlers = @{
        Default = @{ StreamOutput = $False; Handler = { $args[0] | ConvertFrom-Json } }
    }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    $__commandArgs += 'phone-numbers:list'
    $__commandArgs += '-o=json'
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                $__commandArgs += $value | Foreach-Object {$_}
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message twilio
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("twilio $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore "twilio")) {
          throw "Cannot find executable 'twilio'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            & "twilio" $__commandArgs | & $__handler
        }
        else {
            $result = & "twilio" $__commandArgs
            & $__handler $result
        }
    }
  } # end PROCESS

<#
.SYNOPSIS
 ›   Error: command -? not found

.DESCRIPTION See help for twilio

.PARAMETER LogLevel



.PARAMETER Profile



.PARAMETER AccountSid




#>
}




function Update-PhoneNumber
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(
[Parameter(ParameterSetName='Default')]
[string]$LogLevel,
[Parameter(ParameterSetName='Default')]
[string]$Profile,
[Parameter(ParameterSetName='Default')]
[string]$AccountSid,
[Parameter(Mandatory=$true,ParameterSetName='Default')]
[string]$PhoneNumber,
[Parameter(ParameterSetName='Default')]
[string]$SmsFallbackMethod,
[Parameter(ParameterSetName='Default')]
[string]$SmsFallbackUrl,
[Parameter(ParameterSetName='Default')]
[string]$SmsMethod,
[Parameter(ParameterSetName='Default')]
[string]$SmsUrl,
[Parameter(ParameterSetName='Default')]
[string]$VoiceFallbackMethod,
[Parameter(ParameterSetName='Default')]
[string]$VoiceFallbackUrl,
[Parameter(ParameterSetName='Default')]
[string]$VoiceMethod,
[Parameter(ParameterSetName='Default')]
[string]$VoiceUrl
    )

BEGIN {
    $__PARAMETERMAP = @{
         LogLevel = @{
               OriginalName = '-l='
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
         Profile = @{
               OriginalName = '--profile='
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
         AccountSid = @{
               OriginalName = '--account-sid='
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
         PhoneNumber = @{
               OriginalName = ''
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
         SmsFallbackMethod = @{
               OriginalName = '--sms-fallback-method='
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
         SmsFallbackUrl = @{
               OriginalName = '--sms-fallback-url='
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
         SmsMethod = @{
               OriginalName = '--sms-method='
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
         SmsUrl = @{
               OriginalName = '--sms-url='
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
         VoiceFallbackMethod = @{
               OriginalName = '--voice-fallback-method='
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
         VoiceFallbackUrl = @{
               OriginalName = '--voice-fallback-url='
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
         VoiceMethod = @{
               OriginalName = '--voice-method='
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
         VoiceUrl = @{
               OriginalName = '--voice-url='
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $True
               }
    }

    $__outputHandlers = @{
        Default = @{ StreamOutput = $False; Handler = { $args[0] | ConvertFrom-Json } }
    }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    $__commandArgs += 'phone-numbers:update'
    $__commandArgs += '-o=json'
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                $__commandArgs += $value | Foreach-Object {$_}
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message twilio
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("twilio $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore "twilio")) {
          throw "Cannot find executable 'twilio'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            & "twilio" $__commandArgs | & $__handler
        }
        else {
            $result = & "twilio" $__commandArgs
            & $__handler $result
        }
    }
  } # end PROCESS

<#
.SYNOPSIS
 ›   Error: command -? not found

.DESCRIPTION See help for twilio

.PARAMETER LogLevel



.PARAMETER Profile



.PARAMETER AccountSid



.PARAMETER PhoneNumber



.PARAMETER SmsFallbackMethod



.PARAMETER SmsFallbackUrl



.PARAMETER SmsMethod



.PARAMETER SmsUrl



.PARAMETER VoiceFallbackMethod



.PARAMETER VoiceFallbackUrl



.PARAMETER VoiceMethod



.PARAMETER VoiceUrl




#>
}


