$input = Read-Host 'Enter author names (comma separated, e.g. MahammadA,Mahammad)'

$authors = $input -split ',' | ForEach-Object 
{ 
    $_.Trim() 
}

git ls-remote origin "refs/heads/*" | ForEach-Object 
{
    try 
    {
        $parts = $_ -split '\s+'
        $hash = $parts[0]
        $ref = $parts[1]

        $name = git show -s --format='%an' $hash
        
        if ($authors -contains $name) 
        {
            "hash: $hash  ref: $ref"
        }
    } 
    catch 
    {
        Write-Host "Error on commit hash: $hash"
    }
}
