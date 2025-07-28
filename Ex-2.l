%{
    #define LT 256
    #define LE 257
    #define EQ 258
    #define NE 259
    #define GT 260
    #define GE 261
    #define RELOP 262
    #define ID 263
    #define NUM 264
    #define IF 265
    #define THEN 266
    #define ELSE 267
    int attribute;
%}

delim   [\t\n]
ws      {delim}+
letter  [A-Za-z]
digit   [0-9]
id      {letter}({letter}|{digit})*
num     {digit}+(\.{digit}+)?(E[+-]?{digit}+)?

%%
{ws}        {}
if          { return(IF); }
then        { return(THEN); }
else        { return(ELSE); }
{id}        { return(ID); }
{num}       { return(NUM); }

"<="        { attribute = LE; return(RELOP); }
"<>"        { attribute = NE; return(RELOP); }
"<"         { attribute = LT; return(RELOP); }
">="        { attribute = GE; return(RELOP); }
">"         { attribute = GT; return(RELOP); }
"="         { attribute = EQ; return(RELOP); }
%%

int yywrap() {
    return 1;
}

int main() {
    int token;
    while ((token = yylex()) != 0) {
        printf("<%d,", token);
        switch(token) {
            case ID:
            case NUM:
                printf("%s>\n", yytext);
                break;
            case RELOP:
                printf("%d>\n", attribute);
                break;
            default:
                printf(">\n");
                break;
        }
    }
    return 0;
}
