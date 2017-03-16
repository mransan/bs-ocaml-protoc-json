(** Implementation of JSON runtime for `ocaml-protoc` generated code using
    native JavaScript parsing, through BuckleScript API *)

module Decoder : sig 
  include (Pbrt_json.Decoder_sig) 

(*  val of_json : json -> t option*)
  (** [of_json json] returns a decoder if [json] is valid. [json] is valid
      if it is an [Js_json.Object] since protobuf messages are always 
      objects. *)

  val of_string : string -> t option
  (** [of_string s] returns a decoder is [s] represents a valid JSON object.
      Note that this function simply calls [Js_json.parse] underneath. *)
end  

module Encoder : sig 

  include Pbrt_json.Encoder_sig

  val to_string : t -> string
  (** [to_string encoder] returns the JSON string encoded using  [encoder] *)

end 
