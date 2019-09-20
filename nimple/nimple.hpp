#ifndef _H_GIMPLE2NIM
#define _H_GIMPLE2NIM

#include <iostream>
using namespace std;

extern int yylex();
extern int yylineno;
extern char *yytext;
extern int yyparse();
extern void yyerror(string);
#include "nimple_yacc.hpp"

#define TOC(C) { yylval.c = yytext; return C; }

#endif // _H_GIMPLE2NIM
