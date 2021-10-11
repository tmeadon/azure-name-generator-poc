[CmdletBinding()]
param
(
    # Path to the json file containing naming templates
    [Parameter(Mandatory)]
    [string]
    $TemplateJsonPath,

    # Output file path
    [Parameter()]
    [string]
    $OutputFile = 'naming.bicep'
)

# validate input file exists
if (-not (Test-Path -Path $TemplateJsonPath)) { throw "Unable to find file $TemplateJsonPath" }

# load the template file as a hashtable
$data = Get-Content -Path $TemplateJsonPath -Raw | ConvertFrom-Json -AsHashtable

# find all the tokens in use and store each one once in an array
$allTokens = @()

foreach ($key in $data.Keys)
{
    $tokenMatches = ($data[$key] | Select-String -Pattern '{([^{}]*)}' -AllMatches).Matches.Groups.Where({$_.Name -eq '1'}).Value
    
    foreach ($token in $tokenMatches)
    {
        if ($allTokens -notcontains $token) { $allTokens += $token }
    }
}

# build the bicep template's parameter lines
$paramLines = ""

foreach ($token in $allTokens)
{
    $paramLines += "param $($token) string`n"
}

# build the bicep template's output lines
$outputLines = ""

foreach ($resource in $data.Keys)
{
    $outputValue = "'$($data[$resource])'"
    
    foreach ($token in $allTokens)
    {
        $outputValue = "replace($outputValue, '{$token}', $token)"
    }

    $outputLines += "output $resource string = $outputValue`n"
}

# build the string for the whole template
$template = @"
$paramLines
$outputLines
"@

# write the template out to disk
$outputFileExists = Test-Path -Path $OutputFile

if ((!$outputFileExists) -or ($PSCmdlet.ShouldContinue("This will overwrite $OutputFile, continue?", "$OutputFile already exists")))
{
    Set-Content -Path $OutputFile -Value $template
    $OutputFile
}
