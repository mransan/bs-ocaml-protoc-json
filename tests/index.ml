module J = Js_json
module R = Pbrt_bs

let () =
  assert(123l = R.int32 (J.string "123") "r" "f");
  assert(123l = R.int32 (J.string "123") "r" "f");
  assert(123l = R.int32 (J.number 123.00) "r" "f");
  ()
