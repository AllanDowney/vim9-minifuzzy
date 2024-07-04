vim9script

export def GetMRU(limit: number): list<string>
    final recently_used: list<string> = []
    var found = 0
    for path in v:oldfiles
        if found >= limit
            break
        endif
        if match(path, "^/usr/share") < 0 && filereadable(expand(path))
            add(recently_used, path)
            found += 1
        endif 
    endfor
    return recently_used
enddef

# Returns just the cwd last directory name
# i.e. a/b/c => c
export def GetCurrentDirectory(): string
    return getcwd()[strridx(getcwd(), '/') + 1 : ]
enddef

export def BuildFindCommand(root: string): string
    var dirsfiles: string = ''
    var droot: string = ''

    if &wildignore != ''
        const ignores = &wildignore->split(",")
        final ignore_dirsfiles = ignores->copy()
        ignore_dirsfiles->map((_, val) => $"-E '{val}'")
        dirsfiles = ignore_dirsfiles->join(' ')
    endif

    if root == '.'
        return $'fd -d4 -tf {dirsfiles}'
    endif

    if root == '1'
        droot = getcwd()->fnamemodify(':~:h')
    elseif root == '2'
        droot = getcwd()->fnamemodify(':~:h:h')
    elseif root == '3'
        droot = getcwd()->fnamemodify(':~:h:h:h')
    elseif root ==? 'pwd'
        droot = getenv('PWD')->fnamemodify(':~')
    else
        droot = root
    endif
    # echom dirsfiles droot

    return $'fd -d4 -tf {dirsfiles} . {droot}'
enddef
