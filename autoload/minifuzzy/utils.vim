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
    return recently_used->reduce((acc, val) => {
        acc->add(fnamemodify(val, ':~:.'))
        return acc
        }, [])
enddef

# Returns just the cwd last directory name
# i.e. a/b/c => c
export def GetCurrentDirectory(): string
    return getcwd()[strridx(getcwd(), '/') + 1 : ]
enddef

export def BuildFindCommand(root: string): string
    var dirsfiles: string = ''
	var ignore_dirs = ['.git']
    var droot: string = ''

    if &wildignore != ''
        const ignores = &wildignore->split(",")
		ignore_dirs->extend(ignores)

    endif

	var exdd = g:->get('minifuzzy_find_exclude', [])
	if len(exdd) > 0
		ignore_dirs->extend(exdd)
	endif

	dirsfiles = ignore_dirs
		->flattennew()
		->mapnew((_, val) => $"-E {val}")
		->join(' ')
	dirsfiles = $' {dirsfiles} '

    if root == '1'
        execute "lcd ../"
        droot = '.'
    elseif root == '2'
        execute "lcd ../../"
        droot = '.'
    elseif !isdirectory(expand(root))
        droot = getenv('PWD')->fnamemodify(':~')
    else
        droot = root
    endif

	if droot != '.'
		droot = $' . {droot}'
	else
		droot = ''
	endif

	var hidef = g:->get('minifuzzy_find_hidden', false) ? '-H' : ''
	var fddl = g:->get('minifuzzy_find_level', '-d4')

	return $'fd {hidef} {fddl} -tf{dirsfiles}{droot}'
enddef
