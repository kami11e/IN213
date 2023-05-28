let version = "0.01" ;;
(* open Pcfauto;; *)

let usage () =
  let _ =
    Printf.eprintf
      "Usage: %s [file]\n\tRead a PCF program from file (default is stdin)\n%!"
    Sys.argv.(0) in
  exit 1
;;
exception Exception of string;;
type pile = {
  mutable content: char list;
}
;;
type mypiles = {
  n_pile: int;
  piles: pile array;
}
;;
let create_pile () =
  { content = [] }
;;
let pile_is_vide pile = 
  if (List.length pile.content)=0 then true
  else false
;;
let is_all_piles_vide piles = 
  let rec rec_is_all_piles_vide piles i= 
    let n = Array.length piles in
    if i=n then true
    else if (pile_is_vide piles.(i))=false then false
    else rec_is_all_piles_vide piles (i+1)
  in
  rec_is_all_piles_vide piles 0 
;;
  
let create_mypiles n_pile =
  let piles = Array.init n_pile (fun _ -> create_pile ()) in
  { n_pile = n_pile; piles = piles }
;;
let pop_pile p =
  match p.content with
  | [] -> None
  | x :: xs ->
    p.content <- xs;
    Some x
;;
let push_pile p c =
  p.content <- c :: p.content
;;
let print_pile p id = 
  let printf_char_list_reverse format id char_list =
    let reversed_str = List.rev char_list |> List.map Char.escaped |> String.concat "" in
    Printf.printf format id reversed_str
  in 
  if (List.length p.content)=0 then Printf.printf "Pile %d : %s\t" id "Vide"
  else printf_char_list_reverse "Pile %d : %s\t" id p.content
;;
let print_all_piles parray n = 
  let rec print_first_pile i =
    if i=n then ()
    else 
      let _ = print_pile parray.(i) i in
      print_first_pile (i+1)
  in 
  print_first_pile 0
;;
let find_element_index element lst =
  let rec find_index element lst index =
    match lst with
    | [] -> -1
    | hd :: tl ->
      if hd = element then index
      else find_index element tl (index + 1)
  in
  find_index element lst 0
;;
let print_transition map prec c curr =
  let from_etat = List.assoc prec map in
  let to_etat = List.assoc curr map in
  Printf.printf "etat[%s] --[%c]--> etat[%s]\n" from_etat c to_etat
;;
let process_actions_pile n_pile lst p= 
  let rec process_all_piles n i lst= 
    (* let _ = Pcfsem.print_table stdout lst in *)
    if(i=n)then ()
    else match lst with
      |[] -> ()
      |ch::0::reste -> (
        let _ = print_pile p.(i) i in
        process_all_piles n (i+1) reste
      )
      |ch::1::reste -> 
        let _ = push_pile p.(i) (Char.chr ch) in
        let _ = print_pile p.(i) i in
        process_all_piles n (i+1) reste
      |ch::(-1)::reste ->
        let pop = pop_pile p.(i) in
        if Some(Char.chr ch)=pop then 
          let _ = print_pile p.(i) i in
          process_all_piles n (i+1) reste
        else 
          let _ = Printf.printf "\n\t" in 
          raise (Failure(Printf.sprintf "le caractère à dépiler ('%c') dans la pile %d n'est pas cohérent avec le contenu de la pile..." (Char.chr ch) i))
      | _ -> raise (Failure("length of actions for piles incorrect ..."))
  in
  (* let _ = process_all_piles n_pile 0 lst in *)
  process_all_piles n_pile 0 lst
  (* Printf.printf "\n" *)
;;


