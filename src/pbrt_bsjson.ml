(* --- START of code from BuckleScript --- *)

(* Copyright (C) 2015-2016 Bloomberg Finance L.P.
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * In addition to the permissions granted to you by the LGPL, you may combine
 * or link a "work that uses the Library" with a publicly distributed version
 * of this file to produce a combined library or application, then distribute
 * that combined work under the terms of your choosing, with no requirement
 * to comply with the obligations normally placed on you by section 4 of the
 * LGPL version 3 (or the corresponding section of a later version of the LGPL
 * should you choose to use a later version).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *)


module Js_cast = struct 
  external intOfBool : bool -> int = "%identity"  
  external floatOfInt : int -> float = "%identity"  
end 

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

  external stringifyAny : 'a -> string option = "JSON.stringify" [@@bs.val] [@@bs.return undefined_to_opt]
  (* TODO: more docs when parse error happens or stringify non-stringfy value *)
  
  external null : t = "" [@@bs.val]
  
  external string : string -> t = "%identity"
  
  external number : float -> t = "%identity"
  
  external boolean : Js.boolean -> t = "%identity" 
  
  external object_ : t Js_dict.t -> t = "%identity"
  
  external array_ : t array -> t = "%identity"
  
  external stringArray : string array -> t = "%identity"
  
  external numberArray : float array -> t = "%identity"
  
  external booleanArray : Js.boolean array -> t = "%identity"
  
  external objectArray : t Js_dict.t array -> t = "%identity"
  
  external stringify: t -> string = "JSON.stringify" [@@bs.val]
  
end 

(* --- END of code from BuckleScript --- *)

(*
  The MIT License (MIT)
  
  Copyright (c) 2016 Maxime Ransan <maxime.ransan@gmail.com>
  
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.

*)

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
    Js_dict.set t key (Js_json.number (Js_cast.floatOfInt v))
  
  let set_bool t key v  = 
    Js_dict.set t key (Js_json.boolean (Js_boolean.to_js_boolean v))

  let set_object t key v = 
    Js_dict.set t key (Js_json.object_ v)

  let set_string_list t key (v:string list)  = 
    Js_dict.set t key (Js_json.stringArray @@ Array.of_list v)
  
  let set_float_list t key (v:float list)  = 
    Js_dict.set t key (Js_json.numberArray @@ Array.of_list v)
  
  let set_int_list t key (v:int list)  = 
    Js_dict.set t key (
      v
      |> Array.of_list 
      |> Array.map Js_cast.floatOfInt
      |> Js_json.numberArray 
    )
  
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
