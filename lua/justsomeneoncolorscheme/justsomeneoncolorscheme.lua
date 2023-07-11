local lush = require('lush')
local hsl = lush.hsl
local hsluv = lush.hsluv

local bg = "None"
local opaque = hsluv(0, 0, 0)
local fg = hsluv(0, 0, 100)
local c0 = hsluv(190, 100, 90)
local c1 = hsluv(317, 100, 58)
local c2 = hsluv(143, 100, 87)
local red = hsluv(0, 100, 55)
local yellow = hsluv(88, 100, 81)
local cmid = fg.da(25)
local clow = cmid.da(50)
local cverylow = clow.da(30)

---@diagnostic disable: undefined-global
local theme = lush(function()
  return {
    base { bg = bg, fg = fg },
    undef { bg = red, fg = opaque },
    error { bg = opaque, fg = red },
    mid { bg = bg, fg = cmid },
    low { bg = bg, fg = clow },
    verylow { bg = bg, fg = cverylow },
    b0ld { base, gui = "bold" },

    Normal          { base },
    Cursor          { bg = opaque.mix(fg, 30) }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorLine      { bg = opaque.mix(fg, 4) }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorColumn    { CursorLine },
    Visual          { bg = opaque.mix(fg, 15) },
    Whitespace      { verylow, gui = "bold" },
    Comment         { low, gui="bold" },
    LineNr          { bg = bg, fg = cverylow, gui = "bold" },
    CursorLineNr    { LineNr, fg = clow },
    QuickFixLine    { CursorLine },
    Search          { bg = c2, fg = opaque.mix(fg, 20) },
    IncSearch       { bg = Search.bg.rotate(-20), fg = Search.fg.li(10) },

    NormalFloat     { base, bg = opaque.mix(fg, 3), fg = c0 }, -- Normal text in floating windows.
    DiffAdd         { base, fg = c2 }, -- diff mode: Added line |diff.txt|
    DiffChange      { base, fg = c1}, -- diff mode: Changed line |diff.txt|
    DiffDelete      { base, fg = red }, -- diff mode: Deleted line |diff.txt|
    ErrorMsg        { error }, -- error messages on the command line
    SignColumn      { mid }, -- 'foldcolumn'
    MatchParen      { base, bg = c1, fg = c0, gui = "bold" }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    Pmenu           { base, fg = c0 }, -- Popup menu: normal item.
    PmenuSel        { base, fg = c1 }, -- Popup menu: selected item.
    PmenuSbar       { bg = c0, fg = opaque }, -- Popup menu: scrollbar.
    PmenuThumb      { bg = opaque, fg = c0 }, -- Popup menu: Thumb of the scrollbar.

    Constant        { base, fg = c1.de(10) }, -- (preferred) any constant
    Identifier      { base, fg = c0 }, -- (preferred) any variable name
    Statement       { base, fg = c1, gui = "bold" }, -- (preferred) any statement
    Operator        { base, fg = c1.mix(fg, 70) }, -- "sizeof", "+", "*", etc.
    PreProc         { base, fg = c1.de(30) }, -- (preferred) generic Preprocessor
    Type            { base, fg = c0, gui = "bold" }, -- (preferred) int, long, char, etc.
    Special         { mid }, -- (preferred) any special symbol

    Todo            { bg = opaque.mix(fg, 5), fg = c1, gui = "bold" }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    DiagnosticVirtualTextError                 { fg = cverylow.saturation(red.s).hue(red.h) },
    DiagnosticVirtualTextWarn                 { fg = clow.saturation(yellow.s).hue(yellow.h) },
    DiagnosticVirtualTextInfo                 { fg = cverylow },
    DiagnosticVirtualTextHint                 { fg = cverylow },
    DiagnosticSignError                 { fg = cverylow.saturation(red.s).hue(red.h) },
    DiagnosticSignWarn                 { fg = clow.saturation(yellow.s).hue(yellow.h) },
    DiagnosticSignInfo                 { fg = cverylow },
    DiagnosticSignHint                 { fg = cverylow },

    NotifyBackground { bg = opaque }, -- Some box appeared telling me to define this

    -- NeoTreeNormal               { low },
    -- NeoTreeNormalNC             { low },
    -- NeoTreeSignColumn           { low },
    -- NeoTreeStatusLine           { low },
    -- NeoTreeStatusLineNC         { low },
    -- NeoTreeVertSplit            { low },
    -- NeoTreeWinSeparator         { low },
    -- NeoTreeEndOfBuffer          { low },
    -- NeoTreeFloatBorder          { low },
    -- NeoTreeFloatNormal          { low },
    -- NeoTreeFloatTitle           { low },
    -- NeoTreeTitleBar             { low },
    -- NeoTreeBufferNumber         { low },
    -- NeoTreeDimText              { low },
    -- NeoTreeMessage              { low },
    -- NeoTreeFadeText1            { low },
    -- NeoTreeFadeText2            { low },
    NeoTreeDotfile              { b0ld, fg = clow },
    -- NeoTreeHiddenByName         { low },
    -- NeoTreeCursorLine           { low },
    NeoTreeDirectoryName        { b0ld, fg = c0 },
    NeoTreeDirectoryIcon        { b0ld, fg = c0 },
    NeoTreeFileIcon             { b0ld, fg = c0 },
    NeoTreeFileName             { b0ld },
    -- NeoTreeFileNameOpened       { low },
    -- NeoTreeSymbolicLinkTarget   { low },
    -- NeoTreeFilterTerm           { low },
    -- NeoTreeRootName             { low },
    -- NeoTreeIndentMarker         { low },
    -- NeoTreeExpander             { low },
    -- NeoTreeModified             { low },
    -- NeoTreeWindowsHidden        { low },
    -- NeoTreePreview              { low },
    NeoTreeGitAdded            { DiffAdd, gui = "bold" },
    NeoTreeGitDeleted           { DiffDelete, gui = "bold" },
    NeoTreeGitModified          { DiffChange, gui = "bold" },
    NeoTreeGitConflict          { fg = yellow, bg = bg, gui = "bold" },
    NeoTreeGitIgnored           { low },
    NeoTreeGitRenamed           { DiffChange, gui = "bold" },
    NeoTreeGitStaged            { NeoTreeGitAdded },
    NeoTreeGitUnstaged          { mid, gui = "bold" },
    NeoTreeGitUntracked         { mid, gui = "bold" },
    -- NeoTreeTabActive            { low },
    -- NeoTreeTabInactive          { low },
    -- NeoTreeTabSeparatorActive   { low },
    -- NeoTreeTabSeparatorInactive { low },

    -- NormalFloat  { }, -- Normal text in floating windows.
    -- ColorColumn  { }, -- used for the columns set with 'colorcolumn'
    -- Conceal      { }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    -- Cursor       { }, -- character under the cursor
    -- lCursor      { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
    -- Directory    { }, -- directory names (and other special names in listings)
    -- DiffAdd      { }, -- diff mode: Added line |diff.txt|
    -- DiffChange   { }, -- diff mode: Changed line |diff.txt|
    -- DiffDelete   { }, -- diff mode: Deleted line |diff.txt|
    -- DiffText     { }, -- diff mode: Changed text within a changed line |diff.txt|
    -- EndOfBuffer  { }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    -- TermCursor   { }, -- cursor in a focused terminal
    -- TermCursorNC { }, -- cursor in an unfocused terminal
    -- ErrorMsg     { }, -- error messages on the command line
    -- VertSplit    { }, -- the column separating vertically split windows
    -- Folded       { }, -- line used for closed folds
    -- FoldColumn   { }, -- 'foldcolumn'
    -- SignColumn   { }, -- column where |signs| are displayed
    -- Substitute   { }, -- |:substitute| replacement text highlighting
    -- MatchParen   { }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea      { }, -- Area for messages and cmdline
    -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    -- MoreMsg      { }, -- |more-prompt|
    -- NonText      { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    -- NormalNC     { }, -- normal text in non-current windows
    -- Pmenu        { }, -- Popup menu: normal item.
    -- PmenuSel     { }, -- Popup menu: selected item.
    -- PmenuSbar    { }, -- Popup menu: scrollbar.
    -- PmenuThumb   { }, -- Popup menu: Thumb of the scrollbar.
    -- Question     { }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    -- SpecialKey   { }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace| 
    -- SpellBad     { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise. 
    -- SpellCap     { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise. 
    -- SpellLocal   { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare    { }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    -- StatusLine   { }, -- status line of current window
    -- StatusLineNC { }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    -- TabLine      { }, -- tab pages line, not active tab page label
    -- TabLineFill  { }, -- tab pages line, where there are no labels
    -- TabLineSel   { }, -- tab pages line, active tab page label
    -- Title        { }, -- titles for output from ":set all", ":autocmd" etc.
    -- Visual       { }, -- Visual mode selection
    -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
    -- WarningMsg   { }, -- warning messages
    -- Whitespace   { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    -- WildMenu     { }, -- current match in 'wildmenu' completion

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    -- Constant       { }, -- (preferred) any constant
    -- String         { }, --   a string constant: "this is a string"
    -- Character      { }, --  a character constant: 'c', '\n'
    -- Number         { }, --   a number constant: 234, 0xff
    -- Boolean        { }, --  a boolean constant: TRUE, false
    -- Float          { }, --    a floating point constant: 2.3e10

    -- Identifier     { }, -- (preferred) any variable name
    -- Function       { }, -- function name (also: methods for classes)

    -- Statement      { }, -- (preferred) any statement
    -- Conditional    { }, --  if, then, else, endif, switch, etc.
    -- Repeat         { }, --   for, do, while, etc.
    -- Label          { }, --    case, default, etc.
    -- Operator       { }, -- "sizeof", "+", "*", etc.
    -- Keyword        { }, --  any other keyword
    -- Exception      { }, --  try, catch, throw

    -- PreProc        { }, -- (preferred) generic Preprocessor
    -- Include        { }, --  preprocessor #include
    -- Define         { }, --   preprocessor #define
    -- Macro          { }, --    same as Define
    -- PreCondit      { }, --  preprocessor #if, #else, #endif, etc.

    -- Type           { }, -- (preferred) int, long, char, etc.
    -- StorageClass   { }, -- static, register, volatile, etc.
    -- Structure      { }, --  struct, union, enum, etc.
    -- Typedef        { }, --  A typedef

    -- Special        { Normal, fg = c0 }, -- (preferred) any special symbol
    -- SpecialChar    { }, --  special character in a constant
    -- Tag            { }, --    you can use CTRL-] on this
    -- Delimiter      { }, --  character that needs attention
    -- SpecialComment { }, -- special things inside a comment
    -- Debug          { }, --    debugging statements

    -- Underlined { gui = "underline" }, -- (preferred) text that stands out, HTML links
    -- Bold       { gui = "bold" },
    -- Italic     { gui = "italic" },

    -- ("Ignore", below, may be invisible...)
    -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

    -- Error          { }, -- (preferred) any erroneous construct

    -- Todo           { }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client. Some other LSP clients may use
    -- these groups, or use their own. Consult your LSP client's documentation.

    -- LspDiagnosticsError               { }, -- used for "Error" diagnostic virtual text
    -- LspDiagnosticsErrorSign           { }, -- used for "Error" diagnostic signs in sign column
    -- LspDiagnosticsErrorFloating       { }, -- used for "Error" diagnostic messages in the diagnostics float
    -- LspDiagnosticsWarning             { }, -- used for "Warning" diagnostic virtual text
    -- LspDiagnosticsWarningSign         { }, -- used for "Warning" diagnostic signs in sign column
    -- LspDiagnosticsWarningFloating     { }, -- used for "Warning" diagnostic messages in the diagnostics float
    -- LspDiagnosticsInformation         { }, -- used for "Information" diagnostic virtual text
    -- LspDiagnosticsInformationSign     { }, -- used for "Information" signs in sign column
    -- LspDiagnosticsInformationFloating { }, -- used for "Information" diagnostic messages in the diagnostics float
    -- LspDiagnosticsHint                { }, -- used for "Hint" diagnostic virtual text
    -- LspDiagnosticsHintSign            { }, -- used for "Hint" diagnostic signs in sign column
    -- LspDiagnosticsHintFloating        { }, -- used for "Hint" diagnostic messages in the diagnostics float
    -- LspReferenceText                  { }, -- used for highlighting "text" references
    -- LspReferenceRead                  { }, -- used for highlighting "read" references
    -- LspReferenceWrite                 { }, -- used for highlighting "write" references

    -- These groups are for the neovim tree-sitter highlights.
    -- As of writing, tree-sitter support is a WIP, group names may change.
    -- By default, most of these groups link to an appropriate Vim group,
    -- TSError -> Error for example, so you do not have to define these unless
    -- you explicitly want to support Treesitter's improved syntax awareness.

    -- TSError              { }, -- For syntax/parser errors.
    -- TSPunctDelimiter     { }, -- For delimiters ie: `.`
    -- TSPunctBracket       { }, -- For brackets and parens.
    -- TSPunctSpecial       { }, -- For special punctutation that does not fall in the catagories before.
    -- TSConstant           { }, -- For constants
    -- TSConstBuiltin       { }, -- For constant that are built in the language: `nil` in Lua.
    -- TSConstMacro         { }, -- For constants that are defined by macros: `NULL` in C.
    -- TSString             { }, -- For strings.
    -- TSStringRegex        { }, -- For regexes.
    -- TSStringEscape       { }, -- For escape characters within a string.
    -- TSCharacter          { }, -- For characters.
    -- TSNumber             { }, -- For integers.
    -- TSBoolean            { }, -- For booleans.
    -- TSFloat              { }, -- For floats.
    -- TSFunction           { }, -- For function (calls and definitions).
    -- TSFuncBuiltin        { }, -- For builtin functions: `table.insert` in Lua.
    -- TSFuncMacro          { }, -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
    -- TSParameter          { }, -- For parameters of a function.
    -- TSParameterReference { }, -- For references to parameters of a function.
    -- TSMethod             { }, -- For method calls and definitions.
    -- TSField              { }, -- For fields.
    -- TSProperty           { }, -- Same as `TSField`.
    -- TSConstructor        { }, -- For constructor calls and definitions: `                                                                       { }` in Lua, and Java constructors.
    -- TSConditional        { }, -- For keywords related to conditionnals.
    -- TSRepeat             { }, -- For keywords related to loops.
    -- TSLabel              { }, -- For labels: `label:` in C and `:label:` in Lua.
    -- TSOperator           { }, -- For any operator: `+`, but also `->` and `*` in C.
    -- TSKeyword            { }, -- For keywords that don't fall in previous categories.
    -- TSKeywordFunction    { }, -- For keywords used to define a fuction.
    -- TSException          { }, -- For exception related keywords.
    -- TSType               { }, -- For types.
    -- TSTypeBuiltin        { }, -- For builtin types (you guessed it, right ?).
    -- TSNamespace          { }, -- For identifiers referring to modules and namespaces.
    -- TSInclude            { }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    -- TSAnnotation         { }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    -- TSText               { }, -- For strings considered text in a markup language.
    -- TSStrong             { }, -- For text to be represented with strong.
    -- TSEmphasis           { }, -- For text to be represented with emphasis.
    -- TSUnderline          { }, -- For text to be represented with an underline.
    -- TSTitle              { }, -- Text that is part of a title.
    -- TSLiteral            { }, -- Literal text.
    -- TSURI                { }, -- Any URI like a link or email.
    -- TSVariable           { }, -- Any variable name that does not have another highlight.
    -- TSVariableBuiltin    { } -- Variable names that are defined by the languages, like `this` or `self`.

  }
end)

-- lush(theme)

return theme

-- vi:nowrap:cursorline:number
