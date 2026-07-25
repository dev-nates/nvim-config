
syntax match cppTypes /\v<(u8|u16|u32|u64|s8|s16|s32|s64|i8|i16|i32|i64|f32|f64)>/

syntax match cppFunc /\v\zs([A-Za-z0-9_]|\@[A-Za-z0-9_])*\ze\(/
syntax match cppAda /\v<[A-Z]([A-Za-z0-9])*(_[A-Za-z0-9]*)*>/
syntax match cppEnum /\<[A-Z0-9_]*\>/
