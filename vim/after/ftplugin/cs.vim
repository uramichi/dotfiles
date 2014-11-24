set cmdheight=2
set completeopt=longest,menuone,preview
set hidden
set noshowmatch
set splitbelow
set updatetime=500
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")
nnoremap <F2> :OmniSharpRename<cr>
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
nnoremap <leader>dc :OmniSharpDocumentation<cr>
nnoremap <leader>fi :OmniSharpFindImplementations<cr>
nnoremap <leader>fm :OmniSharpFindMembersInBuffer<cr>
nnoremap <leader>fs :OmniSharpFindSymbol<cr>
nnoremap <leader>ft :OmniSharpFindType<cr>
nnoremap <leader>fu :OmniSharpFindUsages<cr>
nnoremap <leader>fx :OmniSharpFixUsings<cr>
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
nnoremap <leader>tp :OmniSharpAddToProject<cr>
nnoremap <leader>tt :OmniSharpTypeLookup<cr>
nnoremap <leader>x  :OmniSharpFixIssue<cr>
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

set ff=dos
set et
set ts=4 sts=4 sw=4

if !exists('g:neocomplcache_force_omni_patterns')
	let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.cs = '[^.]\.\%(\u\{2,}\)\?'
