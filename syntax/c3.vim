
syntax keyword c3Null null
syntax keyword c3Assert assert
syntax keyword c3Keyword fn struct const constdef union enum macro inline bitstruct alias typedef extern tlocal
syntax keyword c3Import import module nextgroup=c3ModuleName skipwhite

syntax keyword c3Types void any String char short ushort int uint long ulong float double isz usz iptr uptr
syntax keyword c3Boolean bool true false

syntax keyword c3ControlFlow if for foreach foreach_r else switch do case break continue defer
syntax keyword c3Return return

syntax match c3Foreach /\v(\@foreach_idx|\@foreach_range)/ contained
syntax match c3Ada /\v[A-Z][a-z0-9]*(_[A-Za-z0-9]*)*/
syntax match c3Func /\v([a-z0-9_]|\@[a-z0-9_])*\ze(\(|\{)/ contains=c3Foreach
syntax match c3Namespace /\v\w*\ze\s*::\s*/
syntax match c3Enum /\<[A-Z0-9_]*\>/
" syntax match c3Num /\v<(0x|0b|0o)?[0-9abcdefABCDEF]*(\.f|u|l|ul|ll|ull)?>/
" syntax match c3Num /\v<(?(0x|0b|0o)[0-9abcdefABCDEF]|[0-9])(\.f|u|l|ul|ll|ull)?>/
" syntax match c3Num /\v<(0x|0b|0o)(\@=(1)[0-9]*|[0-9abcdefABCDEF]*)(\.f|u|l|ul|ll|ull)?>/
syntax match c3Num /\v<(\@=(0x|0b|0o)[0-9a-fA-F]*|[0-9]*)(f|\.f|u|l|ul|ll|ull)?>/
syntax match c3Operators /\v([+\-*/%&?:]|<len>|<min>|<max>|<sizeof>|\.\.\.|\=\>)/
syntax match c3ModuleName /\v\w+(::\w+)*\ze\s*(;)?/ contained
syntax match c3Dollar /\v\$[a-zA-z0-9]*/

syntax match c3Attributes /\v(\@private|\@local|\@operator|\@builtin|\@maydiscard|\@format)/

syntax region c3String start=+"+ skip=+\\.+ end=+"+
syntax region c3String start=+'+ skip=+\\.+ end=+'+

syntax match commentTodo /\v(\@Todo|\@Fix|\@Error)/ contained
syntax match commentNote /@Note/ contained
syntax match commentWarning /@Warning/ contained
syntax match commentImportant /\v(\@Info|\@Important|zzz|nocheckin)/ contained
syntax match c3LineComment /\/\/.*/ contains=commentTodo,commentWarning,commentNote,commentImportant
syntax region c3BlockComment start=/\/\*/ end=/\*\// contains=commentTodo,commentWarning,commentNote,commentImportant
syntax region c3ProcAnnotation start=/<\*/ end=/\*>/

highlight default link c3Special Special
highlight default link c3Foreach Keyword
highlight default link c3Keyword Keyword
highlight default link c3Import Keyword
highlight default link c3String String
highlight default link c3Ada Type
highlight default link c3Boolean Boolean
highlight default link c3Operators Operator

highlight default link c3ControlFlow Conditional
highlight default link c3Attributes Define

highlight default link c3Null Constant
highlight default link c3Enum Constant
highlight default link c3Num Constant
highlight default link c3ProcAnnotation Operator
highlight default link c3Dollar PreCondit

highlight c3Func guifg=#40B388
highlight c3Namespace guifg=#8c8677
highlight c3ModuleName guifg=#8c8677
highlight c3Return guifg=#dfddf4 gui=BOLD
highlight c3Ada guifg=#b0a78b gui=BOLD
highlight c3Types guifg=#b0a78b gui=BOLD
highlight c3Assert guifg=#b53d69

highlight default link c3LineComment Comment
highlight default link c3BlockComment Comment
highlight commentNote guifg=#487cd6
highlight commentWarning guifg=#fcb24b
highlight commentTodo guifg=#cc4576 
highlight commentImportant guifg=#ffffff
