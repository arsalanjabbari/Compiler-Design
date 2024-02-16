 /*segment-one*/
%{

#define YYSTYPE_IS_DECLARED 1
typedef char* YYSTYPE;
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>
char* install_num();

%}


 /*segment-two*/
delim [ \t\n]
ws {delim}+
digit [0-9]
number {digit}+


%%


 /*segment-three*/
{ws} { }
\+ {return '+';}
\- {return '-';}
\* {return '*';}
\/ {return '/';}
\= { return '=';}
\( {return '(';}
\) {return ')';}
{number} {yylval = install_num(); return NUMBER;}


%%


char* install_num() {
    char *y = malloc(yyleng+100);
    strcpy(y,yytext);
    return y;
}
int yywrap(){}