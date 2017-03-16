(** example.proto Generated Types and Encoding *)


(** {2 Types} *)

type person = {
  name : string;
  id : int32;
  email : string;
  phone : string list;
  spouse : person option;
  children : person list;
}


(** {2 Default values} *)

val default_person : 
  ?name:string ->
  ?id:int32 ->
  ?email:string ->
  ?phone:string list ->
  ?spouse:person option ->
  ?children:person list ->
  unit ->
  person
(** [default_person ()] is the default value for type [person] *)


(** {2 Formatters} *)

val pp_person : Format.formatter -> person -> unit 
(** [pp_person v] formats v *)

module Make_decoder(Decoder:Pbrt_json.Decoder_sig) : sig
  
  (** {2 JSON Decoding} *)
  
  val decode_person : Decoder.t -> person
  (** [decode_person decoder] decodes a [person] value from [decoder] *)
  
end
module Make_encoder(Encoder:Pbrt_json.Encoder_sig) : sig
  
  (** {2 Protobuf JSON Encoding} *)
  
  val encode_person : person -> Encoder.t -> unit
  (** [encode_person v encoder] encodes [v] with the given [encoder] *)
  
end