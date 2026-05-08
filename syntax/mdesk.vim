
syntax match mdeskNode /\v\w+/

syntax region mdeskString start=+"+ skip=+\\.+ end=+"+
syntax region mdeskString start=+'+ skip=+\\.+ end=+'+
highlight default link mdeskString String

syntax match commentTodo /\v(\@Todo|\@Fix|\@Error)/ contained
syntax match commentNote /@Note/ contained
syntax match commentWarning /@Warning/ contained
syntax match commentImportant /\v(\@Info|\@Important|zzz|nocheckin)/ contained
syntax match mdeskLineComment /\/\/.*/ contains=commentTodo,commentWarning,commentNote,commentImportant
syntax region mdeskBlockComment start=/\/\*/ end=/\*\// contains=commentTodo,commentWarning,commentNote,commentImportant
syntax region mdeskProcAnnotation start=/<\*/ end=/\*>/

highlight default link mdeskLineComment Comment
highlight default link mdeskBlockComment Comment
highlight commentNote guifg=#487cd6
highlight commentWarning guifg=#fcb24b
highlight commentTodo guifg=#cc4576 
highlight commentImportant guifg=#ffffff
