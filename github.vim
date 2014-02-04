
fu! Browse(url)
    exe 'silent !xdg-open '.a:url
endfunction

fu! GHCommits(proj,commit)
    call Browse('https://github.com/'.a:proj.'/commit/'.a:commit)
endfunction

fu! GHProj(proj)
    call Browse('https://github.com/'.a:proj)
endfunction

fu! GHLinux(commit)
    call GHCommits('torvalds/linux',a:commit)
endfunction

function! GHMapCommit(stroke,proj)
    "double exe here for the sake of @z variable
    exe 'nmap '.a:stroke.' "zyaw:exe"GHCommit '.a:proj.' ".@z""<CR>'
    exe 'menu Plugin.Github.Project.'.a:proj.'.Commit "zyaw:exe"GHCommit '.a:proj.' ".@z.""<CR>'
endfunction

function! GHMapInfo(stroke,proj)
    exe 'nmap '.a:stroke.' :GHCProj '.a:proj.' <CR>'
    exe 'menu Plugin.Github.Project.'.a:proj.'.Info :GHCProj '.a:proj.' <CR>'
endfunction

command -nargs=* GHCommit call GHCommits(<f-args>)
command -nargs=1 GHCLinux call GHLinux(<f-args>)
command -nargs=1 GHCProj call GHProj(<f-args>)

for [proj,maps] in items(g:github_projects)
   call GHMapInfo(maps['info'],proj)
   call GHMapCommit(maps['commit'],proj)
endfor
