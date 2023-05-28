type token =
  | INT of (int)
  | IDENT of (string)
  | STRING of (string)
  | CHAR of (char)
  | AUTOMATE
  | ETAT
  | INIT
  | FIN
  | TRANS
  | LPAR
  | RPAR
  | LACCO
  | RACCO
  | LCRO
  | RCRO
  | VIRG
  | SEMISEMI
  | SEMI
  | LET
  | DPTS
  | ARROW

open Parsing;;
let _ = parse_error;;
# 2 "pcfparse.mly"
open Pcfast ;;
open Pcfsem ;;

# 31 "pcfparse.ml"
let yytransl_const = [|
  261 (* AUTOMATE *);
  262 (* ETAT *);
  263 (* INIT *);
  264 (* FIN *);
  265 (* TRANS *);
  266 (* LPAR *);
  267 (* RPAR *);
  268 (* LACCO *);
  269 (* RACCO *);
  270 (* LCRO *);
  271 (* RCRO *);
  272 (* VIRG *);
  273 (* SEMISEMI *);
  274 (* SEMI *);
  275 (* LET *);
  276 (* DPTS *);
  277 (* ARROW *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* IDENT *);
  259 (* STRING *);
  260 (* CHAR *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\003\000\006\000\004\000\005\000\
\007\000\007\000\008\000\008\000\009\000\009\000\010\000\010\000\
\011\000\011\000\012\000\012\000\013\000\013\000\013\000\000\000"

let yylen = "\002\000\
\002\000\002\000\008\000\011\000\004\000\004\000\004\000\004\000\
\002\000\003\000\002\000\003\000\001\000\003\000\001\000\003\000\
\007\000\009\000\001\000\003\000\005\000\005\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\024\000\000\000\000\000\000\000\
\002\000\001\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\013\000\009\000\000\000\005\000\000\000\000\000\000\000\
\000\000\000\000\010\000\000\000\007\000\000\000\000\000\003\000\
\000\000\014\000\008\000\000\000\000\000\000\000\000\000\011\000\
\000\000\015\000\006\000\000\000\000\000\012\000\000\000\004\000\
\000\000\016\000\000\000\000\000\000\000\017\000\000\000\000\000\
\000\000\019\000\000\000\023\000\000\000\018\000\000\000\000\000\
\000\000\020\000\000\000\000\000\021\000\022\000"

let yydgoto = "\002\000\
\005\000\006\000\014\000\018\000\024\000\033\000\021\000\045\000\
\028\000\049\000\050\000\065\000\066\000"

let yysindex = "\004\000\
\254\254\000\000\000\255\254\254\000\000\006\255\004\255\011\255\
\000\000\000\000\016\255\013\255\007\255\018\255\024\255\014\255\
\009\255\022\255\019\255\255\254\015\255\030\255\017\255\025\255\
\016\255\000\000\000\000\003\255\000\000\020\255\014\255\021\255\
\023\255\018\255\000\000\033\255\000\000\026\255\028\255\000\000\
\022\255\000\000\000\000\250\254\027\255\025\255\037\255\000\000\
\005\255\000\000\000\000\034\255\032\255\000\000\036\255\000\000\
\039\255\000\000\035\255\038\255\251\254\000\000\040\255\252\254\
\253\254\000\000\041\255\000\000\042\255\000\000\040\255\031\255\
\045\255\000\000\043\255\044\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\049\000\000\000\031\000\025\000\019\000\015\000\032\000\000\000\
\000\000\000\000\007\000\000\000\249\255"

let yytablesize = 64
let yytable = "\067\000\
\026\000\007\000\003\000\047\000\001\000\062\000\068\000\070\000\
\048\000\008\000\063\000\012\000\071\000\027\000\004\000\011\000\
\069\000\035\000\036\000\054\000\055\000\013\000\010\000\015\000\
\017\000\019\000\016\000\020\000\022\000\023\000\025\000\030\000\
\029\000\032\000\042\000\040\000\031\000\037\000\053\000\061\000\
\039\000\044\000\059\000\043\000\051\000\047\000\056\000\057\000\
\076\000\064\000\060\000\075\000\009\000\077\000\078\000\034\000\
\072\000\073\000\041\000\046\000\052\000\058\000\038\000\074\000"

let yycheck = "\004\001\
\002\001\002\001\005\001\010\001\001\000\011\001\011\001\011\001\
\015\001\010\001\016\001\001\001\016\001\015\001\017\001\012\001\
\021\001\015\001\016\001\015\001\016\001\006\001\017\001\011\001\
\007\001\002\001\020\001\014\001\020\001\008\001\012\001\002\001\
\018\001\009\001\002\001\013\001\020\001\018\001\002\001\002\001\
\020\001\014\001\004\001\018\001\018\001\010\001\013\001\016\001\
\004\001\010\001\016\001\021\001\004\000\011\001\011\001\025\000\
\016\001\016\001\034\000\041\000\046\000\055\000\031\000\071\000"

let yynames_const = "\
  AUTOMATE\000\
  ETAT\000\
  INIT\000\
  FIN\000\
  TRANS\000\
  LPAR\000\
  RPAR\000\
  LACCO\000\
  RACCO\000\
  LCRO\000\
  RCRO\000\
  VIRG\000\
  SEMISEMI\000\
  SEMI\000\
  LET\000\
  DPTS\000\
  ARROW\000\
  "

let yynames_block = "\
  INT\000\
  IDENT\000\
  STRING\000\
  CHAR\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'descrp) in
    Obj.repr(
# 38 "pcfparse.mly"
                      ( _1 )
# 168 "pcfparse.ml"
               : Pcfast.descrp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Pcfast.descrp) in
    Obj.repr(
# 39 "pcfparse.mly"
                    ( _2 )
# 175 "pcfparse.ml"
               : Pcfast.descrp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'etat_list) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : 'etat_init) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'etat_final) in
    let _7 = (Parsing.peek_val __caml_parser_env 1 : 'trans_list) in
    Obj.repr(
# 46 "pcfparse.mly"
         ( 
          {
          n_pile = 0;
          name = _2;
          etat_list = _4;
          etat_init = _5;
          etat_final = _6;
          transition_list = _7;  
          etat_map = []; 
          }     
         )
# 196 "pcfparse.ml"
               : 'descrp))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 8 : int) in
    let _5 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _7 = (Parsing.peek_val __caml_parser_env 4 : 'etat_list) in
    let _8 = (Parsing.peek_val __caml_parser_env 3 : 'etat_init) in
    let _9 = (Parsing.peek_val __caml_parser_env 2 : 'etat_final) in
    let _10 = (Parsing.peek_val __caml_parser_env 1 : 'trans_list) in
    Obj.repr(
# 58 "pcfparse.mly"
         ( 
          {
          n_pile = _3;
          name = _5;
          etat_list = _7;
          etat_init = _8;
          etat_final = _9;
          transition_list = _10;  
          etat_map = []; 
          }     
         )
# 218 "pcfparse.ml"
               : 'descrp))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'list_etat) in
    Obj.repr(
# 70 "pcfparse.mly"
                           (_3)
# 225 "pcfparse.ml"
               : 'etat_list))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'list_trans) in
    Obj.repr(
# 72 "pcfparse.mly"
                             (_3)
# 232 "pcfparse.ml"
               : 'trans_list))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 74 "pcfparse.mly"
                       (_3)
# 239 "pcfparse.ml"
               : 'etat_init))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'list_etat) in
    Obj.repr(
# 76 "pcfparse.mly"
                          (_3)
# 246 "pcfparse.ml"
               : 'etat_final))
; (fun __caml_parser_env ->
    Obj.repr(
# 79 "pcfparse.mly"
              ( [] )
# 252 "pcfparse.ml"
               : 'list_etat))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'list_of_etat) in
    Obj.repr(
# 80 "pcfparse.mly"
                           ( _2 )
# 259 "pcfparse.ml"
               : 'list_etat))
; (fun __caml_parser_env ->
    Obj.repr(
# 83 "pcfparse.mly"
              ( [] )
# 265 "pcfparse.ml"
               : 'list_trans))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'list_of_trans) in
    Obj.repr(
# 84 "pcfparse.mly"
                            ( _2 )
# 272 "pcfparse.ml"
               : 'list_trans))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 87 "pcfparse.mly"
          ( [_1] )
# 279 "pcfparse.ml"
               : 'list_of_etat))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'list_of_etat) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 88 "pcfparse.mly"
                            ( _1 @ [_3] )
# 287 "pcfparse.ml"
               : 'list_of_etat))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'transition) in
    Obj.repr(
# 91 "pcfparse.mly"
                ([_1])
# 294 "pcfparse.ml"
               : 'list_of_trans))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'list_of_trans) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'transition) in
    Obj.repr(
# 92 "pcfparse.mly"
                                  ( _1 @ [_3] )
# 302 "pcfparse.ml"
               : 'list_of_trans))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : char) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 95 "pcfparse.mly"
                                         (
    {
      etat_from = _2;
      etat_to = _6;
      action = _4;
      pile = [];
    }
  )
# 318 "pcfparse.ml"
               : 'transition))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 7 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 5 : char) in
    let _6 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _8 = (Parsing.peek_val __caml_parser_env 1 : 'list_of_pile_actions) in
    Obj.repr(
# 103 "pcfparse.mly"
                                                                   (
    {
      etat_from = _2;
      etat_to = _6;
      action = _4;
      pile = _8;
    }
  )
# 335 "pcfparse.ml"
               : 'transition))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'pile_action) in
    Obj.repr(
# 113 "pcfparse.mly"
                 ([_1])
# 342 "pcfparse.ml"
               : 'list_of_pile_actions))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'list_of_pile_actions) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'pile_action) in
    Obj.repr(
# 114 "pcfparse.mly"
                                          ( _1 @ [_3] )
# 350 "pcfparse.ml"
               : 'list_of_pile_actions))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : char) in
    Obj.repr(
# 117 "pcfparse.mly"
                              (Action(_2, false))
# 357 "pcfparse.ml"
               : 'pile_action))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 1 : char) in
    Obj.repr(
# 118 "pcfparse.mly"
                              (Action(_4, true))
# 364 "pcfparse.ml"
               : 'pile_action))
; (fun __caml_parser_env ->
    Obj.repr(
# 119 "pcfparse.mly"
              (None)
# 370 "pcfparse.ml"
               : 'pile_action))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Pcfast.descrp)
