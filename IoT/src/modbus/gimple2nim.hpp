#ifndef _H_GIMPLE2NIM
#define _H_GIMPLE2NIM

#include <iostream>
using namespace std;

extern int yylex();
extern int yylineno;
extern char *yytext;
extern int yyparse();
extern void yyerror(string);
#include "gimple2nim_yacc.hpp"

#endif // _H_GIMPLE2NIM
