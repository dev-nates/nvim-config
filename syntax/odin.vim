syntax keyword odinTypes byte
syntax keyword odinFallthrough fallthrough

syntax match odinOperator /\(!=\|==\|=\|:=\|*\|?\)/

"syntax match odinIdentifier0 /\v\zs(<[a-z0-9_]*>)(\.)@!\ze.*\:/
"syntax match odinIdentifier1 /\v\zs<[a-z0-9_]*>\ze.*\:.*\=/

syntax match odinControlFlow /\v(\{|\}|\(|\)|\[|\])/
syntax match odinEnum /\<[A-Z0-9_]*\>/
"syntax match odinOperator /\v(\*|\+|\=|\?|&|\%|#|\!|\$|~|,|.|\:|^)/

"syntax match odinAda /\v<[A-Z]([A-Za-z0-9])*(_[A-Za-z0-9]*)*>/ contains=odinMaybe
"syntax match odinEnum /\<[A-Z0-9_]*\>/
"syntax match odinFunc /\v\zs([a-z0-9_]|\@[a-z0-9_])*\ze\(/ contains=odinType,odinKeyword,odinSpecial
"syntax match odinFuncDecl /\v(<\w*>)\ze(\s*::.*proc)/
"syntax match odinPackage /\v<\w*>(\s*\.\w*\()@=/
"syntax match odinPackageAda /\v<\w*>\ze(\s*\.[A-Z][a-z0-9]*(_[A-Za-z0-9]*)*)/

syntax match commentTodo /\v(\@Todo|\@Fix|\@Error)/ containedin=odinBlockComment,odinLineComment
syntax match commentNote /@Note/ containedin=odinBlockComment,odinLineComment
syntax match commentWarning /@Warning/ containedin=odinBlockComment,odinLineComment
syntax match commentImportant /\v(\@Study|\@Info|\@Important|\@Debug|zzz|nocheckin)/ containedin=odinBlockComment,odinLineComment

highlight default link odinEnum Constant
highlight default link odinControlFlow Operator
highlight default link odinOperator Operator
highlight default link odinDeref Operator
"highlight default link odinIdentifier0 Identifier
"highlight default link odinIdentifier1 Identifier
highlight default link odinBlockComment DisabledCode
