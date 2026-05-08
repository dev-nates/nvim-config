
syntax match mdTodo /\v(\@Todo|\@Fix)/
syntax match mdNote /\v(\@Note)/
syntax match mdWarning /@Warning/
syntax match mdImportant /\v(\@Important|zzz|nocheckin)/

highlight mdNote guifg=#487cd6
highlight mdWarning guifg=#fcb24b
highlight mdTodo guifg=#cc4576 
highlight mdImportant guifg=#ffffff
