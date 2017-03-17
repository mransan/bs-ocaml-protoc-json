[@@@ocaml.warning "-27-30-39"]

type all_basic_types = {
  field01 : float;
  field02 : float;
  field03 : int32;
  field04 : int64;
  field05 : int32;
  field06 : int64;
  field07 : int32;
  field08 : int64;
  field09 : int32;
  field10 : int64;
  field13 : bool;
  field14 : string;
  repeated01 : float list;
  repeated02 : float list;
  repeated03 : int32 list;
  repeated04 : int64 list;
  repeated05 : int32 list;
  repeated06 : int64 list;
  repeated07 : int32 list;
  repeated08 : int64 list;
  repeated09 : int32 list;
  repeated10 : int64 list;
  repeated13 : bool list;
  repeated14 : string list;
}

and all_basic_types_mutable = {
  mutable field01 : float;
  mutable field02 : float;
  mutable field03 : int32;
  mutable field04 : int64;
  mutable field05 : int32;
  mutable field06 : int64;
  mutable field07 : int32;
  mutable field08 : int64;
  mutable field09 : int32;
  mutable field10 : int64;
  mutable field13 : bool;
  mutable field14 : string;
  mutable repeated01 : float list;
  mutable repeated02 : float list;
  mutable repeated03 : int32 list;
  mutable repeated04 : int64 list;
  mutable repeated05 : int32 list;
  mutable repeated06 : int64 list;
  mutable repeated07 : int32 list;
  mutable repeated08 : int64 list;
  mutable repeated09 : int32 list;
  mutable repeated10 : int64 list;
  mutable repeated13 : bool list;
  mutable repeated14 : string list;
}

type small_message = {
  sm_string : string;
}

and small_message_mutable = {
  mutable sm_string : string;
}

type enum =
  | Value0 
  | Value1 
  | Value_two 

type single_one_of =
  | String_value of string
  | Int_value of int32
  | Enum_value of enum
  | Small_message of small_message
  | Recursive_value of single_one_of

type test = {
  all_basic_types : all_basic_types option;
  test_enum0 : enum;
  test_enum1 : enum;
  test_enum2 : enum;
  single_one_of_string : single_one_of option;
  single_one_of_int : single_one_of option;
  single_one_of_enum : single_one_of option;
  single_one_of_small_message : single_one_of option;
  single_one_of_recursive : single_one_of option;
}

and test_mutable = {
  mutable all_basic_types : all_basic_types option;
  mutable test_enum0 : enum;
  mutable test_enum1 : enum;
  mutable test_enum2 : enum;
  mutable single_one_of_string : single_one_of option;
  mutable single_one_of_int : single_one_of option;
  mutable single_one_of_enum : single_one_of option;
  mutable single_one_of_small_message : single_one_of option;
  mutable single_one_of_recursive : single_one_of option;
}

let rec default_all_basic_types 
  ?field01:((field01:float) = 0.)
  ?field02:((field02:float) = 0.)
  ?field03:((field03:int32) = 0l)
  ?field04:((field04:int64) = 0L)
  ?field05:((field05:int32) = 0l)
  ?field06:((field06:int64) = 0L)
  ?field07:((field07:int32) = 0l)
  ?field08:((field08:int64) = 0L)
  ?field09:((field09:int32) = 0l)
  ?field10:((field10:int64) = 0L)
  ?field13:((field13:bool) = false)
  ?field14:((field14:string) = "")
  ?repeated01:((repeated01:float list) = [])
  ?repeated02:((repeated02:float list) = [])
  ?repeated03:((repeated03:int32 list) = [])
  ?repeated04:((repeated04:int64 list) = [])
  ?repeated05:((repeated05:int32 list) = [])
  ?repeated06:((repeated06:int64 list) = [])
  ?repeated07:((repeated07:int32 list) = [])
  ?repeated08:((repeated08:int64 list) = [])
  ?repeated09:((repeated09:int32 list) = [])
  ?repeated10:((repeated10:int64 list) = [])
  ?repeated13:((repeated13:bool list) = [])
  ?repeated14:((repeated14:string list) = [])
  () : all_basic_types  = {
  field01;
  field02;
  field03;
  field04;
  field05;
  field06;
  field07;
  field08;
  field09;
  field10;
  field13;
  field14;
  repeated01;
  repeated02;
  repeated03;
  repeated04;
  repeated05;
  repeated06;
  repeated07;
  repeated08;
  repeated09;
  repeated10;
  repeated13;
  repeated14;
}

