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
    if &wildignore == ''
        var droot = ''
        if root != '.'
            droot = '. ' .. root
        endif
        return $'fd -d4 -tf {droot}'
    else
		const ignores = &wildignore->split(",")
		final ignore_dirsfiles = ignores->copy()
		ignore_dirsfiles->map((_, val) => $'-E {val}')
		const dirsfiles = ignore_dirsfiles->join()
		# echom dirsfiles
		return $'fd -d4 -tf {dirsfiles} {root}'
    endif
enddef
