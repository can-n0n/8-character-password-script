# Function to capitalize the first letter of a word
function Capitalize-FirstLetter {
    param (
        [string]$word
    )
    return $word.Substring(0,1).ToUpper() + $word.Substring(1)
}

# Function to generate a random symbol from a text file
function Get-RandomSymbol {
    param (
        [string]$filePath
    )
    $symbols = Get-Content $filePath
    return Get-Random -InputObject $symbols
}

# Function to generate a password
function Generate-Password {
    $dictionaryWord = Get-Content "C:\Users\Public\5letterwords.txt" | Get-Random
    $capitalizedWord = Capitalize-FirstLetter -word $dictionaryWord
    $numbers = -join (0..9 | Get-Random -Count 2)
    $symbol = Get-RandomSymbol -filePath "C:\Users\Public\symbols.txt"

    $password = $capitalizedWord + $numbers + $symbol
    return $password
}

# Function to generate a list of passwords
function Generate-PasswordList {
    param (
        [int]$numPasswords
    )
    $passwords = @()
    for ($i = 0; $i -lt $numPasswords; $i++) {
        $passwords += Generate-Password
    }
    return $passwords
}

# Main script
$numPasswords = Read-Host "Enter the number of passwords to generate"
$passwordList = Generate-PasswordList -numPasswords $numPasswords

for ($i = 0; $i -lt $passwordList.Length; $i++) {
    Write-Output "$($passwordList[$i])"
}
