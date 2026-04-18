
syntax keyword cAssert assert
syntax keyword cZeroStruct zero_struct
syntax keyword cReturn return
syntax keyword cNull null
syntax keyword cProc proc
syntax keyword cTypes u8 u16 u32 u64 s8 s16 s32 s64 b8 b16 b32 b64 f32 f64 cstring cstring16 cstring32 rawptr

" syntax region cString start=+"+ end=+"+
" syntax region cString start=+'+ end=+'+

highlight default link cNull Constant
highlight default link cReturn Keyword
highlight default link cProc Keyword
highlight default link cTypes Type
