syntax keyword odinAssert assert
syntax keyword odinTypes byte

syntax match odinSpecial /\v<(expand_values|min|max|raw_data|len|new|free)>/ contained
syntax match odinAda /\v[A-Z][a-z0-9]*(_[A-Za-z0-9]*)*/
syntax match odinEnum /\<[A-Z0-9_]*\>/
syntax match odinFunc /\v\zs([a-z0-9_]|\@[a-z0-9_])*\ze\(/ contains=odinPush,odinType,odinKeyword,odinSpecial
syntax match odinFuncDecl /\v(<\w*>)\ze(\s*::.*proc)/ contains=odinPush
syntax match odinPackage /\v<\w*>(\s*\.\w*\()@=/
syntax match odinPackageAda /\v<\w*>\ze(\s*\.[A-Z][a-z0-9]*(_[A-Za-z0-9]*)*)/
syntax match odinPush /\v<push\w*>/ contained containedin=odinProcedure
syntax match odinArena /\v<Arena>/
syntax match odinScratch /\v<scratch\w*>/
syntax match odinExpandOperator /\v(**)/

syntax match commentTodo /\v(\@Todo|\@Fix|\@Error)/ containedin=odinBlockComment,odinLineComment
syntax match commentNote /@Note/ containedin=odinBlockComment,odinLineComment
syntax match commentWarning /@Warning/ containedin=odinBlockComment,odinLineComment
syntax match commentImportant /\v(\@Study|\@Info|\@Important|zzz|nocheckin)/ containedin=odinBlockComment,odinLineComment

highlight default link odinTypes Type
highlight odinAda guifg=#b0a78b gui=BOLD
highlight odinSlice guifg=#b0a78b gui=BOLD
highlight default link odinEnum Constant
highlight default link odinFuncDecl Function
highlight odinPackage guifg=#8c8677
highlight odinPackageAda guifg=#8c8677
highlight odinFunc guifg=#40B388
highlight odinAssert guifg=#b53d69
highlight odinPush guifg=#487cd6
highlight odinArena guifg=#487cd6 gui=BOLD
highlight odinScratch guifg=#487cd6
highlight default link odinExpandOperator Operator

highlight default link odinSpecial Operator
highlight odinPtr guifg=#8c8677 gui=BOLD
highlight commentNote guifg=#487cd6
highlight commentWarning guifg=#fcb24b
highlight commentTodo guifg=#cc4576 
highlight commentImportant guifg=#ffffff
