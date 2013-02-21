" Vim syntax file
" Language:	Protel
" Version: 1.0
" Last Change:	2002/09/19 15:11:57
" Maintainer:  Lynx Hu <lynxhu@gdnt.com.cn>

" Contributors:

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

"! syn sync lines=250

syn keyword CprotelStatement	interface section uses of
syn keyword CprotelStatement	block endblock aligned endaligned const var type return exit bind to
syn keyword CprotelStatement	proc method is init forward extern entry intrinsic returns literal pack ref resolve updates val
syn keyword CprotelStatement	dcl as
syn keyword CprotelStatement	perprocess definitions
syn keyword CprotelStatement	blocking writeblocking nonblocking  
syn keyword CprotelStatement	element index rare usual round_up root target
syn keyword CprotelStatement	handle raise retry
syn keyword CprotelStatement	abstract any inspect endinspect parent slef super
syn keyword CprotelStatement	fast nontransparent operand quick tagfield variable with

syn keyword CprotelConditional	if then else elseif endif case endcase in out switch select endselect
syn keyword CprotelRepeat	do enddo for over from by while
syn keyword CprotelStruct	struct endstruct area endarea ovly endovly unrestricted refines
syn keyword CprotelStruct	class endclass field field_bit_offset field_bit_size Coperator
syn keyword CprotelAccess	private shared protected dcl obsolete scratch

syn keyword CprotelOperator	mod incl notincl upb tdsize desc ptr cast

syn match CprotelConditional	"down\s*to"
syn match CprotelConditional	"up\s*to"

syn match Coperator "desc\s*of"
syn match Coperator "desc64\s*of"
syn match Coperator "longdesc\s*of"
syn match Coperator "longdesc64\s*of"

syn match Coperator "ptr\s*to"
syn match Coperator "ptr64\s*to"

syn match protelShowTab "\t"


" goldy: match for splitted *.sdelta 
syn match SDeltaDelete "^<"
syn match SDeltaChange "^|"
syn match SDeltaAdd "^>"


" Constant
syn keyword protelConstant	nil

" Type
syn keyword protelBoolean	true false
syn keyword protelType	table bool set int char
syn keyword protelType	$int $longint $universal_ptr
syn keyword protelType	log2_ceiling 


"! syn keyword protelLabel	case goto label

syn keyword protelTodo contained	TODO

syn region  protelString matchgroup=protelString start=+'+ end=+'+ end=+$+ contains=protelStringEscape

syn match protelDirective "^\$[^%]*"

syn match   protelSymbolOperator	"[+\-/*=]"

" goldy: redefine symbol < > , for they may be confused with SDelta Indicators
"  syn match   protelSymbolOperator	"[<>\^]=\="
syn match   protelSymbolOperator	"[\^]=\="
syn match   protelSymbolOperator        ".<"
syn match   protelSymbolOperator        ".>"

syn match   protelSymbolOperator	"->"
syn match   protelSymbolOperator	"[()]"
syn match   protelMatrixDelimiter	"[][]"

syn match  protelNumber		"-\=\<\d\+\>"
syn match  protelHexNumber	"#[0-9a-fA-F]\+\>"

syn match  protelSegct  "&[ 0-9][ 0-9][ 0-9][ 0-9]\[[ 0-9][ 0-9]\]"

syn region protelComment	start="%"	end="$"	contains=protelTodo

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_protel_syn_inits")
  if version < 508
    let did_protel_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink CprotelAccess	CprotelStatement
  HiLink protelBoolean	Boolean
  HiLink protelComment	Comment
  HiLink CprotelConditional	Conditional
  HiLink protelConstant	Constant
  HiLink protelDelimiter	Identifier
  HiLink protelDirective	CprotelStatement
  HiLink protelException	Exception
  HiLink protelFloat	Float
  HiLink protelFunction	Function
  HiLink protelHexNumber	protelNumber
  HiLink protelLabel	Label
  HiLink protelMatrixDelimiter	Identifier
  HiLink protelModifier	Type
"  HiLink protelNumber	CprotelStatement
  HiLink CprotelOperator	Operator
  HiLink protelPredefined	CprotelStatement
  HiLink protelPreProc	PreProc
  HiLink CprotelRepeat	Repeat
  HiLink CprotelStatement	Statement
  HiLink protelString	String
  HiLink protelStringEscape	Special
  HiLink protelStringEscapeGPC	Special
  HiLink protelStringError	Error
  HiLink CprotelStruct	CprotelStatement
  HiLink protelSymbolOperator	CprotelOperator
  HiLink protelTodo	Todo
  HiLink protelType	Type
  HiLink protelUnclassified	CprotelStatement
  HiLink protelError	Error
  HiLink protelAsmKey	CprotelStatement
"  HiLink protelShowTab	Error

  hi protelShowTab  guifg=black  guibg=gray gui=none  ctermfg=black

  HiLink protelShowTab	Special
  
  HiLink SDeltaDelete  DiffDelete
  HiLink SDeltaAdd     DiffAdd
  HiLink SDeltaChange  DiffChange

  HiLink protelSegct    Error

  delcommand HiLink
endif


let b:current_syntax = "protel"

" vim: ts=8 sw=2