and default_all_basic_types_mutable () : all_basic_types_mutable = {
  field01 = 0.;
  field02 = 0.;
  field03 = 0l;
  field04 = 0L;
  field05 = 0l;
  field06 = 0L;
  field07 = 0l;
  field08 = 0L;
  field09 = 0l;
  field10 = 0L;
  field13 = false;
  field14 = "";
  repeated01 = [];
  repeated02 = [];
  repeated03 = [];
  repeated04 = [];
  repeated05 = [];
  repeated06 = [];
  repeated07 = [];
  repeated08 = [];
  repeated09 = [];
  repeated10 = [];
  repeated13 = [];
  repeated14 = [];
}

let rec default_small_message 
  ?sm_string:((sm_string:string) = "")
  () : small_message  = {
  sm_string;
}

and default_small_message_mutable () : small_message_mutable = {
  sm_string = "";
}

let rec default_enum () = (Value0:enum)

let rec default_single_one_of () : single_one_of = String_value ("")

let rec default_test 
  ?all_basic_types:((all_basic_types:all_basic_types option) = None)
  ?test_enum0:((test_enum0:enum) = default_enum ())
  ?test_enum1:((test_enum1:enum) = default_enum ())
  ?test_enum2:((test_enum2:enum) = default_enum ())
  ?single_one_of_string:((single_one_of_string:single_one_of option) = None)
  ?single_one_of_int:((single_one_of_int:single_one_of option) = None)
  ?single_one_of_enum:((single_one_of_enum:single_one_of option) = None)
  ?single_one_of_small_message:((single_one_of_small_message:single_one_of option) = None)
  ?single_one_of_recursive:((single_one_of_recursive:single_one_of option) = None)
  () : test  = {
  all_basic_types;
  test_enum0;
  test_enum1;
  test_enum2;
  single_one_of_string;
  single_one_of_int;
  single_one_of_enum;
  single_one_of_small_message;
  single_one_of_recursive;
}

and default_test_mutable () : test_mutable = {
  all_basic_types = None;
  test_enum0 = default_enum ();
  test_enum1 = default_enum ();
  test_enum2 = default_enum ();
  single_one_of_string = None;
  single_one_of_int = None;
  single_one_of_enum = None;
  single_one_of_small_message = None;
  single_one_of_recursive = None;
}

