%{
    #include "nimple.hpp"
%}
%defines %union { char *c; }
%token <c> SYM LP RP LC RC LQ RQ
%type <c> ex
%%
REPL :
    | REPL LC RC
    | REPL SYM LP   { cout << "\n< proc " << $2 << " >\n"; }
    | REPL ex       { cout << "\n<" << $2 << ">\n"; }
ex: SYM
ex: LP | RP
%%

#define YYERR "\n\n"<<yylineno<<":"<<msg<<"["<<yytext<<"]\n\n"
void yyerror(string msg) { cout<<YYERR; cerr<<YYERR; exit(-1); }
