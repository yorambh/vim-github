
function! Browse(url)
    exe 'silent !'.g:github_browser.' '.a:url.' &'
    redraw!
endfunction

function! GHCommits(proj,commit)
    call Browse('https://github.com/'.a:proj.'/commit/'.a:commit)
endfunction

function! GHProj(proj)
    call Browse('https://github.com/'.a:proj)
endfunction

function! GHLinux(commit)
    call GHCommits('torvalds/linux',a:commit)
endfunction

function! GHMapCommit(stroke,proj)
    "double exe here for the sake of @z variable
    exe 'nmap '.a:stroke.' "zyaw:exe"GHCommit '.a:proj.' ".@z""<CR>'
    if g:github_menu
	exe 'menu Plugin.Github.Project.'.a:proj.'.Commit "zyaw:exe"GHCommit '.a:proj.' ".@z.""<CR>'
    endif
endfunction

function! GHMapInfo(stroke,proj)
    exe 'nmap '.a:stroke.' :GHCProj '.a:proj.' <CR>'
    if g:github_menu
	exe 'menu Plugin.Github.Project.'.a:proj.'.Info :GHCProj '.a:proj.' <CR>'
    endif
endfunction

command! -nargs=* GHCommit call GHCommits(<f-args>)
command! -nargs=1 GHCLinux call GHLinux(<f-args>)
command! -nargs=1 GHCProj call GHProj(<f-args>)

if !exists('g:github_menu')
     let g:github_menu = 0
endif
if !exists('g:github_projects')
     let g:github_projects = {}
endif
if !exists('g:github_browser')
     let g:github_browser = 'xdg-open'
endif
for [proj,maps] in items(g:github_projects)
   call GHMapInfo(maps['info'],proj)
   call GHMapCommit(maps['commit'],proj)
endfor
