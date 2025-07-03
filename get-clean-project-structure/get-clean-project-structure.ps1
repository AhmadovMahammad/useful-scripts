$ProjectPath = Get-Location
$OutputFile = "project-structure.txt"

$ExcludedDirs = @(
    "bin", "obj", ".vs", ".vscode", "node_modules", "packages", 
    ".git", ".svn", ".hg", "target", "build", "dist", "out",
    ".idea", "*.egg-info", "__pycache__", ".pytest_cache",
    "vendor", "logs", "temp", "tmp", ".nuget"
)

$ExcludedFiles = @(
    "*.exe", "*.dll", "*.pdb", "*.cache", "*.log", "*.tmp",
    "*.user", "*.suo", "*.sln.docstates", "*.userprefs",
    "*.pidb", "*.userprefs", "*.ide", "*.class", "*.o",
    "*.so", "*.dylib", "*.a", "*.lib", "*.pyc", "*.pyo",
    ".DS_Store", "Thumbs.db", "desktop.ini"
)

function Test-ShouldExcludeDirectory
{
    param
	(
		[string] $DirName
    )
    
    foreach ($exclude in $ExcludedDirs) 
	{
        if ($DirName -like $exclude) 
		{
            return $true
        }
    }
	
    return $false
}

function Test-ShouldExcludeFile
{
    param
	(
		[string] $FileName
	)
    
    foreach ($exclude in $ExcludedFiles) 
	{
        if ($FileName -like $exclude) 
		{
            return $true
        }
    }
	
    return $false
}

function Get-ProjectStructure 
{
	Param
	(
		[string] $Path,
		[int] $Depth = 0
	)
	
    $indent = "  " * $Depth
    $result = @()
    
    try 
	{
        $items = Get-ChildItem -Path $Path | Sort-Object Name
        
        foreach ($item in $items) 
		{
			# This is the PowerShell way to check if the item is a folder.
			# PSIsContainer is a property set to $true if the item is a directory, not a file.
            
            if ($item.PSIsContainer)
            {
                if(-not (Test-ShouldExcludeDirectory $item.Name))
                {
                    $result += "$indent$($item.Name)/"
                    $result += Get-ProjectStructure -Path $item.FullName -Depth ($Depth + 1)
                }
                else
                {
                    if (-not (Test-ShouldExcludeFile $item.Name)) 
                    {
                        $result += "$indent$($item.Name)"
                    }
                }
            }
        }
    }
    catch { }
    
    return $result
}

$output = @()

$projectName = Split-Path $ProjectPath -Leaf
$output += "PROJECT: $projectName"
$output += "Date: $(Get-Date)"
$output += ""

$output += Get-ProjectStructure -Path $ProjectPath

$output | Out-File -FilePath $OutputFile -Encoding UTF8