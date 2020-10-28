package lang.ast; // The generated scanner will belong to the package lang.ast

import lang.ast.LangParser.Terminals; // The terminals are implicitly defined in the parser
import lang.ast.LangParser.SyntaxError;

%%

// define the signature for the generated scanner
%public
%final
%class LangScanner
%extends beaver.Scanner

// the interface between the scanner and the parser is the nextToken() method
%type beaver.Symbol 
%function nextToken 

// store line and column information in the tokens
%line
%column

// this code will be inlined in the body of the generated scanner class
%{
  private beaver.Symbol sym(short id) {
    return new beaver.Symbol(id, yyline + 1, yycolumn + 1, yylength(), yytext());
  }
%}

// macros
WhiteSpace = [ ] | \t | \f | \n | \r
ID = [a-zA-Z_]+
Numeral = [0-9]+
Float = [0-9]+ "." [0-9]*
String = "\"" ([^"\"""\\"] | "\\\"")* "\""

EOL_Comment = "//" [^\n\r]* ( \r | \n | \r\n)?


%%

// discard whitespace information
{WhiteSpace}  { }
{EOL_Comment} { }

// token definitions

"true"        { return sym(Terminals.TRUE); }
"false"       { return sym(Terminals.FALSE); }
"int"         { return sym(Terminals.INTTYPE); }
"bool"        { return sym(Terminals.BOOLTYPE); }
"float"       { return sym(Terminals.FLOATTYPE); }
"class"       { return sym(Terminals.CLASS); }
"return"      { return sym(Terminals.RETURN); }
"this"        { return sym(Terminals.THIS); }
"new"         { return sym(Terminals.NEW); }

"while"       { return sym(Terminals.WHILE); }
"if"          { return sym(Terminals.IF); }
"else"        { return sym(Terminals.ELSE); }

"("           { return sym(Terminals.LPAREN); }
")"           { return sym(Terminals.RPAREN); }
"{"           { return sym(Terminals.LBRACE); }
"}"           { return sym(Terminals.RBRACE); }
","           { return sym(Terminals.COMMA); }
"."           { return sym(Terminals.DOT); }
";"           { return sym(Terminals.SEMICOLON); }

"+"           { return sym(Terminals.PLUS); }
"-"           { return sym(Terminals.MINUS); }
"*"           { return sym(Terminals.STAR); }
"/"           { return sym(Terminals.SLASH); }
"%"           { return sym(Terminals.MOD); }
"="           { return sym(Terminals.ASSIGN); }
"!"           { return sym(Terminals.NOT); }
"=="          { return sym(Terminals.EQ); }
"!="          { return sym(Terminals.NEQ); }
"<"           { return sym(Terminals.LT); }
">"           { return sym(Terminals.GT); }
">="          { return sym(Terminals.GTEQ); }
"<="          { return sym(Terminals.LTEQ); }
"&&"          { return sym(Terminals.AND); }
"||"          { return sym(Terminals.OR); }
"^^"          { return sym(Terminals.XOR); }

{String}      { return sym(Terminals.STRING); }
{ID}          { return sym(Terminals.ID); }
{Numeral}     { return sym(Terminals.INTEGER); }
{Float}       { return sym(Terminals.FLOAT); }
<<EOF>>       { return sym(Terminals.EOF); }

/* error fallback */
[^]           { throw new SyntaxError("Illegal character <"+yytext()+">"); }
