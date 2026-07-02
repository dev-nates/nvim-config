syntax keyword odinAssert assert
syntax keyword odinTypes byte
syntax keyword odinFallthrough fallthrough

syntax match odinSpecial /\v<(expand_values|min|max|raw_data|len|new|free)>/ contained
syntax match odinAda /\v[A-Z][a-z0-9]*(_[A-Za-z0-9]*)*/ contains=odinMaybe
syntax match odinEnum /\<[A-Z0-9_]*\>/
syntax match odinFunc /\v\zs([a-z0-9_]|\@[a-z0-9_])*\ze\(/ contains=odinType,odinKeyword,odinSpecial
syntax match odinFuncDecl /\v(<\w*>)\ze(\s*::.*proc)/
syntax match odinPackage /\v<\w*>(\s*\.\w*\()@=/
syntax match odinPackageAda /\v<\w*>\ze(\s*\.[A-Z][a-z0-9]*(_[A-Za-z0-9]*)*)/
syntax match odinArena /\v<Arena>/
syntax match odinScratch /\v<scratch\w*>/
syntax match odinExpandOperator /\v(\*\*)/
syntax match odinMaybe /\v<Maybe>/ contained

syntax match commentTodo /\v(\@Todo|\@Fix|\@Error)/ containedin=odinBlockComment,odinLineComment
syntax match commentNote /@Note/ containedin=odinBlockComment,odinLineComment
syntax match commentWarning /@Warning/ containedin=odinBlockComment,odinLineComment
syntax match commentImportant /\v(\@Study|\@Info|\@Important|zzz|nocheckin)/ containedin=odinBlockComment,odinLineComment

highlight default link odinTypes Type
highlight default link odinFallthrough Keyword
highlight odinAda guifg=#78834B gui=BOLD
highlight odinSlice guifg=#78834B gui=BOLD
highlight default link odinEnum Constant
highlight default link odinFuncDecl Function
highlight odinPackage guifg=#8c8677
highlight odinPackageAda guifg=#8c8677
highlight odinFunc guifg=#78834B
highlight odinAssert guifg=#824a76
highlight odinArena guifg=#4a7682 gui=BOLD
highlight odinScratch guifg=#4a7682
highlight default link odinExpandOperator Operator
highlight default link odinMaybe Operator

highlight default link odinSpecial Operator
highlight odinPtr guifg=#8c8677 gui=BOLD
highlight commentNote guifg=#487cd6
highlight commentWarning guifg=#fcb24b
highlight commentTodo guifg=#cc4576 
highlight commentImportant guifg=#ffffff


