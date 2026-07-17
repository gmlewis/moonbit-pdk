///|
priv struct Add {
  a : Int
  b : Int
} derive(FromJson)

///|
priv struct Sum {
  sum : Int
} derive(ToJson)

///|
pub fn add() -> Int {
  let input = @host.input_string()
  let params : Add = @json.from_json(@json.parse(input)) catch {
    e => {
      @host.set_error(e.to_string())
      return 1
    }
  }
  //
  let sum = { sum: params.a + params.b }
  @host.output_json_value(ToJson::to_json(sum))
  0 // success
}

///|
test "Sum::to_json works as expected" {
  let sum = { sum: 42 }
  let got = ToJson::to_json(sum).stringify()
  let want =
    #|{"sum":42}
  inspect(got, content=want)
}
