" On your vimrc:
"   let g:drushprg="drush"
"
" Todo: Should probably check to see if drush can bootstrap

" Location of the drush utility
if !exists("g:drush")
	let g:drush="drush"
endif

function! s:Drush(cmd, args)
    redraw
    echo "Searching ..."

    " If no pattern is provided, search for the word under the cursor
    if empty(a:args)
        let l:grepargs = expand("<cword>")
    else
        let l:grepargs = a:args
    end

    let g:drushformat="%f:%l:%c:%m"

    let grepprg_bak=&grepprg
    let grepformat_bak=&grepformat
    try
        let &grepprg=g:drush . " " . a:cmd
        let &grepformat=g:drushformat
        silent execute "grep " . l:grepargs
    finally
        let &grepprg=grepprg_bak
        let &grepformat=grepformat_bak
    endtry

    if a:cmd =~# '^l'
        botright lopen
    else
        botright copen
    endif

    exec "nnoremap <silent> <buffer> q :ccl<CR>"
    exec "nnoremap <silent> <buffer> t <C-W><CR><C-W>T"
    exec "nnoremap <silent> <buffer> T <C-W><CR><C-W>TgT<C-W><C-W>"
    exec "nnoremap <silent> <buffer> o <CR>"
    exec "nnoremap <silent> <buffer> go <CR><C-W><C-W>"
    exec "nnoremap <silent> <buffer> v <C-W><C-W><C-W>v<C-L><C-W><C-J><CR>"
    exec "nnoremap <silent> <buffer> gv <C-W><C-W><C-W>v<C-L><C-W><C-J><CR><C-W><C-J>"

    redraw!
endfunction

" Pulls in Drupal variables (from Drush) and outputs variable_set() calls for
" each variable.
function! s:DrushVariableGet(args)
  exec "normal o"
  exec "r !drush variable-get --pipe " . a:args . " | sed 's/$variables\\[\\(.*\\)\\] = /variable_set(\\1, /' | sed 's/;$/);/'"
  exec "normal ={"
endfunction

command! -bang -nargs=* -complete=file DrushHook call s:Drush('vim-hook', <q-args>)
command! -bang -nargs=* -complete=file DrushVar call s:DrushVariableGet(<q-args>)