module Make_decoder(Decoder:Pbrt_json.Decoder_sig) = struct
  
  module Helper = Pbrt_json.Make_decoder_helper(Decoder)
  
  let rec decode_all_basic_types d =
    let v = default_all_basic_types_mutable () in
    let continue = ref true in
    while !continue do
      match Decoder.key d with
      | None -> continue := false 
      | Some ("field01", json_value) -> 
        v.field01 <- Helper.float json_value "all_basic_types" "field01"
      | Some ("field02", json_value) -> 
        v.field02 <- Helper.float json_value "all_basic_types" "field02"
      | Some ("field03", json_value) -> 
        v.field03 <- Helper.int32 json_value "all_basic_types" "field03"
      | Some ("field04", json_value) -> 
        v.field04 <- Helper.int64 json_value "all_basic_types" "field04"
      | Some ("field05", json_value) -> 
        v.field05 <- Helper.int32 json_value "all_basic_types" "field05"
      | Some ("field06", json_value) -> 
        v.field06 <- Helper.int64 json_value "all_basic_types" "field06"
      | Some ("field07", json_value) -> 
        v.field07 <- Helper.int32 json_value "all_basic_types" "field07"
      | Some ("field08", json_value) -> 
        v.field08 <- Helper.int64 json_value "all_basic_types" "field08"
      | Some ("field09", json_value) -> 
        v.field09 <- Helper.int32 json_value "all_basic_types" "field09"
      | Some ("field10", json_value) -> 
        v.field10 <- Helper.int64 json_value "all_basic_types" "field10"
      | Some ("field13", json_value) -> 
        v.field13 <- Helper.bool json_value "all_basic_types" "field13"
      | Some ("field14", json_value) -> 
        v.field14 <- Helper.string json_value "all_basic_types" "field14"
      | Some ("repeated01", Decoder.Array_as_array a) -> begin
        v.repeated01 <- Array.map (function
          | json_value -> Helper.float json_value "all_basic_types" "repeated01"
        ) a |> Array.to_list;
      end
      | Some ("repeated02", Decoder.Array_as_array a) -> begin
        v.repeated02 <- Array.map (function
          | json_value -> Helper.float json_value "all_basic_types" "repeated02"
        ) a |> Array.to_list;
      end
      | Some ("repeated03", Decoder.Array_as_array a) -> begin
        v.repeated03 <- Array.map (function
          | json_value -> Helper.int32 json_value "all_basic_types" "repeated03"
        ) a |> Array.to_list;
      end
      | Some ("repeated04", Decoder.Array_as_array a) -> begin
        v.repeated04 <- Array.map (function
          | json_value -> Helper.int64 json_value "all_basic_types" "repeated04"
        ) a |> Array.to_list;
      end
      | Some ("repeated05", Decoder.Array_as_array a) -> begin
        v.repeated05 <- Array.map (function
          | json_value -> Helper.int32 json_value "all_basic_types" "repeated05"
        ) a |> Array.to_list;
      end
      | Some ("repeated06", Decoder.Array_as_array a) -> begin
        v.repeated06 <- Array.map (function
          | json_value -> Helper.int64 json_value "all_basic_types" "repeated06"
        ) a |> Array.to_list;
      end
      | Some ("repeated07", Decoder.Array_as_array a) -> begin
        v.repeated07 <- Array.map (function
          | json_value -> Helper.int32 json_value "all_basic_types" "repeated07"
        ) a |> Array.to_list;
      end
      | Some ("repeated08", Decoder.Array_as_array a) -> begin
        v.repeated08 <- Array.map (function
          | json_value -> Helper.int64 json_value "all_basic_types" "repeated08"
        ) a |> Array.to_list;
      end
      | Some ("repeated09", Decoder.Array_as_array a) -> begin
        v.repeated09 <- Array.map (function
          | json_value -> Helper.int32 json_value "all_basic_types" "repeated09"
        ) a |> Array.to_list;
      end
      | Some ("repeated10", Decoder.Array_as_array a) -> begin
        v.repeated10 <- Array.map (function
          | json_value -> Helper.int64 json_value "all_basic_types" "repeated10"
        ) a |> Array.to_list;
      end
      | Some ("repeated13", Decoder.Array_as_array a) -> begin
        v.repeated13 <- Array.map (function
          | json_value -> Helper.bool json_value "all_basic_types" "repeated13"
        ) a |> Array.to_list;
      end
      | Some ("repeated14", Decoder.Array_as_array a) -> begin
        v.repeated14 <- Array.map (function
          | json_value -> Helper.string json_value "all_basic_types" "repeated14"
        ) a |> Array.to_list;
      end
      
      | Some (_, _) -> () (*Unknown fields are ignored*)
    done;
    ({
      field01 = v.field01;
      field02 = v.field02;
      field03 = v.field03;
      field04 = v.field04;
      field05 = v.field05;
      field06 = v.field06;
      field07 = v.field07;
      field08 = v.field08;
      field09 = v.field09;
      field10 = v.field10;
      field13 = v.field13;
      field14 = v.field14;
      repeated01 = v.repeated01;
      repeated02 = v.repeated02;
      repeated03 = v.repeated03;
      repeated04 = v.repeated04;
      repeated05 = v.repeated05;
      repeated06 = v.repeated06;
      repeated07 = v.repeated07;
      repeated08 = v.repeated08;
      repeated09 = v.repeated09;
      repeated10 = v.repeated10;
      repeated13 = v.repeated13;
      repeated14 = v.repeated14;
    } : all_basic_types)
  
  let rec decode_small_message d =
    let v = default_small_message_mutable () in
    let continue = ref true in
    while !continue do
      match Decoder.key d with
      | None -> continue := false 
      | Some ("smString", json_value) -> 
        v.sm_string <- Helper.string json_value "small_message" "sm_string"
      
      | Some (_, _) -> () (*Unknown fields are ignored*)
    done;
    ({
      sm_string = v.sm_string;
    } : small_message)
  
  let rec decode_enum (value:Decoder.value) =
    match value with
    | Decoder.String "VALUE0" -> Value0
    | Decoder.String "VALUE1" -> Value1
    | Decoder.String "VALUE_TWO" -> Value_two
    | _ -> Pbrt_json.E.malformed_variant "enum"
  
  let rec decode_single_one_of d =
    let rec loop () =
      match Decoder.key d with
      | None -> Pbrt_json.E.malformed_variant "single_one_of"
      | Some ("stringValue", json_value) -> 
        String_value (Helper.string json_value "single_one_of" "String_value")
      | Some ("intValue", json_value) -> 
        Int_value (Helper.int32 json_value "single_one_of" "Int_value")
      | Some ("enumValue", json_value) -> 
        Enum_value ((decode_enum json_value))
      | Some ("smallMessage", Decoder.Object o) -> 
        Small_message ((decode_small_message o))
      | Some ("smallMessage", _) -> 
        Small_message ((Pbrt_json.E.unexpected_json_type "single_one_of" "Small_message"))
      | Some ("recursiveValue", Decoder.Object o) -> 
        Recursive_value ((decode_single_one_of o))
      | Some ("recursiveValue", _) -> 
        Recursive_value ((Pbrt_json.E.unexpected_json_type "single_one_of" "Recursive_value"))
      
      | Some (_, _) -> loop ()
    in
    loop ()
  
  let rec decode_test d =
    let v = default_test_mutable () in
    let continue = ref true in
    while !continue do
      match Decoder.key d with
      | None -> continue := false 
      | Some ("allBasicTypes", Decoder.Object o) -> 
        v.all_basic_types <- Some ((decode_all_basic_types o))
      | Some ("allBasicTypes", _) -> 
        v.all_basic_types <- Some ((Pbrt_json.E.unexpected_json_type "test" "all_basic_types"))
      | Some ("testEnum0", json_value) -> 
        v.test_enum0 <- (decode_enum json_value)
      | Some ("testEnum1", json_value) -> 
        v.test_enum1 <- (decode_enum json_value)
      | Some ("testEnum2", json_value) -> 
        v.test_enum2 <- (decode_enum json_value)
      | Some ("singleOneOfString", Decoder.Object o) -> 
        v.single_one_of_string <- Some ((decode_single_one_of o))
      | Some ("singleOneOfString", _) -> 
        v.single_one_of_string <- Some ((Pbrt_json.E.unexpected_json_type "test" "single_one_of_string"))
      | Some ("singleOneOfInt", Decoder.Object o) -> 
        v.single_one_of_int <- Some ((decode_single_one_of o))
      | Some ("singleOneOfInt", _) -> 
        v.single_one_of_int <- Some ((Pbrt_json.E.unexpected_json_type "test" "single_one_of_int"))
      | Some ("singleOneOfEnum", Decoder.Object o) -> 
        v.single_one_of_enum <- Some ((decode_single_one_of o))
      | Some ("singleOneOfEnum", _) -> 
        v.single_one_of_enum <- Some ((Pbrt_json.E.unexpected_json_type "test" "single_one_of_enum"))
      | Some ("singleOneOfSmallMessage", Decoder.Object o) -> 
        v.single_one_of_small_message <- Some ((decode_single_one_of o))
      | Some ("singleOneOfSmallMessage", _) -> 
        v.single_one_of_small_message <- Some ((Pbrt_json.E.unexpected_json_type "test" "single_one_of_small_message"))
      | Some ("singleOneOfRecursive", Decoder.Object o) -> 
        v.single_one_of_recursive <- Some ((decode_single_one_of o))
      | Some ("singleOneOfRecursive", _) -> 
        v.single_one_of_recursive <- Some ((Pbrt_json.E.unexpected_json_type "test" "single_one_of_recursive"))
      
      | Some (_, _) -> () (*Unknown fields are ignored*)
    done;
    ({
      all_basic_types = v.all_basic_types;
      test_enum0 = v.test_enum0;
      test_enum1 = v.test_enum1;
      test_enum2 = v.test_enum2;
      single_one_of_string = v.single_one_of_string;
      single_one_of_int = v.single_one_of_int;
      single_one_of_enum = v.single_one_of_enum;
      single_one_of_small_message = v.single_one_of_small_message;
      single_one_of_recursive = v.single_one_of_recursive;
    } : test)
  
