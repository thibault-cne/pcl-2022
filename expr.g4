grammar expr;

@header{
    package parser;
}

program
:   expression EOF
;

expression
:   operationOu ( ':=' operationOu)?
;

operationOu
:   operationEt ('|' operationEt)*
;

operationEt
:   operationComparaison ('&' operationComparaison)*
;

operationComparaison
:   operationAddition(
    (
        '='
    |   '<>'
    |   '<'
    |   '>='
    |   '>'
    |   '<='
    )
    operationAddition
    )?
;

operationAddition
:   operationMultiplication ('+' operationMultiplication)*
    ('-' operationMultiplication ('+' operationMultiplication)*)*
;

operationMultiplication
:   expressionUnaire  ('*' expressionUnaire)*
    ('/' expressionUnaire('*' expressionUnaire)*)*
;

expressionUnaire
:   sequenceInstruction
|   operationNegation
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

sequenceInstruction
:   '(' expression ( ';' expression )* ')'
;

operationNegation
:   '-' expressionUnaire
;

valueExp
:   ID
    ( 
      '(' ( expression ( ',' expression )* )? ')'
    | '[' expression ']' ( ( '[' expression ']' | '.' ID )* | 'of' expressionUnaire )
    | '.' ID ( '[' expression ']' | '.' ID )*
    | '{' ( ID '=' expression ( ',' ID '=' expression )* )? '}'
    )?
;

ifExp
:   'if'
    expression
    'then'
    expressionUnaire
    (:  'else'
        expressionUnaire
    )?
;

whileExp
:   'while'
    expression
    'do'
    expressionUnaire
;

forExp
:   'for'
    ID
    ':='
    expression
    'to'
    expression
    'do'
    expressionUnaire
;

letExp
:   'let'
    dec+
    'in'
    (   expression
        (   ';'
            expression
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
    expression
;

varDec
:   'var'
    ID
    (   ':'
        k = ID
    )?
    ':='
    expression
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
:    '/*' .*? '*/' -> skip
;

WS
:   (   ' '
    |   '\t'
    |   '\n'
    |   '\r'
    |   '\f'
    )+ -> skip
;