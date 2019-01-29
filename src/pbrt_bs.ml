module E = struct

  type error = 
    | Unexpected_json_type of string * string  
    | Malformed_variant of string  

  exception Failure of error 

  let unexpected_json_type record_name field_name = 
    raise (Failure (Unexpected_json_type (record_name, field_name)))

  let malformed_variant variant_name = 
    raise (Failure (Malformed_variant variant_name)) 

  let string_of_error = function
    | Unexpected_json_type (record_name, field_name) -> 
      Printf.sprintf "Unexpected json type (record name:%s, field_name:%s)"
        record_name field_name 
    | Malformed_variant variant_name ->
      Printf.sprintf "Malformed variant (variant name: %s)" variant_name

  let () =
    Printexc.register_printer (fun exn ->
      match exn with
      | Failure e -> Some (string_of_error e)
      | _ -> None
      )
  
end 

let int32_ : 
  Js_json.tagged_t -> string -> string -> int32 
  = fun ty record_name field_name -> 

  match ty with
  | JSONString v -> Int32.of_string v 
  | JSONNumber v -> Int32.of_float v 
  | JSONNull -> 0l 
  | _ -> E.unexpected_json_type record_name field_name  

let int32 json record_name field_name = 
  int32_ (Js_json.classify json) record_name field_name 

let int64_ : 
  Js_json.tagged_t -> string -> string -> int64 
  = fun ty record_name field_name -> 

  match ty with
  | JSONString v -> Int64.of_string v 
  | JSONNumber v -> Int64.of_float v 
  | JSONNull -> 0L
  | _ -> E.unexpected_json_type record_name field_name  

let int64 json record_name field_name = 
  int64_ (Js_json.classify json) record_name field_name 

let float_ : 
  Js_json.tagged_t -> string -> string -> float 
  = fun ty record_name field_name -> 

  match ty with
  | JSONString v -> float_of_string v 
  | JSONNumber v -> v 
  | JSONNull -> 0.0
  | _ -> E.unexpected_json_type record_name field_name  

let float json record_name field_name = 
  float_ (Js_json.classify json) record_name field_name 

let int_ : 
  Js_json.tagged_t -> string -> string -> int 
  = fun ty record_name field_name -> 

  match ty with
  | JSONString v -> int_of_string v 
  | JSONNumber v -> int_of_float v 
  | JSONNull -> 0
  | _ -> E.unexpected_json_type record_name field_name  

let int json record_name field_name = 
  int_ (Js_json.classify json) record_name field_name 

let bool_ : 
  Js_json.tagged_t -> string -> string -> bool 
  = fun ty record_name field_name -> 

  match ty with
  | JSONTrue -> true
  | JSONFalse -> false
  | JSONNull -> false
  | _ -> E.unexpected_json_type record_name field_name  

let bool json record_name field_name = 
  bool_ (Js_json.classify json) record_name field_name 

let string_ : 
  Js_json.tagged_t -> string -> string -> string
  = fun ty record_name field_name -> 

  match ty with
  | JSONString v -> v 
  | JSONNull -> ""
  | _ -> E.unexpected_json_type record_name field_name

let string json record_name field_name = 
  string_ (Js_json.classify json) record_name field_name

let bytes _ record_name field_name = 
  E.unexpected_json_type record_name field_name

let object__: 
  Js_json.tagged_t -> string -> string -> Js_json.t Js_dict.t
  = fun ty record_name field_name -> 

  match ty with
  | JSONObject v -> v 
  | JSONNull -> Js_dict.empty () 
  | _ -> E.unexpected_json_type record_name field_name

let object_ json record_name field_name = 
  object__ (Js_json.classify json) record_name field_name

let array__: 
  Js_json.tagged_t -> string -> string -> Js_json.t array
  = fun ty record_name field_name -> 

  match ty with
  | JSONArray v -> v 
  | JSONNull -> [||]
  | _ -> E.unexpected_json_type record_name field_name
  
let array_ json record_name field_name = 
  array__ (Js_json.classify json) record_name field_name

