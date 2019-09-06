%{
    #include <iostream>
    using namespace std;
%}
%defines %union { char *c; }
%token <c> SYM
%%
REPL : | REPL SYM { cout << $2 << endl; }
%%