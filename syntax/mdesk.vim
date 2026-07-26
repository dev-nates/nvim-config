
syntax match mdeskNode /\v\w+/

syntax region mdeskString start=+"+ skip=+\\.+ end=+"+
syntax region mdeskString start=+'+ skip=+\\.+ end=+'+
syntax region mdeskString start=+`+ skip=+\\.+ end=+`+
highlight default link mdeskString String

syntax match mdeskTag /\v\@\w+/
highlight default link mdeskTag Function

syntax match mdeskConstant /\v<([A-Z0-9_]*|true|false|nil|null|nullptr)>/
highlight default link mdeskConstant Constant


syntax match commentTodo /\v(\@Todo|\@Fix|\@Error)/ contained
syntax match commentNote /@Note/ contained
syntax match commentWarning /@Warning/ contained
syntax match commentImportant /\v(\@Hack|\@Info|\@Important|zzz|nocheckin)/ contained

syntax match mdeskLineComment /\/\/.*/ contains=commentTodo,commentWarning,commentNote,commentImportant
syntax region mdeskBlockComment start=/\/\*/ end=/\*\// contains=commentTodo,commentWarning,commentNote,commentImportant
syntax region mdeskProcAnnotation start=/<\*/ end=/\*>/

highlight default link mdeskBlockComment Comment
highlight default link mdeskLineComment Comment

