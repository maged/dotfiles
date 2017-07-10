if exists("b:current_syntax")
  finish
endif

" Always ignore case
syn case ignore

" General keywords which don't fall into other categories
syn keyword dremelKeyword         select from where set show
syn keyword dremelKeyword         tables describe define inline table
syn keyword dremelKeyword         drop macro within omit if each
syn keyword dremelKeyword         limit ignore case
syn keyword dremelKeyword         record as materialize
syn keyword dremelKeyword         contains
syn keyword dremelKeyword         between in like flatten join from
syn keyword dremelKeyword         inner left right outer full all macros
syn keyword dremelKeyword         shuffle on
syn keyword dremelKeyword         source
syn keyword dremelKeyword         asc desc
syn match dremelKeyword /order by/
syn match dremelKeyword /group by/

" Special values
syn keyword dremelSpecial         null

" Strings (single- and double-quote)
syn region dremelString           start=+"+  skip=+\\\\\|\\"+  end=+"+
                                \ contains=@Spell
syn region dremelString           start=+'+  skip=+\\\\\|\\'+  end=+'+
                                \ contains=@Spell

" Numbers and hexidecimal values
syn match dremelNumber            "-\=\<[0-9]*\>"
syn match dremelNumber            "-\=\<[0-9]*\.[0-9]*\>"
syn match dremelNumber            "-\=\<[0-9][0-9]*e[+-]\=[0-9]*\>"
syn match dremelNumber            "-\=\<[0-9]*\.[0-9]*e[+-]\=[0-9]*\>"
syn match dremelNumber            "\<0x[abcdefABCDEF0-9]*\>"

" Type Conversion Functions

syn match dremelSourceLine /\(source \)\@<=[[:alnum:].\/_]*;/

" Logical, string and  numeric operators
syn keyword dremelOperator        and or not
syn match   dremelOperator        /[-+*\/%&|\^~=><]/
syn match   dremelOperator        /!=/

" Comments
syn match dremelComment           "#.*" contains=@Spell
syn match dremelComment           "--.*"
syn region dremelComment          start='/\*' end='\*/'
                                \ containedin=ALLBUT,dremelString
                                \ contains=@Spell keepend
syn sync ccomment dremelComment

syn match dremelSpecialOperators /[()]/ containedin=ALLBUT,dremelComment

" Control flow functions
syn keyword dremelFlow            case when then else end

" General Functions
syn match   dremelFunction         "\$\w*"
syn keyword dremelFunction        avg corr count covar_pop covar_samp group_concat
syn keyword dremelFunction        last max min next nth quantiles stddev stddev_samp
syn keyword dremelFunction        stddev_pop sum top variance var_samp var_pop
syn keyword dremelFunction        abs acos acosh asin asinh atan atanh atan2
syn keyword dremelFunction        ceil cos cosh degrees floor ln log log2 log10
syn keyword dremelFunction        pi pow radians round sin sinh sqrt tan tanh
syn keyword dremelFunction        isnull is_explicitly_defined
syn keyword dremelFunction        is_inf is_nan format_ip parse_ip format_packed_ip
syn keyword dremelFunction        parse_packed_ip concat instr left length lower lpad
syn keyword dremelFunction        ltrim normalize_for_match right replace rpad rtrim
syn keyword dremelFunction        substr trim upper regexp extract_regexp regexp_replace
syn keyword dremelFunction        host domain tld now format_time_usec parse_time_usec
syn keyword dremelFunction        strftime_usec time_usec_to_hour time_usec_to_day
syn keyword dremelFunction        time_usec_to_week time_usec_to_month time_usec_to_quarter
syn keyword dremelFunction        time_usec_to_year format_utc_usec parse_utc_usec
syn keyword dremelFunction        strftime_utc_usec utc_usec_to_day utc_usec_to_hour
syn keyword dremelFunction        utc_usec_to_month utc_usec_to_quarter utc_usec_week
syn keyword dremelFunction        utc_usec_to_year year quarterofyear monthofyear
syn keyword dremelFunction        monthofquarter weekofyear weekofquarter weekofmonth
syn keyword dremelFunction        dayofyear dayofquarter dayofmonth dayofweek hour
syn keyword dremelFunction        minute second monthname monthanmeshort dayname
syn keyword dremelFunction        daynameshort date_add datediff position fingerprint
syn keyword dremelFunction        external_cityhash benchmark string


" Sawzall intrinsics
syn keyword dremelFunction        addday addmonth addweek addyear bytesfind bytesrfind
syn keyword dremelFunction        dayofmonth dayofweek dayofyear format formattime highbit
syn keyword dremelFunction        hourof lowercase minuteof monthof parsetime secondof
syn keyword dremelFunction        strfind strreplace strrfind trunc trunctoday trunctohour
syn keyword dremelFunction        trunctominute trunctomonth trunctoquarter trunctosecond
syn keyword dremelFunction        trunctoweek trunctoyear uppercase yearof

hi def link dremelKeyword Statement
hi def link dremelSpecial Special
hi def link dremelString String
hi def link dremelNumber Number
hi def link oniable Identifier
hi def link dremelComment Comment
hi def link dremelType Type
hi def link dremelOperator Statement
hi def link dremelFlow Statement
hi def link dremelFunction Function
hi def link dremelSource Keyword
hi def link dremelSourceLine Directory
hi def link dremelColumnAlias Type
hi def link dremelAlias Type
hi def link dremelSpecialOperators Special

let b:current_syntax = "dremel"

