(* ------ TEMPORARY UNTIL BS IS UPDATED ------- *)

module Js_dict = struct 
  type 'a t
  type key = string
  external unsafeGet : 'a t -> key -> 'a = "" [@@bs.get_index] 
  external set : 'a t -> key -> 'a -> unit = "" [@@bs.set_index]  
  external keys : 'a t -> string array = "Object.keys" [@@bs.val]
  external empty : unit -> 'a t = "" [@@bs.obj]
end 

module Js_json = struct 
  type t
  
  type _ kind = 
    | String : Js_string.t kind
    | Number : float kind 
    | Object : t Js_dict.t kind 
    | Array : t array kind 
    | Boolean : Js.boolean kind
    | Null : Js_types.null_val kind
  
  let reify_type (type a) (x : 'a) : (a kind * a ) = 
    (if Js.typeof x = "string" then 
      Obj.magic String else
    if Js.typeof x = "number" then 
      Obj.magic Number  else 
    if Js.typeof x = "boolean" then
      (* which one is faster, save [Js.typeof] or not *)
      Obj.magic Boolean else
    if (Obj.magic x) == Js.null then
      (* providing a universal function *)
      Obj.magic Null else 
    if Js_array.isArray x  then 
      Obj.magic Array 
    else 
      Obj.magic Object ), Obj.magic x
  
  let reifyType = reify_type 
  
  external parse : string -> t = "JSON.parse" [@@bs.val]
  (* TODO: more docs when parse error happens or stringify non-stringfy value *)
  
  let null : t = (Obj.magic (Js.null: 'a Js.null) : t)
  
  external string : string -> t = "%identity"
  
  external number : float -> t = "%identity"
  
  external numberOfInt : int -> t = "%identity"
  
  external boolean : Js.boolean -> t = "%identity" 
  
  let boolAsBoolean b = (Js_boolean.to_js_boolean b) |> boolean 
  
  external object_ : t Js_dict.t -> t = "%identity"
  
  external stringArray : string array -> t = "%identity"
  
  external numberArray : float array -> t = "%identity"
  
  external intArray : int array -> t = "%identity"
  
  external booleanArray : Js.boolean array -> t = "%identity"
  
  external objectArray : t Js_dict.t array -> t = "%identity"
  
  external stringify: t -> string = "JSON.stringify" [@@bs.val]
end 

module Decoder = struct 

  type t = {
    dict : Js_json.t Js_dict.t;
    mutable index : int; 
  }

  type value = 
    | String of string 
    | Float of float 
    | Int of int 
    | Object of t 
    | Array_as_array of value array 
    | Bool of bool 
    | Null

  let of_json json = 
    match Js_json.reifyType json with
    | Js_json.Object, dict ->
      Some ({dict; index = 0}) 
    | _ -> None
    
  let of_string s = 
    s |> Js_json.parse |> of_json

  let rec map : type a. a Js_json.kind -> a -> value = fun ty x -> 
    match ty with
    | Js_json.String -> String x
    | Js_json.Number -> Float x
    | Js_json.Boolean -> Bool (Js.to_bool x)
    | Js_json.Null -> Null
    | Js_json.Object -> Object {dict = x; index = 0} 
    | Js_json.Array -> Array_as_array (Array.map (fun e -> 
      let ty, x = Js_json.reifyType e in 
      map ty x
    ) x)

  let key t = 
    let keys = Js_dict.keys t.dict in 
    if t.index >= (Array.length keys) 
    then None
    else 
      let key = keys.(t.index) in 
      let value = 
        let ty, x = Js_json.reifyType (Js_dict.unsafeGet t.dict key) in
        map ty x 
      in
      t.index <- t.index + 1;
      Some (key, value)
end 


module Encoder = struct

  type t = Js_json.t Js_dict.t 

  let empty () : t = Js_dict.empty () 

  let set_null t key = 
    Js_dict.set t key Js_json.null

  let set_string t key v =
    Js_dict.set t key (Js_json.string v)
  
  let set_float t key v = 
    Js_dict.set t key (Js_json.number v)
  
  let set_int t key v = 
    Js_dict.set t key (Js_json.numberOfInt v)
  
  let set_bool t key v  = 
    Js_dict.set t key (Js_json.boolAsBoolean v)

  let set_object t key v = 
    Js_dict.set t key (Js_json.object_ v)

  let set_string_list t key (v:string list)  = 
    Js_dict.set t key (Js_json.stringArray @@ Array.of_list v)
  
  let set_float_list t key (v:float list)  = 
    Js_dict.set t key (Js_json.numberArray @@ Array.of_list v)
  
  let set_int_list t key (v:int list)  = 
    Js_dict.set t key (Js_json.intArray @@ Array.of_list v)
  
  let set_bool_list t key (v:bool list)  = 
    Js_dict.set t key (
      v 
      |> Array.of_list 
      |> Array.map Js_boolean.to_js_boolean 
      |> Js_json.booleanArray
  )

  let set_object_list t key (v:t list) = 
    Js_dict.set t key ( v |> Array.of_list |> Js_json.objectArray)

  let to_string t = 
    t |> Js_json.object_ |> Js_json.stringify
  
end
