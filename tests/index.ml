module J = Js_json
module R = Pbrt_bs

let () =
  assert(123l = R.int32 (J.string "123") "r" "f");
  assert(123l = R.int32 (J.number 123.00) "r" "f");
  assert(Some 123l = R.int32_wrapped (J.string "123") "r" "f");
  assert(Some 123l = R.int32_wrapped (J.number 123.00) "r" "f");
  assert(None = R.int32_wrapped (J.null) "r" "f");
  ()