let rec process_input (map, t, p, curr, fin_list, nom, v) =
  let n_pile = List.nth t 0 in
  let _ = if v=2 then (
    let _ = Printf.printf "\n Liste d'actions possible : " in 
    let action_list = List.init (List.nth t curr) (fun i->(List.nth t (curr+(2+2*n_pile)*i+1))) in
    List.iter (fun c -> print_char (Char.chr c); print_char ' ') action_list
  )
  in
  let _ = (
    if v=1||v=2 then Printf.printf "\n Donnez une chaîne de caractères...\n>"
    else if v=0 then Printf.printf "\n>"
  )
  in
  let read_chars acc =
    let input = read_line () in
    if input = "" then
      None
      (* [] *)
      (* if (find_element_index curr fin_list)>=0 then 
        Printf.printf "Fin d'exécution\n"
        raise (exception ("Fin d'exécution"))
      else
        let _= Printf.printf "Erreur: Ce n'est pas un état final\n" in
        raise (Failure ("Erreur état final")) *)
    else
      (* let char_list = List.init (String.length input) (fun i -> input.[i]) in
      read_chars (acc @ char_list) *)
      Some (List.init (String.length input) (fun i -> input.[i]) )
  in
  let rec process_actions t curr chars =
    match chars with 
    | None -> 
      let curridx = find_element_index curr fin_list in
      (* let _ = print_int curr in *)
      if curridx>=0 then 
        if (is_all_piles_vide p)=true then (
          let _ = Printf.printf "\nFin d'exécution\n" in
          exit 0
        )else Printf.printf "\tErreur : Toutes les piles ne sont pas vides.\n"
        
        (* raise (Exception ("Fin d'exécution\n")) *)
      else
        Printf.printf "\tErreur : On n'est pas dans un état final.\n"
        (* let _= Printf.printf "Erreur: Ce n'est pas un état final\n" in
        raise (Failure ("Erreur état final"))    *)
    | Some [] -> process_input (map, t, p, curr, fin_list, nom, v)
    | Some (c::reste) -> 
      let action_list = List.init (List.nth t curr) (fun i->(List.nth t (curr+(2+2*n_pile)*i+1))) in
      let goto_list = List.init (List.nth t curr) (fun i->(List.nth t (curr+(2+2*n_pile)*i+2))) in
      let action = int_of_char c in
      let aidx = find_element_index action action_list in
      (* let _=Printf.printf "Possible actions= " in *)
      (* let _=List.iter (fun c -> print_int c; print_char ' ') action_list in *)
      (* let _=print_newline () in *)
      if (aidx>=0) then
        let prec = curr in
        let curr = List.nth goto_list aidx in
        (* let _ = print_transition map prec c curr in *)
        let liste_pile_action = List.init (n_pile*2) (fun i->List.nth t (prec + (2+2*n_pile)*aidx + 3 + i)) in
        (* let _ = Printf.printf "List of pile actions: %a" Pcfsem.print_table  liste_pile_action in  *)
        let _ = Printf.printf "[%s] %c -> État \"%s\" \t" nom c (List.assoc curr map) in
        (* let  List.init (List.nth t curr) (fun i->(List.nth t (curr+(2+2*n_pile)*i+2))) in *)
        let _ = process_actions_pile n_pile liste_pile_action p in
        let _ = print_endline "" in
        process_actions t curr (Some reste)
      else
        let _=Printf.printf "\tErreur : action invalide ('%c')\n" c in
        exit 1
        (* raise (Failure("Erreur action invalide\n")) *)
      
  in
  let char_list = read_chars [] in
  (* print_endline "Input characters:"; *)
  process_actions t curr char_list;
  process_input (map, t, p, curr, fin_list, nom, v)
;;

let automate(t, map, nom, v) = 
  let len = List.length t in
  let n_pile = List.nth t 0 in
  let init = List.nth t 1 in
  let curr = init in
  let fin_list = List.init (List.nth t 2) (fun i->(List.nth t (i+3))) in
  (* let _ = List.iter (fun c -> print_int c; print_char ' ') fin_list in *)
  (* let _ = Pcfsem.print_table stdout fin_list in *)
  (* Printf.printf "\nlength of table=%d, nb of pile=%d, init=%d \n" len n_pile init *)
  (* let _ = Printf.printf "\nRunning automate, please enter a character:\n" in *)
  let _ = Printf.printf ">>>>>>>>>>Lancer l'automate [%s]<<<<<<<<<<<\n" nom in
  let p = create_mypiles(n_pile) in
  let _ = Printf.printf "[%s]      État \"%s\" \t" nom (List.assoc curr map) in
  let _ = print_all_piles p.piles n_pile in   
  (* let _ = if v=2 then (
    let _ = Printf.printf "\n Liste d'actions possible : " in 
    let action_list = List.init (List.nth t curr) (fun i->(List.nth t (curr+(2+2*n_pile)*i+1))) in
    List.iter (fun c -> print_char (Char.chr c); print_char ' ') action_list
  )
  in *)
  (* let v = 0 in *)
  process_input(map, t, p.piles, curr, fin_list, nom, v)
;;

let write_int_list_to_file filename int_list =
  let oc = open_out filename in
  List.iter (fun n -> Printf.fprintf oc "%d\n" n) int_list;
  close_out oc
;;
open Stdlib;;
let write_map_to_file filename map =
  let oc = open_out filename in
  List.iter (fun (key, value) -> Printf.fprintf oc "Nom:%s Adresse:%d\n" value key) map;
  close_out oc
;;

