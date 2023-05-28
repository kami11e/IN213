(* Ce fichier contient la d�finition du type OCaml des arbres de
 * syntaxe abstraite du langage, ainsi qu'un imprimeur des phrases
 * du langage.
*)
type pileAction=
  | None
  | Action of char * bool     
;;
(* true:empiler
  false:dépiler *)
type transition={
  etat_from:string;
  etat_to:string;
  action:char;
  pile: pileAction list;
}
;;
type descrp ={
  n_pile: int;
  name: string;
  etat_list: string list;
  etat_init:string;
  etat_final:string list;
  transition_list:transition list;
  mutable etat_map: (int*string) list;
}
;;
  (* | EInt of int                                 1, 2, 3
  (* | EBool of bool                               true, false *)
  | EString of string                           (* "hello" *)
  | EIdent of string                            (* x, toto, fact *)
(* and etat =  *)
  | EEtat of string
(* and trans =  *)
  | ETrans of (int*int*string)
(* and etatlist =  *)
  | EExprList of descrp list
  | EAuto of (string * int* int* descrp * descrp) *)



(* Extrait les parametres d'une fonction anonyme
          (fun x1 -> fun x2 -> ... -> e)
   et produit
          ([x1; x2; ...], e)
 *)
(* let params_body e =
  let rec un_body params descrp = match descrp with
  | EFun( p, e) -> un_body (p::params) e
  | e -> (List.rev params, e) in
  un_body [] e
;; *)


(* Note : dans le printf d'OCaml, le format %a
   correspond a 2 arguments consecutifs :
        - une fonction d'impression de type (out_channel -> 'a -> unit)
        - un argument a imprimer, de type 'a
   Voir le cas EApp ci-dessous.
 *)
let rec print_etat_list oc = function
  | [] -> Printf.fprintf oc ""
  | etat::reste -> Printf.fprintf oc "%s %a" etat print_etat_list reste
;;

let print_trans_p_action oc = function
  | None -> Printf.fprintf oc "( - )"
  | Action(ch, true) -> Printf.fprintf oc "(->%c)" ch
  | Action(ch, false)-> Printf.fprintf oc "(%c->)" ch
;;

let rec rec_print_trans_lst_p_action oc = function
  | ([], _) -> Printf.fprintf oc ""
  | (p::px, i) -> Printf.fprintf oc "Pile[%d] : %a  \t%a" i print_trans_p_action p rec_print_trans_lst_p_action (px, (i+1))
;;
let print_trans_lst_p_action oc trans = 
  rec_print_trans_lst_p_action oc (trans.pile, 0)
;;
  
let print_trans oc trans = 
  Printf.fprintf oc "(%s)-[%c]->(%s)\t%a" trans.etat_from trans.action trans.etat_to print_trans_lst_p_action trans
;;

let rec print_trans_list oc = function
  | [] -> Printf.fprintf oc ""
  | trans::reste -> Printf.fprintf oc "\t%a\n%a" print_trans trans print_trans_list reste
;;

let print oc automate = 
  Printf.fprintf oc "\n  nom : %s\n  nombre de piles : %d\n  liste d'états : %a\n  état initial : %s\n  état final : %a\n  liste de transitions : \n%a\n" automate.name automate.n_pile print_etat_list automate.etat_list automate.etat_init print_etat_list automate.etat_list print_trans_list automate.transition_list
;;

(* let rec print oc = function
  | EInt n -> Printf.fprintf oc "%d" n
  (* | EBool b -> Printf.fprintf oc "%s" (if b then "true" else "false") *)
  | EIdent s -> Printf.fprintf oc "%s" s
  | EString s -> Printf.fprintf oc "\"%s\"" s
  | EEtat s -> Printf.fprintf oc "\"%s\"" s
  | ETrans (n1, n2, symbol) -> Printf.fprintf oc "Etat[%d] -[%s]->Etat[%d]" n1 symbol n2
  | EExprList el -> Printf.fprintf oc "%a" (fun oc -> List.iter (fun s -> Printf.fprintf oc "%a " print s)) el
    (* ( match el with
    | elem::reste -> Printf.fprintf oc "%a %a" print elem print reste
    | [] -> Printf.fprintf oc ""
  ) *)
  (* | ETranslist tl -> (
    match tl with
    | elem::reste -> Printf.fprintf oc "%s\n%s" print oc elem print oc reste
    | [] -> Printf.fprintf oc "\n"
  ) *)
  | EAuto (nom, init, fin, etats, transitions) -> Printf.fprintf oc "Automate[%s]:\nInit:%d\nFin:%d\nEtats:\n%aTransitions:\n%a" nom init fin print etats print transitions
  (* | EApp (e1, e2) -> Printf.fprintf oc "(%a %a)" print e1 print e2 *)
  (* | ELet (f, e1, e2) ->
      let (params, e) = params_body e1 in
      Printf.fprintf oc "(let %s %a= %a in %a)"
        f
        (fun oc -> List.iter (fun s -> Printf.fprintf oc "%s " s)) params
        print e
        print e2
  | ELetrec (f, x, e1, e2) ->
      let (params, e) = params_body e1 in
      Printf.fprintf oc "(let rec %s %s %a= %a in %a)"
        f x
        (fun oc -> List.iter (fun s -> Printf.fprintf oc "%s " s)) params
        print e
        print e2
  | EFun (x, e) -> Printf.fprintf oc "(fun %s -> %a)"  x print e
  | EIf (test, e1, e2) ->
      Printf.fprintf oc "(if %a then %a else %a)" print test print e1 print e2
  | EBinop (op,e1,e2) ->
      Printf.fprintf oc "(%a %s %a)" print e1 op print e2
  | EMonop (op,e) -> Printf.fprintf oc "%s%a" op print e *)
;; *)
