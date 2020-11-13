infix operator |>

func |> <A, B>(a: A, f: (A) -> B) -> B {
  return f(a)
}