let main() =
  let input_channel =
    match Array.length Sys.argv with
      1 -> stdin
    | (2|3|4|5|6) ->
        begin match Sys.argv.(1) with
        |  "-" -> stdin
        | name ->
            begin try open_in name with
              _ -> Printf.eprintf "Opening %s failed\n%!" name; exit 1
            end
        end
    (* | 3 -> 
        begin match Sys.argv.(1) with
        "-" -> stdin
        | name ->
            begin try open_in name with
              _ -> Printf.eprintf "Opening %s failed\n%!" name; exit 1
            end
            match Sys.argv.(2) with
            "-" -> stdin
            | (0|1|2) -> let v = Sys.argv.(2)
            | _ -> Printf.eprintf "Verbosity should be a number in {0,1,2}!"; exit 1
        end *)
    | n -> usage()
  in
  let v =  match Array.length Sys.argv with
  | 1|2 -> 0
  | 3|4|5|6 -> match Sys.argv.(2) with
      | "0" | "1" | "2" as verbos -> int_of_string verbos
      | _ -> Printf.eprintf "Verbosity should be a number in {0,1,2}!"; exit 1
  | _ -> usage()
  in
  let (out, vm, ts) = match Array.length Sys.argv with
  | 1|2|3 -> (0, "", "")
  | 4|5|6 -> match Sys.argv.(3) with
      | "-output"  -> (1, "VM", "TS")
      | _ -> Printf.eprintf "Do you mean -output [VM] [TS]?"; exit 1
  (* | 5 -> match Sys.argv.(3) with
      | "-output"  -> (1, Sys.argv.(4), "TS")
      | _ -> Printf.eprintf "Do you mean -output [VM] [TS]?"; exit 1
  | 6 -> match Sys.argv.(3) with
      | "-output"  -> (1, Sys.argv.(4), Sys.argv.(5))
      | _ -> Printf.eprintf "Do you mean -output [VM] [TS]?"; exit 1 *)
  | n -> usage()
  in
  let (vm, ts) = match Array.length Sys.argv with
  | 1|2|3 -> ("", "")
  | 4 -> ("VM", "TS")
  | 5 -> (Sys.argv.(4), "TS")
  | 6 -> (Sys.argv.(4), Sys.argv.(5))
  (* | 5 -> match Sys.argv.(3) with
      | "-output"  -> (1, Sys.argv.(4), "TS")
      | _ -> Printf.eprintf "Do you mean -output [VM] [TS]?"; exit 1
  | 6 -> match Sys.argv.(3) with
      | "-output"  -> (1, Sys.argv.(4), Sys.argv.(5))
      | _ -> Printf.eprintf "Do you mean -output [VM] [TS]?"; exit 1 *)
  | n -> usage()
  in
  (* let _ = Printf.printf "        Welcome to PCF, version %s\n%!" version in *)
  let lexbuf = Lexing.from_channel input_channel in
  while true do
    try
      let _ = Printf.printf  "> %!" in
      let e = Pcfparse.main Pcflex.lex lexbuf in
      let _ = if(v=1||v=2) then (
        let _ = Printf.printf "Recognized automate: " in
        Pcfast.print stdout e
      )
      in
      (* let _ = Printf.fprintf stdout " =\n%!" in *)
      (* let _ = Pcfsem.test "test" in *)
      (* let _ = Pcfsem.print_table stdout (List.map (fun x -> Pcfsem.num_trans_from e x) e.etat_list) in *)
      let (t, map) = Pcfsem.compile e in
      (* let _ = Pcfsem.print_table stdout t in *)
      (* let _ = Pcfauto.read_line in *)
      let _ = (
        if out=0 then automate(t, map, e.name, v)
        else 
          let _ = write_int_list_to_file vm t in
          write_map_to_file ts map
      )
      in
      (* let _ = automate(t, map, e.name, v) in *)
      Printf.printf "\n%!"
    with
      Pcflex.Eoi -> Printf.printf  "Bye bye.\n%!" ; exit 0
    | Failure msg -> Printf.printf "Erreur: %s\n\n" msg
    | Parsing.Parse_error ->
        let sp = Lexing.lexeme_start_p lexbuf in
        let ep = Lexing.lexeme_end_p lexbuf in
        Format.printf
          "File %S, line %i, characters %i-%i: Syntax error.\n"
          sp.Lexing.pos_fname
          sp.Lexing.pos_lnum
          (sp.Lexing.pos_cnum - sp.Lexing.pos_bol)
          (ep.Lexing.pos_cnum - sp.Lexing.pos_bol)
    | Pcflex.LexError (sp, ep) ->
        Printf.printf
          "File %S, line %i, characters %i-%i: Lexical error.\n"
          sp.Lexing.pos_fname
          sp.Lexing.pos_lnum
          (sp.Lexing.pos_cnum - sp.Lexing.pos_bol)
          (ep.Lexing.pos_cnum - sp.Lexing.pos_bol)
  done
;;

if !Sys.interactive then () else main();;
