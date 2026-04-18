
syntax keyword c3Null null
syntax keyword c3Assert assert
syntax keyword c3Keyword module import fn struct constdef union enum macro inline

syntax keyword c3Types String void char short ushort int uint long ulong float double
syntax keyword c3Boolean bool true false

syntax keyword c3ControlFlow if for foreach else switch do case break continue defer
syntax keyword c3Return return

syntax match c3Ada /\v[A-Z][a-z0-9]*(_[A-Z][a-z0-9]*)*/
syntax match c3Func /\v(\w|\@\w)*\ze\s*\(/
syntax match c3Namespace /\v\w*\ze\s*::\s*/
syntax match c3Enum /\<[A-Z0-9_]*\>/
syntax match c3Operators /\v([+\-*/%&?:]|len)/

syntax match c3Attributes /\v(\@private|\@local|\@operator|\@builtin)/

syntax region c3String start=+"+ skip=+\\.+ end=+"+
syntax region c3String start=+'+ skip=+\\.+ end=+'+

syntax match c3LineComment /\/\/.*/
syntax region c3BlockComment start=/\/\*/ end=/\*\//
syntax region c3ProcAnnotation start=/<\*/ end=/\*>/
syntax keyword c3Todo TODO FIXME NOTE containedin=c3LineComment,c3BlockComment

highlight default link c3Special Special
highlight default link c3Keyword Keyword
highlight default link c3String String
highlight default link c3Ada Type
highlight default link c3Boolean Boolean
highlight default link c3Operators Operator

highlight default link c3ControlFlow Conditional
highlight default link c3Attributes Define

highlight default link c3Null Constant
highlight default link c3Enum Constant
highlight default link c3LineComment Comment
highlight default link c3BlockComment Comment
highlight default link c3ProcAnnotation Comment

highlight default link c3Todo Todo
highlight c3Func guifg=#40B388
highlight c3Namespace guifg=#8c8677
highlight c3Return guifg=#dfddf4 gui=BOLD
highlight c3Ada guifg=#b0a78b gui=BOLD
highlight c3Types guifg=#b0a78b gui=BOLD
