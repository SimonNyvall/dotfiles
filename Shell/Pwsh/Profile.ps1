function Find-File($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        $place_path = $_.directory
        Write-Host "${place_path}\${_}"
    }
}

if ($host.Name -eq 'ConsoleHost') {
    Remove-Item Alias:ls -Force
    function ls_git { & 'C:\Program Files\Git\usr\bin\ls' --color=auto -hF $args }
    Set-Alias -Name ls -Value ls_git -Option Private

    Set-Alias -Name vim -Value 'C:\Program Files\Git\usr\bin\vim.exe'
}

function dotcommit {
    git add .
    git commit -m "work in progress: ."
}

Remove-Item Alias:gc -Force
function gc {
    git checkout @args
}

function gs {
    git status
}

Remove-Item Alias:gl -Force
function gl {
    git log --graph --oneline --decorate
}

function gb {
    git branch
}

function gd {
    git diff
}

function gt {
    git commit -am "$($args -join ' ')"
}

function prompt {
    $cwd = (Get-Location).ProviderPath
    $home2 = [Environment]::GetFolderPath('UserProfile')

    if ($cwd -like "$home2*") {
        $cwd = $cwd.Replace($home2, '~')
    }

    $branch = $null
    $repoRoot = $null
    $isAhead = $false
    $isBehind = $false
    $hasUntrackedChanges = $false
    $hasStagedChanges = $false
    $hasGitChanges = $false

    if (Get-Command git -ErrorAction SilentlyContinue) {
        try {
            $repoRoot = git rev-parse --show-top-level 2>$null
            if ($repoRoot) {
                $branch = git rev-parse --abbrev-ref HEAD 2>$null
                $status = git status -sb 2>$null

                if ($status) {
                    foreach ($line in $status) {
                        if ($line -match 'ahead')  { $isAhead = $true }
                        if ($line -match 'behind') { $isBehind = $true }
                        if ($line -match '^\?\?')  { $hasUntrackedChanges = $true }
                        if ($line -match '^[AMRCD]') { $hasStagedChanges = $true }
                        if ($line -match '^\s*M')   { $hasGitChanges = $true }
                    }
                }
            }
        }
        catch {
            # Not in a git repo
        }
    }

    Write-Host $cwd -NoNewline -ForegroundColor DarkCyan
    if ($branch) {
        Write-Host " git:(" -NoNewline -ForegroundColor Blue
        Write-Host $branch -NoNewline -ForegroundColor DarkYellow
        Write-Host ") " -NoNewline -ForegroundColor Blue

        if ($isAhead -or $isBehind -or $hasUntrackedChanges -or $hasStagedChanges -or $hasGitChanges) {
            Write-Host '[' -NoNewline

            if ($isAhead)          { Write-Host ([char]0x2191) -NoNewline -ForegroundColor Red }
            if ($isBehind)         { Write-Host ([char]0x2193) -NoNewline -ForegroundColor Red }
            if ($hasStagedChanges) { Write-Host '+' -NoNewline -ForegroundColor Red }
            if ($hasUntrackedChanges) { Write-Host '?' -NoNewline -ForegroundColor Red }
            if ($hasGitChanges)    { Write-Host '!' -NoNewline -ForegroundColor Red }

            Write-Host '] ' -NoNewline
        }
    }
    return "> "
}