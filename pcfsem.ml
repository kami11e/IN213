open Pcfast;;

let table = [];;

let rec num_trans_from_list transition_list etat num = 
  (* let a = Printf.printf "num_trans_from_list, num=%d\n" num in  *)
  match transition_list with
  | [] -> num
  | elem::reste -> if elem.etat_from=etat then num_trans_from_list reste etat (num+1)
  else num_trans_from_list reste etat num;;

(* let rec make_list n elem liste = 
  if n==0 then list 
  else if n>0 then make_list (n-1) elem elem::liste
  else raise (Failure ("List size should not be negative."));;

let createList n elem = 
  make_list n elem [];;   *)

let num_trans_from automate etat = 
  (* let a = Printf.printf "num_trans_from\n" in *)
  num_trans_from_list automate.transition_list etat 0;;

let liste_trans_from automate etat = 
  let rec read_transition_liste trans_list result = match trans_list with
    | elem::reste -> let acc = if elem.etat_from=etat then [elem]  else [] in let result = result@acc in read_transition_liste reste result
    | [] -> result
  in read_transition_liste automate.transition_list [];;

(* let create_table automate =  *)
let rec get_index_list list elem id = 
  (* let a = Printf.printf "get_index_list\n" in  *)
  match list with
| fst::reste -> (
  (* let a = Printf.printf "fst=%s, elem=%s, id=%d\n" fst elem id in *)
  if elem =fst then id else get_index_list reste elem (id+1)
)
| [] -> raise (Failure ("Searched element not in list"));;
let get_index_etat automate elem =
  get_index_list automate.etat_list elem 0;;

let get_index_init automate =
  (* let a = Printf.printf "get_index_init\n" in *)
  get_index_list automate.etat_list automate.etat_init 0;;
let get_index_final automate = 
  (* let a = Printf.printf "get_index_final\n" in *)
  List.map (fun x -> get_index_list automate.etat_list x 0) automate.etat_final;;

(* let get_index_final automate = 
  get_index_fi *)
let rec sum_of_list liste num = match (liste, num) with
| (_, 0) -> 0
| (elem::reste, n) -> elem + sum_of_list reste (n-1)
| ([], n) -> raise (Failure ("List index out of range in sum_of_list"));;

let accumul liste =
  (* let a = Printf.printf "accumul\n" in *)
  let rec somme_accumul liste acc =
    match liste with
    | [elem] -> List.rev (acc)
    | elem::reste -> somme_accumul reste ((List.hd acc + elem)::acc)
    | [] -> []
  in somme_accumul liste [0]
;;

let filtrer_par_indices liste idx =
  List.map (fun x -> List.nth liste x) idx;;

let compile_etat_init table automate etat_idx_in_table = 
  (* let a = Printf.printf "compile_etat_init\n" in *)
  let init_id = get_index_init automate in
  let etat_init_idx_in_table = List.nth etat_idx_in_table init_id in
  table @ [etat_init_idx_in_table];;
let compile_etat_final table nb_final automate etat_idx_in_table = 
  (* let a = Printf.printf "compile_etat_final\n" in *)
  let final_id = get_index_final automate in
  let etat_final_idx_in_table = filtrer_par_indices etat_idx_in_table final_id in
  table @ [nb_final] @ etat_final_idx_in_table;;

let get_idx_in_table automate etat = 
  let n_pile = automate.n_pile in
  let nb_etat_final = List.length automate.etat_final in
  let etat_num_trans = List.map (fun x ->(2+2*n_pile)*(num_trans_from automate x)+1) automate.etat_list in
  let accumulated_num_trans = accumul etat_num_trans in
  let etat_idx_in_table = List.map (fun x -> x + nb_etat_final + 3) accumulated_num_trans in
  let etat_id = get_index_etat automate etat in
  List.nth etat_idx_in_table etat_id;;


let interlace list1 list2 = 
  let rec merge_lists list1 list2 flag  =
    match list1, list2, flag with
    | [], _ ,_-> list2
    | _, [] , _-> list1
    | x::rx, y::ry, true -> x::(merge_lists rx list2 false)
    | x::rx, y::ry, false -> y::(merge_lists list1 ry true)
  in merge_lists list1 list2 true
;;


let compile_transtions_etat table automate etat= 
  (* let a = Printf.printf "compile_transtions_etat\n" in *)
  let n_pile = automate.n_pile in
  let num_trans = num_trans_from automate etat in
  let liste_trans = liste_trans_from automate etat in
  (* let liste_action = List.map (fun x -> Char.code x.action) liste_trans in
  let liste_to = List.map (fun x -> get_idx_in_table automate x.etat_to)  liste_trans in
  let liste_merged = interlace liste_action liste_to in *)
  let read_1_trans n_pile x = 
    let action = Char.code x.action in
    let etat_to = get_idx_in_table automate x.etat_to in
    let liste_pile_action = 
      List.map (
        fun (act:pileAction) -> match act with 
          | Action(ch, true) -> 1
          | Action(ch, false) -> -1
          | None -> 0
      ) x.pile in
    let liste_pile_char = 
      List.map (
        fun act -> match act with 
          | None -> 0
          | Action(ch, _) -> Char.code ch
      ) x.pile in
    [action] @[etat_to] @ (interlace liste_pile_char liste_pile_action)
  in
  let rec read_n_trans liste_trans acc= match liste_trans with
    | [] -> acc
    | transition::reste -> (
      let one_transition = read_1_trans n_pile transition in
      read_n_trans reste (acc @ one_transition)
    )
  in
  read_n_trans liste_trans ( table @ [num_trans] )
  (* table @ [num_trans] @liste_merged;; *)
;;
let compile_all_etat_trans table automate = 
  let rec compile_1_etat table e_list = match e_list with
  | [] -> table
  | elem::reste -> 
    let table = compile_transtions_etat table automate elem in
    compile_1_etat table reste
  in
  compile_1_etat table automate.etat_list;;

let print_table oc liste = 
  let rec print_table_0 oc = function
    | [elem] -> Printf.fprintf oc "%d" elem
    | elem::reste -> Printf.fprintf oc "%d, %a" elem print_table_0  reste
    | [] ->  Printf.fprintf oc ""
  in
  (* let a = Printf.printf "print_table\n" in *)
  print_table_0 oc liste;; 

let compile automate = 
  let n_pile = automate.n_pile in
  let nb_etat_final = List.length automate.etat_final in
  let etat_num_trans = List.map (fun x -> (2+n_pile*2)*(num_trans_from automate x)+1) automate.etat_list in
  (* let a = print_table stdout etat_num_trans in *)
  let accumulated_num_trans = accumul etat_num_trans in
  (* let a = print_table stdout accumulated_num_trans in *)
  let etat_idx_in_table = List.map (fun x -> x + nb_etat_final + 3) accumulated_num_trans in
  (* let a = print_table stdout etat_idx_in_table in *)
  let table = [n_pile] in
  let table = compile_etat_init table automate etat_idx_in_table in
  let table = compile_etat_final table nb_etat_final automate etat_idx_in_table in
  (* let a = Printf.printf "compile\n" in *)
  (* let table = compile_transtions_etat table automate automate.etat_init in *)
  let table = compile_all_etat_trans table automate in
  let _ =  automate.etat_map <- (List.combine etat_idx_in_table automate.etat_list) in
  (table, automate.etat_map);;
  




let test str = 
  Printf.printf "%s" str
;;




