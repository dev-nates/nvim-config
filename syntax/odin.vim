syntax keyword odinFallthrough fallthrough

syntax match odinOperator /\(!=\|==\|=\|<\|>\|:=\|+\|-\|*\|\/\|?\|:\|\.\|,\)/
syntax match odinAdditionalStatements /\v(or_return|or_break|or_continue|Maybe)/
syntax match odinProcedureUnderscore /_/ containedin=odinProcedure,odinFuncDecl contained
syntax match odinUnderscore /_/


syntax match odinControlFlow /\v(\{|\}|\(|\)|\[|\])/
syntax match odinEnum /\<[A-Z0-9_]*\>/
syntax match odinFuncDecl /\v(<\w*>)\ze(\s*::.*proc)/ contains=ALLBUT,odinUnderscore
syntax match odinAsmDecl /\v(<\w*>)\ze(\s*::.*asm)/ contains=ALLBUT,odinUnderscore

syntax match commentTodo /\v(\@Todo|\@Fix|\@Error)/ containedin=odinBlockComment,odinLineComment
syntax match commentNote /@Note/ containedin=odinBlockComment,odinLineComment
syntax match commentWarning /@Warning/ containedin=odinBlockComment,odinLineComment
syntax match commentImportant /\v(\@Hack|\@Speed|\@Study|\@Info|\@Important|\@Debug|zzz|nocheckin)/ containedin=odinBlockComment,odinLineComment

highlight default link odinEnum Constant
highlight default link odinControlFlow Operator
highlight default link odinOperator Operator
highlight default link odinDeref Operator
highlight default link odinBlockComment DisabledCode
highlight default link odinAdditionalStatements Statement
highlight default link odinFuncDecl Function
highlight default link odinAsmDecl Function

highlight default link odinProcedureUnderscore FaintProcedureUnderscore
highlight default link odinUnderscore FaintUnderscore

"highlight default link odinIdentifier0 Identifier
"highlight default link odinIdentifier1 Identifier


"syntax match odinIdentifier0 /\v\zs(<[a-z0-9_]*>)(\.)@!\ze.*\:/
"syntax match odinIdentifier1 /\v\zs<[a-z0-9_]*>\ze.*\:.*\=/

"syntax match odinOperator /\v(\*|\+|\=|\?|&|\%|#|\!|\$|~|,|.|\:|^)/
"syntax match odinAda /\v<[A-Z]([A-Za-z0-9])*(_[A-Za-z0-9]*)*>/ contains=odinMaybe
"syntax match odinEnum /\<[A-Z0-9_]*\>/
"syntax match odinFunc /\v\zs([a-z0-9_]|\@[a-z0-9_])*\ze\(/ contains=odinType,odinKeyword,odinSpecial
"syntax match odinPackage /\v<\w*>(\s*\.\w*\()@=/
"syntax match odinPackageAda /\v<\w*>\ze(\s*\.[A-Z][a-z0-9]*(_[A-Za-z0-9]*)*)/
