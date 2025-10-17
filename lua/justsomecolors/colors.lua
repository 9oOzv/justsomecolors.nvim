local vim = vim
local lush = require('lush')
local hsl = lush.hsl
local hsluv = lush.hsluv

---@diagnostic disable: undefined-global
local create = function(opts)
  return lush(
    function(injected_functions)
      local sym = injected_functions.sym
      background = opts.background or 'dark'

      local bg = "None"
      local opaque = hsluv(0, 0, 0)

      local fg = hsluv(0, 0, 100)
      local c0 = hsluv(227, 100, 80)
      local c1 = hsluv(330, 100, 60)
      local c2 = hsluv(0, 100, 58)

      if background == 'light' then
        fg = hsluv(0, 0, 0)
        opaque = hsluv(0, 0, 100)
        c0 = hsluv(227, 100, 70)
        c1 = hsluv(330, 100, 60)
        c2 = hsluv(0, 100, 50)
      end

      local green = hsluv(155, 100, 88)
      local red = hsluv(5, 100, 45)
      local yellow = hsluv(88, 100, 81)
      local cmid = fg.mix(opaque, 25)
      local clow = fg.mix(opaque, 50)
      local cverylow = fg.mix(opaque, 75)

      return {
        base { bg = bg, fg = fg },
        undef { bg = red, fg = opaque },
        error { bg = opaque, fg = red },
        mid { bg = bg, fg = cmid },
        low { bg = bg, fg = clow },
        verylow { bg = bg, fg = cverylow },
        b0ld { base, gui = "bold" },



        ----------------------------------------------------------------------
        -- Lush template

        -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
        -- groups, mostly used for styling UI elements.
        -- Comment them out and add your own properties to override the defaults.
        -- An empty definition `{}` will clear all styling, leaving elements looking
        -- like the 'Normal' group.
        -- To be able to link to a group, it must already be defined, so you may have
        -- to reorder items as you go.
        --
        -- See :h highlight-groups
        --
        -- ColorColumn    { }, -- Columns set with 'colorcolumn'
        -- Conceal        { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
        Cursor         { bg = opaque.mix(fg, 30) }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        -- CurSearch      { }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
        -- lCursor        { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
        -- CursorIM       { }, -- Like Cursor, but used when in IME mode |CursorIM|
        CursorColumn   { bg = opaque.mix(fg, 4) }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        CursorLine     { bg = opaque.mix(fg, 4) }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        -- Directory      { }, -- Directory names (and other special names in listings)
        DiffAdd        { base, fg = c0 }, -- diff mode: Added line |diff.txt|
        DiffChange     { base, fg = c1}, -- diff mode: Changed line |diff.txt|
        DiffDelete     { base, fg = red }, -- diff mode: Deleted line |diff.txt|
        -- DiffText       { }, -- Diff mode: Changed text within a changed line |diff.txt|
        -- EndOfBuffer    { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
        -- TermCursor     { }, -- Cursor in a focused terminal
        -- TermCursorNC   { }, -- Cursor in an unfocused terminal
        ErrorMsg       { error }, -- error messages on the command line
        -- VertSplit      { }, -- Column separating vertically split windows
        Folded         { low },
        FoldColumn     { low },
        SignColumn     { mid }, -- 'foldcolumn'
        IncSearch      { bg = green.mix(opaque, 40), fg=opaque },
        -- Substitute     { }, -- |:substitute| replacement text highlighting
        LineNr         { bg = bg, fg = fg, gui = "bold" },
        -- LineNrAbove    { }, -- Line number for when the 'relativenumber' option is set, above the cursor line
        -- LineNrBelow    { }, -- Line number for when the 'relativenumber' option is set, below the cursor line
        CursorLineNr   { bg = bg, fg = fg, gui = "bold" },
        -- CursorLineFold { }, -- Like FoldColumn when 'cursorline' is set for the cursor line
        -- CursorLineSign { }, -- Like SignColumn when 'cursorline' is set for the cursor line
        MatchParen     { base, bg = c1, fg = c0, gui = "bold" }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        -- ModeMsg        { }, -- 'showmode' message (e.g., "-- INSERT -- ")
        -- MsgArea        { }, -- Area for messages and cmdline
        -- MsgSeparator   { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        -- MoreMsg        { }, -- |more-prompt|
        -- NonText        { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        -- Normal         { }, -- Normal text
        Normal         { base },
        NormalFloat    { base, bg = opaque.mix(fg, 3), fg = c0 }, -- Normal text in floating windows.
        -- FloatBorder    { }, -- Border of floating windows.
        -- FloatTitle     { }, -- Title of floating windows.
        -- NormalNC       { }, -- normal text in non-current windows
        Pmenu          { base, fg = c0 }, -- Popup menu: normal item.
        PmenuSel       { base, fg = c1 }, -- Popup menu: selected item.
        -- PmenuKind      { }, -- Popup menu: Normal item "kind"
        -- PmenuKindSel   { }, -- Popup menu: Selected item "kind"
        -- PmenuExtra     { }, -- Popup menu: Normal item "extra text"
        -- PmenuExtraSel  { }, -- Popup menu: Selected item "extra text"
        PmenuSbar      { bg = c0, fg = opaque }, -- Popup menu: scrollbar.
        PmenuThumb     { bg = opaque, fg = c0 }, -- Popup menu: Thumb of the scrollbar.
        -- Question       { }, -- |hit-enter| prompt and yes/no questions
        QuickFixLine   { CursorLine },
        Search         { bg = green.mix(opaque, 20), fg=opaque },
        -- SpecialKey     { }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
        -- SpellBad       { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        -- SpellCap       { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        -- SpellLocal     { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        -- SpellRare      { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
        -- StatusLine     { }, -- Status line of current window
        -- StatusLineNC   { }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        -- TabLine        { }, -- Tab pages line, not active tab page label
        -- TabLineFill    { }, -- Tab pages line, where there are no labels
        -- TabLineSel     { }, -- Tab pages line, active tab page label
        -- Title          { }, -- Titles for output from ":set all", ":autocmd" etc.
        Visual         { bg = opaque.mix(fg, 15) },
        -- VisualNOS      { }, -- Visual mode selection when vim is "Not Owning the Selection".
        -- WarningMsg     { }, -- Warning messages
        Whitespace     { verylow, gui = "bold" },
        -- Winseparator   { }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
        -- WildMenu       { }, -- Current match in 'wildmenu' completion
        -- WinBar         { }, -- Window bar of current window
        -- WinBarNC       { }, -- Window bar of not-current windows

        -- Common vim syntax groups used for all kinds of code and markup.
        -- Commented-out groups should chain up to their preferred (*) group
        -- by default.
        --
        -- See :h group-name
        --
        -- Uncomment and edit if you want more specific syntax highlighting.

        Comment        { low, gui="bold" },

        Constant       { base, fg = c2 }, -- (preferred) any constant
        -- String         { }, --   A string constant: "this is a string"
        -- Character      { }, --   A character constant: 'c', '\n'
        -- Number         { }, --   A number constant: 234, 0xff
        -- Boolean        { }, --   A boolean constant: TRUE, false
        -- Float          { }, --   A floating point constant: 2.3e10

        Identifier     { base, fg = c0 }, -- (preferred) any variable name
        -- Function       { }, --   Function name (also: methods for classes)

        -- Statement      { }, -- (*) Any statement
        Statement      { base, fg = c1, gui = "bold" }, -- (preferred) any statement
        -- Conditional    { }, --   if, then, else, endif, switch, etc.
        -- Repeat         { }, --   for, do, while, etc.
        -- Label          { }, --   case, default, etc.
        -- Operator       { }, --   "sizeof", "+", "*", etc.
        Operator       { base, fg = c1.mix(fg, 70) }, -- "sizeof", "+", "*", etc.
        -- Keyword        { }, --   any other keyword
        -- Exception      { }, --   try, catch, throw

        PreProc        { base, fg = c1.mix(opaque, 12) }, -- (preferred) generic Preprocessor
        -- Include        { }, --   Preprocessor #include
        -- Define         { }, --   Preprocessor #define
        -- Macro          { }, --   Same as Define
        -- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

        Type           { base, fg = c0, gui = "bold" }, -- (preferred) int, long, char, etc.
        -- StorageClass   { }, --   static, register, volatile, etc.
        -- Structure      { }, --   struct, union, enum, etc.
        -- Typedef        { }, --   A typedef

        Special        { mid }, -- (preferred) any special symbol
        -- SpecialChar    { }, --   Special character in a constant
        -- Tag            { }, --   You can use CTRL-] on this
        -- Delimiter      { }, --   Character that needs attention
        -- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
        -- Debug          { }, --   Debugging statements

        -- Underlined     { gui = "underline" }, -- Text that stands out, HTML links
        -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
        -- Error          { }, -- Any erroneous construct
        Todo           { bg = opaque.mix(fg, 5), fg = c1, gui = "bold" }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

        -- These groups are for the native LSP client and diagnostic system. Some
        -- other LSP clients may use these groups, or use their own. Consult your
        -- LSP client's documentation.

        -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
        --
        -- LspReferenceText            { } , -- Used for highlighting "text" references
        -- LspReferenceRead            { } , -- Used for highlighting "read" references
        -- LspReferenceWrite           { } , -- Used for highlighting "write" references
        -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
        -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
        -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

        -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
        --
        -- DiagnosticError            { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticWarn             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticInfo             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticHint             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticOk               { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticVirtualTextError { fg = cverylow.saturation(red.s).hue(red.h) },
        DiagnosticVirtualTextWarn  { fg = clow.saturation(yellow.s).hue(yellow.h) },
        DiagnosticVirtualTextInfo  { fg = cverylow },
        DiagnosticVirtualTextHint  { fg = cverylow },
        -- DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
        DiagnosticUnderlineError   { b0ld, fg = red },
        DiagnosticUnderlineWarn    { b0ld, fg = yellow },
        DiagnosticUnderlineInfo    { b0ld },
        -- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
        -- DiagnosticUnderlineOk      { } , -- Used to underline "Ok" diagnostics.
        -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
        -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
        DiagnosticSignError        { fg = cverylow.saturation(red.s).hue(red.h) },
        DiagnosticSignWarn         { fg = clow.saturation(yellow.s).hue(yellow.h) },
        DiagnosticSignInfo         { fg = cverylow },
        DiagnosticSignHint         { fg = cverylow },
        -- DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.


        -- Tree-Sitter syntax groups.
        --
        -- See :h treesitter-highlight-groups, some groups may not be listed,
        -- submit a PR fix to lush-template!
        --
        -- Tree-Sitter groups are defined with an "@" symbol, which must be
        -- specially handled to be valid lua code, we do this via the special
        -- sym function. The following are all valid ways to call the sym function,
        -- for more details see https://www.lua.org/pil/5.html
        --
        -- sym("@text.literal")
        -- sym('@text.literal')
        -- sym"@text.literal"
        -- sym'@text.literal'
        --
        -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

        -- sym"@text.literal"      { }, -- Comment
        -- sym"@text.reference"    { }, -- Identifier
        -- sym"@text.title"        { }, -- Title
        -- sym"@text.uri"          { }, -- Underlined
        -- sym"@text.underline"    { }, -- Underlined
        -- sym"@text.todo"         { }, -- Todo
        -- sym"@comment"           { }, -- Comment
        -- sym"@punctuation"       { }, -- Delimiter
        -- sym"@constant"          { }, -- Constant
        -- sym"@constant.builtin"  { }, -- Special
        -- sym"@constant.macro"    { }, -- Define
        -- sym"@define"            { }, -- Define
        -- sym"@macro"             { }, -- Macro
        -- sym"@string"            { }, -- String
        -- sym"@string.escape"     { }, -- SpecialChar
        -- sym"@string.special"    { }, -- SpecialChar
        -- sym"@character"         { }, -- Character
        -- sym"@character.special" { }, -- SpecialChar
        -- sym"@number"            { }, -- Number
        -- sym"@boolean"           { }, -- Boolean
        -- sym"@float"             { }, -- Float
        -- sym"@function"          { }, -- Function
        -- sym"@function.builtin"  { }, -- Special
        -- sym"@function.macro"    { }, -- Macro
        -- sym"@parameter"         { }, -- Identifier
        -- sym"@method"            { }, -- Function
        -- sym"@field"             { }, -- Identifier
        -- sym"@property"          { }, -- Identifier
        -- sym"@constructor"       { }, -- Special
        -- sym"@conditional"       { }, -- Conditional
        -- sym"@repeat"            { }, -- Repeat
        -- sym"@label"             { }, -- Label
        -- sym"@operator"          { }, -- Operator
        -- sym"@keyword"           { }, -- Keyword
        -- sym"@exception"         { }, -- Exception
        -- sym"@variable"          { }, -- Identifier
        -- sym"@type"              { }, -- Type
        -- sym"@type.definition"   { }, -- Typedef
        -- sym"@storageclass"      { }, -- StorageClass
        -- sym"@structure"         { }, -- Structure
        -- sym"@namespace"         { }, -- Identifier
        -- sym"@include"           { }, -- Include
        -- sym"@preproc"           { }, -- PreProc
        -- sym"@debug"             { }, -- Debug
        -- sym"@tag"               { }, -- Tag


        ----------------------------------------------------------------------
        -- RenderMarkdown

        RenderMarkdownH1                    { fg=c0 },
        RenderMarkdownH2                    { fg=c1},
        RenderMarkdownH3                    { fg=c2},
        RenderMarkdownH4                    { fg=c2},
        RenderMarkdownH5                    { fg=c2},
        RenderMarkdownH6                    { fg=c2},
        RenderMarkdownH1Bg                  { },
        RenderMarkdownH2Bg                  { },
        RenderMarkdownH3Bg                  { },
        RenderMarkdownH4Bg                  { },
        RenderMarkdownH5Bg                  { },
        RenderMarkdownH6Bg                  { },
        RenderMarkdownCode                  { },
        -- RenderMarkdownCodeInfo              { },
        -- RenderMarkdownCodeBorder            { },
        -- RenderMarkdownCodeFallback          { },
        -- RenderMarkdownCodeInline            { },
        -- RenderMarkdownQuote                 { },
        -- RenderMarkdownQuote1                { },
        -- RenderMarkdownQuote2                { },
        -- RenderMarkdownQuote3                { },
        -- RenderMarkdownQuote4                { },
        -- RenderMarkdownQuote5                { },
        -- RenderMarkdownQuote6                { },
        -- RenderMarkdownInlineHighlight       { },
        -- RenderMarkdownBullet                { },
        -- RenderMarkdownDash                  { },
        -- RenderMarkdownSign                  { },
        -- RenderMarkdownMath                  { },
        -- RenderMarkdownIndent                { },
        -- RenderMarkdownHtmlComment           { },
        -- RenderMarkdownLink                  { },
        -- RenderMarkdownWikiLink              { },
        -- RenderMarkdownUnchecked             { },
        -- RenderMarkdownChecked               { },
        -- RenderMarkdownTodo                  { },
        -- RenderMarkdownTableHead             { },
        -- RenderMarkdownTableRow              { },
        -- RenderMarkdownTableFill             { },
        -- RenderMarkdownSuccess               { },
        -- RenderMarkdownInfo                  { },
        -- RenderMarkdownHint                  { },
        -- RenderMarkdownWarn                  { },
        -- RenderMarkdownError                 { },



        ----------------------------------------------------------------------
        -- Other
        NotifyBackground { bg = opaque }, -- Some box appeared telling me to define this
      }
    end
  )
end

return create
-- vi:nowrap:cursorline:number
