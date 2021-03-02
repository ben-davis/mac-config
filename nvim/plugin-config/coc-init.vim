function! InstallCocExtensionsFun()
  let extensions = ["yank", "snippets", "prettier", "post", "marketplace", "lists", "jest", "git", "explorer", "eslint", "actions", "tsserver", "rust-analyzer", "python", "markdownlint", "json", "html", "css"]

  for extension in extensions
    execute 'CocInstall coc-' . extension
  endfor
endfunction

command! InstallCocExtensions :call InstallCocExtensionsFun()

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
 
" Use <s-space> to trigger completion.
inoremap <silent><expr> <s-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList

" Adds FZF commands as coc-fzf
call coc_fzf#common#add_list_source('files', 'display files', 'FzfPreviewFromResources project_mru project')
call coc_fzf#common#add_list_source('grep', 'grep files using ripgrep', 'Rg')
call coc_fzf#common#add_list_source('lines', 'search lines in current buffer', 'FzfPreviewLines --add-fzf-arg=--no-preview --add-fzf-arg=--no-sort')
call coc_fzf#common#add_list_source('history', 'search commit history of current file', 'FzfPreviewGitCurrentLogs')
call coc_fzf#common#add_list_source('mru', 'search recent files', 'FzfPreviewFromResources buffer mru')
call coc_fzf#common#add_list_source('git', 'show git actions', 'FzfPreviewGitActions')
call coc_fzf#common#add_list_source('buffers', 'show buffers', 'FzfPreviewAllBuffers')
call coc_fzf#common#add_list_source('quickfix', 'show quickfix', 'FzfPreviewQuickFix')

" Show all diagnostics
nnoremap <silent> <space>d  :<C-u>CocCommand fzf-preview.CocCurrentDiagnostics<cr>
nnoremap <silent> <space>D  :<C-u>CocFzfList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocFzfList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocFzfList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocFzfList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocFzfList symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>r  :<C-u>CocFzfListResume<CR>

" ======= Custom Ben Config ==============

" Make ctrl j and k go up and down in suggestion list
inoremap <expr> <C-j>     pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k>       pumvisible() ? "\<C-p>" : "\<C-k>"

nnoremap <silent> <space>p  :<C-u>CocFzfList files<CR>
nnoremap <silent> <space>f  :<C-u>CocFzfList grep<CR>
nnoremap <silent> <space>g  :<C-u>CocFzfList git<CR>
nnoremap <silent> <space>m  :<C-u>CocFzfList mru<CR>
nnoremap <silent> <space>y  :<C-u>CocFzfList yank<cr>
nnoremap <silent> <space>l  :<C-u>CocFzfList<CR>
nnoremap <silent> <space>b  :<C-u>CocFzfList buffers<CR>
nnoremap <silent> <space>/  :<C-u>CocFzfList lines<CR>
nnoremap <silent> <space>h  :<C-u>CocFzfList history<CR>
nnoremap <silent> <space>q  :<C-u>CocFzfList quickfix<CR>


" VSCode like multiple cursors
nmap <expr> <silent> <C-d> <SID>select_current_word()
function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'cocConfig': {
\      'root-uri': '~/.config/coc',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   },
\   'buffer': {
\     'sources': [{'name': 'buffer', 'expand': v:true}]
\   },
\ }

nmap <silent> <leader>d :CocCommand explorer --preset floating<CR>

" Auto sort python on save
augroup autosave
  autocmd!
  autocmd BufWritePre *.py :CocCommand python.sortImports
augroup END
