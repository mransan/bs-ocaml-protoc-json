[@@@ocaml.warning "-27-30-39"]

type person = {
  name : string;
  id : int32;
  email : string;
  phone : string list;
  spouse : person option;
  children : person list;
}

and person_mutable = {
  mutable name : string;
  mutable id : int32;
  mutable email : string;
  mutable phone : string list;
  mutable spouse : person option;
  mutable children : person list;
}

let rec default_person 
  ?name:((name:string) = "")
  ?id:((id:int32) = 0l)
  ?email:((email:string) = "")
  ?phone:((phone:string list) = [])
  ?spouse:((spouse:person option) = None)
  ?children:((children:person list) = [])
  () : person  = {
  name;
  id;
  email;
  phone;
  spouse;
  children;
}

and default_person_mutable () : person_mutable = {
  name = "";
  id = 0l;
  email = "";
  phone = [];
  spouse = None;
  children = [];
}

let rec pp_person fmt (v:person) = 
  let pp_i fmt () =
    Format.pp_open_vbox fmt 1;
    Pbrt.Pp.pp_record_field "name" Pbrt.Pp.pp_string fmt v.name;
    Pbrt.Pp.pp_record_field "id" Pbrt.Pp.pp_int32 fmt v.id;
    Pbrt.Pp.pp_record_field "email" Pbrt.Pp.pp_string fmt v.email;
    Pbrt.Pp.pp_record_field "phone" (Pbrt.Pp.pp_list Pbrt.Pp.pp_string) fmt v.phone;
    Pbrt.Pp.pp_record_field "spouse" (Pbrt.Pp.pp_option pp_person) fmt v.spouse;
    Pbrt.Pp.pp_record_field "children" (Pbrt.Pp.pp_list pp_person) fmt v.children;
    Format.pp_close_box fmt ()
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

module Make_decoder(Decoder:Pbrt_json.Decoder_sig) = struct
  
  module Helper = Pbrt_json.Make_decoder_helper(Decoder)
  
  let rec decode_person d =
    let v = default_person_mutable () in
    let continue = ref true in
    while !continue do
      match Decoder.key d with
      | None -> continue := false 
      | Some ("name", json_value) -> 
        v.name <- Helper.string json_value "person" "name"
      | Some ("id", json_value) -> 
        v.id <- Helper.int32 json_value "person" "id"
      | Some ("email", json_value) -> 
        v.email <- Helper.string json_value "person" "email"
      | Some ("phone", Decoder.Array_as_array a) -> begin
        v.phone <- Array.map (function
          | json_value -> Helper.string json_value "person" "phone"
        ) a |> Array.to_list;
      end
      | Some ("spouse", Decoder.Object o) -> 
        v.spouse <- Some ((decode_person o))
      | Some ("spouse", _) -> 
        v.spouse <- Some ((Pbrt_json.E.unexpected_json_type "person" "spouse"))
      | Some ("children", Decoder.Array_as_array a) -> begin
        v.children <- Array.map (function
          | Decoder.Object o -> (decode_person o)
          | _ -> (Pbrt_json.E.unexpected_json_type "person" "children")
        ) a |> Array.to_list;
      end
      
      | Some (_, _) -> () (*Unknown fields are ignored*)
    done;
    ({
      name = v.name;
      id = v.id;
      email = v.email;
      phone = v.phone;
      spouse = v.spouse;
      children = v.children;
    } : person)
  
end

module Make_encoder(Encoder:Pbrt_json.Encoder_sig) = struct
  
  let rec encode_person (v:person) encoder = 
    Encoder.set_string encoder "name" v.name;
    Encoder.set_int encoder "id" (Int32.to_int v.id);
    Encoder.set_string encoder "email" v.email;
    Encoder.set_string_list encoder "phone" v.phone;
    begin match v.spouse with
      | None -> ()
      | Some v ->
      begin (* spouse field *)
        let encoder' = Encoder.empty () in
        encode_person v encoder';
        Encoder.set_object encoder "spouse" encoder';
      end;
    end;
    let children' = List.map (fun v ->
      let encoder' = Encoder.empty () in
      encode_person v encoder';
      Encoder.set_object encoder "children" encoder';
      encoder'
    ) v.children in
    Encoder.set_object_list encoder "children" children';
    ()
  
end