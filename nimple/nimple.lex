%{
    #include "nimple.hpp"
    unsigned int curl=0;
%}
%option noyywrap yylineno
%x CURL
%%
\(              TOC(LP)
\)              TOC(RP)
\{              { curl++; BEGIN(CURL); TOC(LC); }
<CURL>\{        { curl++; }
<CURL>\}        { curl--; if (!curl) { BEGIN(INITIAL); TOC(RC); } }
<CURL>.         {}
[a-zA-Z0-9_]+   TOC(SYM)
[ \t\r\n]+      {}
.               {yyerror(yytext);}
%%
int main() { return yyparse(); }
