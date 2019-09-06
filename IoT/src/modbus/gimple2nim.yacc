%{
    #include "gimple2nim.hpp"
%}
%defines %union { char *c; }
%token <c> SYM
%%
REPL : | REPL SYM { cout << $2 << endl; }
%%

#define YYERR "\n\n"<<yylineno<<":"<<msg<<"["<<yytext<<"]\n\n"
void yyerror(string msg) { cout<<YYERR; cerr<<YYERR; exit(-1); }
