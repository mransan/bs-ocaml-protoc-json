module E =
  struct
    type error =
      | Unexpected_json_type of string* string
      | Malformed_variant of string
    exception Failure of error
    let unexpected_json_type record_name field_name =
      raise (Failure (Unexpected_json_type (record_name, field_name)))
    let malformed_variant variant_name =
      raise (Failure (Malformed_variant variant_name))
    let string_of_error =
      function
      | Unexpected_json_type (record_name,field_name) ->
          Printf.sprintf
            "Unexpected json type (record name:%s, field_name:%s)"
            record_name field_name
      | Malformed_variant variant_name ->
          Printf.sprintf "Malformed variant (variant name: %s)" variant_name
    let () =
      Printexc.register_printer
        (fun exn  ->
           match exn with | Failure e -> Some (string_of_error e) | _ -> None)
  end
let int32_: Js.Json.tagged_t -> string -> string -> int32 =
  (fun tag  ->
     fun record_name  ->
       fun field_name  ->
         match tag with
         | Js.Json.JSONString v -> Int32.of_string v
         | Js.Json.JSONNumber v -> Int32.of_float v
         | Js.Json.JSONNull  -> 0l
         | _ -> E.unexpected_json_type record_name field_name : Js.Json.tagged_t
                                                                  ->
                                                                  string ->
                                                                    string ->
                                                                    int32)
let int32 json record_name field_name =
  int32_ (Js.Json.classify json) record_name field_name
let int64_: Js.Json.tagged_t -> string -> string -> int64 =
  (fun tag  ->
     fun record_name  ->
       fun field_name  ->
         match tag with
         | Js.Json.JSONString v -> Int64.of_string v
         | Js.Json.JSONNumber v -> Int64.of_float v
         | Js.Json.JSONNull  -> 0L
         | _ -> E.unexpected_json_type record_name field_name : Js.Json.tagged_t
                                                                  ->
                                                                  string ->
                                                                    string ->
                                                                    int64)
let int64 json record_name field_name =
  int64_ (Js.Json.classify json) record_name field_name
let float_: Js.Json.tagged_t -> string -> string -> float =
  (fun tag  ->
     fun record_name  ->
       fun field_name  ->
         match tag with
         | Js.Json.JSONString v -> float_of_string v
         | Js.Json.JSONNumber v -> v
         | Js.Json.JSONNull  -> 0.0
         | _ -> E.unexpected_json_type record_name field_name : Js.Json.tagged_t
                                                                  ->
                                                                  string ->
                                                                    string ->
                                                                    float)
let float json record_name field_name =
  float_ (Js.Json.classify json) record_name field_name
let int_: Js.Json.tagged_t -> string -> string -> int =
  (fun tag  ->
     fun record_name  ->
       fun field_name  ->
         match tag with
         | Js.Json.JSONString v -> int_of_string v
         | Js.Json.JSONNumber v -> int_of_float v
         | Js.Json.JSONNull  -> 0
         | _ -> E.unexpected_json_type record_name field_name : Js.Json.tagged_t
                                                                  ->
                                                                  string ->
                                                                    string ->
                                                                    int)
let int json record_name field_name =
  int_ (Js.Json.classify json) record_name field_name
let bool_: Js.Json.tagged_t -> string -> string -> bool =
  (fun tag  ->
     fun record_name  ->
       fun field_name  ->
         match tag with
         | Js.Json.JSONTrue  -> true
         | Js.Json.JSONFalse  -> false
         | Js.Json.JSONNull  -> false
         | _ -> E.unexpected_json_type record_name field_name : Js.Json.tagged_t
                                                                  ->
                                                                  string ->
                                                                    string ->
                                                                    bool)
let bool json record_name field_name =
  bool_ (Js.Json.classify json) record_name field_name
let string_: Js.Json.tagged_t -> string -> string -> string =
  (fun tag  ->
     fun record_name  ->
       fun field_name  ->
         match tag with
         | Js.Json.JSONString v -> v
         | Js.Json.JSONNull  -> ""
         | _ -> E.unexpected_json_type record_name field_name : Js.Json.tagged_t
                                                                  ->
                                                                  string ->
                                                                    string ->
                                                                    string)
let string json record_name field_name =
  string_ (Js.Json.classify json) record_name field_name
let bytes _ record_name field_name =
  E.unexpected_json_type record_name field_name
let object__: Js.Json.tagged_t -> string -> string -> Js_json.t Js_dict.t =
  fun (type a) ->
  (fun tag  ->
     fun record_name  ->
       fun field_name  ->
         match tag with
         | Js.Json.JSONObject v -> v
         | Js.Json.JSONNull  -> Js_dict.empty ()
         | _ -> E.unexpected_json_type record_name field_name : Js.Json.tagged_t
                                                                  ->
                                                                  string ->
                                                                    string ->
                                                                    Js_json.t
                                                                    Js_dict.t)
let object_ json record_name field_name =
  object__ (Js.Json.classify json) record_name field_name
let array__: Js.Json.tagged_t -> string -> string -> Js_json.t array =
  (fun tag  ->
     fun record_name  ->
       fun field_name  ->
         match tag with
         | Js.Json.JSONArray v -> v
         | Js.Json.JSONNull  -> [||]
         | _ -> E.unexpected_json_type record_name field_name : Js.Json.tagged_t
                                                                  ->
                                                                  string ->
                                                                    string ->
                                                                    Js_json.t
                                                                    array)
let array_ json record_name field_name =
  array__ (Js.Json.classify json) record_name field_name
