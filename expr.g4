grammar expr;

@header{
package parser;
}


program : 
    instr_list EOF;

instr : 
      affect           
    | if_litteral       
    | print_litteral
    ;

print_litteral :'print' expr ';' ;


if_litteral : 
      'if' '('expr')' '{'instr_list'}' 'else' '{'instr_list'}'    #IfThenElse
    | 'if' '('expr')' '{'instr_list'}'                            #IfThen
    ;

instr_list : instr+;

affect : IDF '=' expr ';' ;

expr : plus; 

plus:  mult (('+'|'-') mult)*;

mult : value (('*'|'/') value)*;

value :   INT           #Integer
        | IDF           #Identifier
        | '('expr')'    #Parenthesis
        ;


INT : ('0'..'9')+;

IDF : ('a'..'z'|'A'..'Z'|'_')('a'..'z'|'A'..'Z'|'0'..'9')*;

WS : ('\n'|' '|'\t'|'\r')+ -> skip;