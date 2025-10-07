%{
int yylex();
void yyerror(const char *s);
%}

%{
#define YYSTYPE double
#include <ctype.h>
#include <stdio.h>
%}

%token NUMBER
%left '+' '-'
%left '*' '/'
%right UMINUS

%%
lines:
      lines expr '\n' { printf("%g\n", $2); }
    | lines '\n'
    | /* empty */
    ;

expr:
      expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { $$ = $1 / $3; }
    | '(' expr ')'  { $$ = $2; }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | NUMBER
    ;

%%

int yylex()
{
    int c;
    while ((c = getchar()) == ' ' || c == '\t');

    if (c == '.' || isdigit(c)) {
        ungetc(c, stdin);
        scanf("%lf", &yylval);
        return NUMBER;
    }
    return c;
}

void yyerror(const char *s)
{
    fprintf(stderr, "Error: %s\n", s);
}

int main()
{
    return yyparse();
}

int yywrap()
{
    return 1;
}

