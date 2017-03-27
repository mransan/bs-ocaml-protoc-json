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

(** Implementation of JSON runtime for `ocaml-protoc` generated code using
    native JavaScript parsing, through BuckleScript API *)

module Decoder : sig 
  include (Pbrt_json.Decoder_sig) 

  val of_json : Js_json.t -> t option
  (** [of_json json] returns a decoder if [json] is valid. [json] is valid
      if it is an [Js_json.Object] since protobuf messages are always 
      objects. *)

  val of_string : string -> t option
  (** [of_string s] returns a decoder is [s] represents a valid JSON object.
      Note that this function simply calls [Js_json.parse] underneath. *)
end  

module Encoder : sig 

  include Pbrt_json.Encoder_sig

  val to_json : t -> Js_json.t 
  (** [to_json encoder] returns the JSON object *) 

  val to_string : t -> string
  (** [to_string encoder] returns the JSON string encoded using  [encoder] *)

end 
