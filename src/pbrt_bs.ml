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

let int32 json record_name field_name =
  match Js_json.classify json with
  | Js_json.JSONString v -> Int32.of_string v
  | Js_json.JSONNumber v -> Int32.of_float v
  | Js_json.JSONNull -> 0l
  | _ -> E.unexpected_json_type record_name field_name

let int32_wrapped json record_name field_name =
  match Js_json.classify json with
  | Js_json.JSONString v -> Some(Int32.of_string v)
  | Js_json.JSONNumber v -> Some(Int32.of_float v)
  | Js_json.JSONNull -> None
  | _ -> E.unexpected_json_type record_name field_name

let int64 json record_name field_name =
  match Js_json.classify json with
  | Js_json.JSONString v -> Int64.of_string v
  | Js_json.JSONNumber v -> Int64.of_float v
  | Js_json.JSONNull -> 0L
  | _ -> E.unexpected_json_type record_name field_name

let int64_wrapped json record_name field_name =
  match Js_json.classify json with
  | Js_json.JSONString v -> Some (Int64.of_string v)
  | Js_json.JSONNumber v -> Some (Int64.of_float v)
  | Js_json.JSONNull -> None
  | _ -> E.unexpected_json_type record_name field_name

let float json record_name field_name =
  match Js_json.classify json with
  | Js_json.JSONString v -> float_of_string v
  | Js_json.JSONNumber v -> v
  | Js_json.JSONNull -> 0.0
  | _ -> E.unexpected_json_type record_name field_name

let float_wrapped json record_name field_name =
  match Js_json.classify json with
  | Js_json.JSONString v -> Some (float_of_string v)
  | Js_json.JSONNumber v -> Some v
  | Js_json.JSONNull -> None
  | _ -> E.unexpected_json_type record_name field_name

let int json record_name field_name =
  match Js_json.classify json with
  | Js_json.JSONString v -> int_of_string v
  | Js_json.JSONNumber v -> int_of_float v
  | Js_json.JSONNull -> 0
  | _ -> E.unexpected_json_type record_name field_name

let bool json record_name field_name =
  match Js_json.classify json with
  | Js_json.JSONTrue -> true
  | Js_json.JSONFalse -> false
  | Js_json.JSONNull -> false
  | _ -> E.unexpected_json_type record_name field_name

let bool_wrapped json record_name field_name =
  match Js_json.classify json with
  | Js_json.JSONTrue -> Some true
  | Js_json.JSONFalse -> Some false
  | Js_json.JSONNull -> None
  | _ -> E.unexpected_json_type record_name field_name

let string json record_name field_name =
  match Js_json.classify json with
  | Js_json.JSONString v -> v
  | Js_json.JSONNull -> ""
  | _ -> E.unexpected_json_type record_name field_name

let string_wrapped json record_name field_name =
  match Js_json.classify json with
  | Js_json.JSONString v -> Some v
  | Js_json.JSONNull -> None
  | _ -> E.unexpected_json_type record_name field_name

let bytes _ record_name field_name =
  E.unexpected_json_type record_name field_name

let object_ json record_name field_name =
  match Js_json.classify json with
  | Js_json.JSONObject v -> v
  | Js_json.JSONNull -> Js_dict.empty ()
  | _ -> E.unexpected_json_type record_name field_name

let array_ json record_name field_name =
  match Js_json.classify json with
  | Js_json.JSONArray v -> v
  | Js_json.JSONNull -> [||]
  | _ -> E.unexpected_json_type record_name field_name
