%{
open Pcfast ;;
open Pcfsem ;;

%}

// let rec mkfun params descrp =
//   match params with
//   | [] -> descrp
//   | p :: prms -> EFun(p, mkfun prms descrp)
// ;;
// let rec mklist params varlist =
//   match params with
//   | [] -> descrp
//   | p :: prms -> EFun(p, mkfun prms descrp)
// ;;


%token <int> INT
%token <string> IDENT
// %token TRUE FALSE
%token <string> STRING
%token <char> CHAR
%token AUTOMATE ETAT INIT FIN TRANS
%token LPAR RPAR LACCO RACCO LCRO RCRO VIRG SEMISEMI SEMI LET DPTS ARROW
%left DPTS
// %token LET REC IN FUN ARROW
// %token IF THEN ELSE
// %left EQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL
// %left PLUS MINUS
// %left MULT DIV

%start main
%type <Pcfast.descrp> main

%%

main: descrp SEMISEMI { $1 }
    | SEMISEMI main { $2 }
;

/* Grammaire */

descrp:
 | AUTOMATE IDENT LACCO etat_list etat_init etat_final trans_list RACCO
         { 
          {
          n_pile = 0;
          name = $2;
          etat_list = $4;
          etat_init = $5;
          etat_final = $6;
          transition_list = $7;  
          etat_map = []; 
          }     
         };
 | AUTOMATE LPAR INT RPAR IDENT LACCO etat_list etat_init etat_final trans_list RACCO
         { 
          {
          n_pile = $3;
          name = $5;
          etat_list = $7;
          etat_init = $8;
          etat_final = $9;
          transition_list = $10;  
          etat_map = []; 
          }     
         };
etat_list:
  ETAT DPTS list_etat SEMI {$3};
trans_list:
  TRANS DPTS list_trans SEMI {$3};
etat_init:
  INIT DPTS IDENT SEMI {$3};
etat_final:
  FIN DPTS list_etat SEMI {$3};

list_etat:
  | LCRO RCRO { [] }
  | LCRO list_of_etat RCRO { $2 }
;
list_trans:
  | LCRO RCRO { [] }
  | LCRO list_of_trans RCRO { $2 }
;
list_of_etat:
  | IDENT { [$1] }
  | list_of_etat VIRG IDENT { $1 @ [$3] }
;
list_of_trans:
  | transition  {[$1]}
  | list_of_trans VIRG transition { $1 @ [$3] }
;
transition:
  | LPAR IDENT VIRG CHAR VIRG IDENT RPAR {
    {
      etat_from = $2;
      etat_to = $6;
      action = $4;
      pile = [];
    }
  }
  | LPAR IDENT VIRG CHAR VIRG IDENT VIRG list_of_pile_actions RPAR {
    {
      etat_from = $2;
      etat_to = $6;
      action = $4;
      pile = $8;
    }
  }
;
list_of_pile_actions:
  | pile_action  {[$1]}
  | list_of_pile_actions VIRG pile_action { $1 @ [$3] }
;
pile_action:
  | LPAR CHAR VIRG ARROW RPAR {Action($2, false)} //dépiler
  | LPAR ARROW VIRG CHAR RPAR {Action($4, true)}  //empiler
  | LPAR RPAR {None}
;
// var:
//   IDENT                         { EIdent($1) }
// | LPAR INT VIRG STRING VIRG INT RPAR    { ETrans ($2, $6, $4) }
// ;
// seqident:
//   IDENT seqident  { $1 :: $2 }
// | /* rien */      { [] }
// ;

// arith_descrp:
//   arith_descrp EQUAL arith_descrp        { EBinop ("=", $1, $3) }
// | arith_descrp GREATER arith_descrp      { EBinop (">", $1, $3) }
// | arith_descrp GREATEREQUAL arith_descrp { EBinop (">=", $1, $3) }
// | arith_descrp SMALLER arith_descrp      { EBinop ("<", $1, $3) }
// | arith_descrp SMALLEREQUAL arith_descrp { EBinop ("<=", $1, $3) }
// | arith_descrp PLUS arith_descrp         { EBinop ("+", $1, $3) }
// | arith_descrp MINUS arith_descrp        { EBinop ("-", $1, $3) }
// | arith_descrp MULT arith_descrp         { EBinop ("*", $1, $3) }
// | arith_descrp DIV arith_descrp          { EBinop ("/", $1, $3) }
// | application                        { $1 }
// ;

/* On considere ci-dessous que MINUS atom est dans la categorie
 * des applications. Cela permet de traiter n - 1
 * comme une soustraction binaire, et       f (- 1)
 * comme l'application de f a l'oppose de 1.
 */

// application:
//   application atom { EApp ($1, $2) }
// | MINUS atom       { EMonop ("-", $2) }
// | atom             { $1 }
// ;

// atom:
//   INT            { EInt ($1) }
// | TRUE           { EBool (true) }
// | FALSE          { EBool (false) }
// | STRING         { EString ($1) }
// | IDENT          { EIdent ($1) }
// | LPAR descrp RPAR { $2 }
// ;
