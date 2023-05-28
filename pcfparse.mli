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

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Pcfast.descrp