end

module Make_encoder(Encoder:Pbrt_json.Encoder_sig) = struct
  
  let rec encode_all_basic_types (v:all_basic_types) encoder = 
    Encoder.set_string encoder "field01" (string_of_float v.field01);
    Encoder.set_float encoder "field02" v.field02;
    Encoder.set_int encoder "field03" (Int32.to_int v.field03);
    Encoder.set_string encoder "field04" (Int64.to_string v.field04);
    Encoder.set_int encoder "field05" (Int32.to_int v.field05);
    Encoder.set_string encoder "field06" (Int64.to_string v.field06);
    Encoder.set_int encoder "field07" (Int32.to_int v.field07);
    Encoder.set_string encoder "field08" (Int64.to_string v.field08);
    Encoder.set_int encoder "field09" (Int32.to_int v.field09);
    Encoder.set_string encoder "field10" (Int64.to_string v.field10);
    Encoder.set_bool encoder "field13" v.field13;
    Encoder.set_string encoder "field14" v.field14;
    Encoder.set_string_list encoder "repeated01"
      (List.map string_of_float v.repeated01);
    Encoder.set_float_list encoder "repeated02" v.repeated02;
    Encoder.set_int_list encoder "repeated03"
      (List.map Int32.to_int v.repeated03);
    Encoder.set_string_list encoder "repeated04"
      (List.map Int64.to_string v.repeated04);
    Encoder.set_int_list encoder "repeated05"
      (List.map Int32.to_int v.repeated05);
    Encoder.set_string_list encoder "repeated06"
      (List.map Int64.to_string v.repeated06);
    Encoder.set_int_list encoder "repeated07"
      (List.map Int32.to_int v.repeated07);
    Encoder.set_string_list encoder "repeated08"
      (List.map Int64.to_string v.repeated08);
    Encoder.set_int_list encoder "repeated09"
      (List.map Int32.to_int v.repeated09);
    Encoder.set_string_list encoder "repeated10"
      (List.map Int64.to_string v.repeated10);
    Encoder.set_bool_list encoder "repeated13" v.repeated13;
    Encoder.set_string_list encoder "repeated14" v.repeated14;
    ()
  
  let rec encode_small_message (v:small_message) encoder = 
    Encoder.set_string encoder "smString" v.sm_string;
    ()
  
  let rec encode_enum (v:enum) : string = 
    match v with
    | Value0 -> "VALUE0"
    | Value1 -> "VALUE1"
    | Value_two -> "VALUE_TWO"
  
  let rec encode_single_one_of (v:single_one_of) encoder = 
    begin match v with
      | String_value v ->
      Encoder.set_string encoder "stringValue" v;
      | Int_value v ->
      Encoder.set_int encoder "intValue" (Int32.to_int v);
      | Enum_value v ->
      Encoder.set_string encoder "enumValue" (encode_enum v);
      | Small_message v ->
      begin (* smallMessage field *)
        let encoder' = Encoder.empty () in
        encode_small_message v encoder';
        Encoder.set_object encoder "smallMessage" encoder';
      end;
      | Recursive_value v ->
      begin (* recursiveValue field *)
        let encoder' = Encoder.empty () in
        encode_single_one_of v encoder';
        Encoder.set_object encoder "recursiveValue" encoder';
      end;
    end
  
  let rec encode_test (v:test) encoder = 
    begin match v.all_basic_types with
      | None -> ()
      | Some v ->
      begin (* allBasicTypes field *)
        let encoder' = Encoder.empty () in
        encode_all_basic_types v encoder';
        Encoder.set_object encoder "allBasicTypes" encoder';
      end;
    end;
    Encoder.set_string encoder "testEnum0" (encode_enum v.test_enum0);
    Encoder.set_string encoder "testEnum1" (encode_enum v.test_enum1);
    Encoder.set_string encoder "testEnum2" (encode_enum v.test_enum2);
    begin match v.single_one_of_string with
      | None -> ()
      | Some v ->
      begin (* singleOneOfString field *)
        let encoder' = Encoder.empty () in
        encode_single_one_of v encoder';
        Encoder.set_object encoder "singleOneOfString" encoder';
      end;
    end;
    begin match v.single_one_of_int with
      | None -> ()
      | Some v ->
      begin (* singleOneOfInt field *)
        let encoder' = Encoder.empty () in
        encode_single_one_of v encoder';
        Encoder.set_object encoder "singleOneOfInt" encoder';
      end;
    end;
    begin match v.single_one_of_enum with
      | None -> ()
      | Some v ->
      begin (* singleOneOfEnum field *)
        let encoder' = Encoder.empty () in
        encode_single_one_of v encoder';
        Encoder.set_object encoder "singleOneOfEnum" encoder';
      end;
    end;
    begin match v.single_one_of_small_message with
      | None -> ()
      | Some v ->
      begin (* singleOneOfSmallMessage field *)
        let encoder' = Encoder.empty () in
        encode_single_one_of v encoder';
        Encoder.set_object encoder "singleOneOfSmallMessage" encoder';
      end;
    end;
    begin match v.single_one_of_recursive with
      | None -> ()
      | Some v ->
      begin (* singleOneOfRecursive field *)
        let encoder' = Encoder.empty () in
        encode_single_one_of v encoder';
        Encoder.set_object encoder "singleOneOfRecursive" encoder';
      end;
    end;
    ()
  
end