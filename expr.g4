grammar expr;

@header{
    package parser;
}

program
:   exp EOF
;

exp
:   orExp
    (   ':='
        orExp
    )?
;

orExp
:   andExp
    (   '|'
        andExp
        (   '|'
            andExp
        )*
    )?
;

andExp
:   compExp
    (   '&'
        compExp
        (   '&'
            compExp
        )*
    )?
;

compExp
:   addExp
    (   (   '='
        |   '<>'
        |   '<'
        |   '>='
        |   '>'
        |   '<='
        )
        addExp
    )?
;

addExp
:   mulExp
    (   '+'
        mulExp
        (   '+'
            mulExp
        )*
    )?
    (   '-'
        mulExp
        (   '+'
            mulExp
            (   '+'
                mulExp
            )*
        )?
    )*
;

mulExp
:   unaryExp
    (   '*'
        unaryExp
        (   '*'
            unaryExp
        )*
    )?
    (   '/'
        unaryExp
        (   '*'
            unaryExp
            (   '*'
                unaryExp
            )*
        )?
    )*
;

unaryExp
:   seqExp
|   negExp
|   valueExp
|   ifExp
|   whileExp
|   forExp
|   letExp
|   STR
|   INT
|   'nil'
|   'break'
;

seqExp
:   '('
    (   exp
        (   ';'
            exp
        )*
    )?
    ')'
;

negExp
:   '-'
    unaryExp
;

valueExp // Gère les anciens "lValue", "callExp", "arrCreate" et "recCreate"
:   ID
    (   '('
        (   exp
            (   ','
                exp
            )*
        )?
        ')'
    |   '['
        exp
        ']'
        (
            (   '['
                exp
                ']'
            |   '.'
                ID
            )*
        |   'of'
            unaryExp
        )
    |   '.'
        ID
        (   '['
            exp
            ']'
        |   '.'
            ID
        )*
    |   '{'
        (   ID
            '='
            exp
            (   ','
                ID
                '='
                exp
            )*
        )?
        '}'
    )?
;

ifExp
:   'if'
    exp
    'then'
    unaryExp
    (:  'else'
        unaryExp
    )?
;

whileExp
:   'while'
    exp
    'do'
    unaryExp
;

forExp
:   'for'
    ID
    ':='
    exp
    'to'
    exp
    'do'
    unaryExp
;

letExp
:   'let'
    dec+
    'in'
    (   exp
        (   ';'
            exp
        )*
    )?
    'end'
;

dec
:   tyDec
|   funDec
|   varDec
;

tyDec
:   'type'
    ID
    '='
    (   ID
    |   'array'
        'of'
        ID
    |   '{'
        (   ID
            ':'
            ID
            (   ','
                ID
                ':'
                ID
            )*
        )?
        '}'
    )
;

funDec
:   'function'
    ID
    '('
    (   i += ID
        ':'
        j += ID
        (   ','
            i += ID
            ':'
            j += ID
        )*
    )?
    ')'
    (   ':'
        k = ID
    )?
    '='
    exp
;

varDec
:   'var'
    ID
    (   ':'
        k = ID
    )?
    ':='
    exp
;

ID
:   (   'A'..'Z'
    |   'a'..'z'
    )
    (   '0'..'9'
    |   'A'..'Z'
    |   '_'
    |   'a'..'z'
    )*
;

STR
:   '"'
    (   ' '..'!'
    |   '#'..'['
    |   ']'..'~'
    |   '\\'
        (   'n'
        |   't'
        |   '"'
        |   '\\'
        |   '^'
            '@'..'_'
        |   '0' // Nombre ASCII partie 1 (commencant par 0)
            '0'..'9'
            '0'..'9'
        |   '1' // Nombre ASCII partie 2 (commencant par 1)
            (   '0'..'1'
                '0'..'9'
            |   '2'
                '0'..'7'
            )
        |   (   ' ' // Échappement de caractères blancs
            |   '\t'
            |   '\n'
            |   '\r'
            |   '\f'
            )+
            '\\'
        )
    )*
    '"'
;

INT
:   '0'..'9'+
;

COMMENT
:   (
        '/*'
        ()*
        (   COMMENT
            ()*
        )*
        '*/'
    )
;

WS
:   (   ' '
    |   '\t'
    |   '\n'
    |   '\r'
    |   '\f'
    )+ -> skip
;