%{
#include <stdio.h>
%}

digit   [0-9]
letter  [a-zA-Z]
identifier {letter}({letter}|{digit})*

%%

"int"|"float"|"char"|"if"|"else"|"while"|"return" { printf("%s : KEYWORD\n", yytext); }
{identifier} { printf("%s : IDENTIFIER\n", yytext); }
{digit}+ { printf("%s : NUMBER\n", yytext); }
"+"|"-"|"*"|"/"|"=" { printf("%s : Operator\n", yytext); }
.   { /* Ignore other characters */ }

%%

int main() {
    yylex();
    return 0;
}

int yywrap() { return 1; }
