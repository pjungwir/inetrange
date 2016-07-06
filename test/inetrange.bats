load test_helper

@test "canonicalize closed-closed" {
  result="$(query "SELECT inetrange_canonical('[1.0.0.0,1.1.0.0]'::inetrange)")";
  [ "$result" = "[1.0.0.0,1.1.0.0]" ]
}

@test "canonicalize closed-open" {
  result="$(query "SELECT inetrange_canonical('[1.0.0.0,1.1.0.0)'::inetrange)")";
  [ "$result" = "[1.0.0.0,1.0.255.255]" ]
}

@test "canonicalize open-closed" {
  result="$(query "SELECT inetrange_canonical('(1.0.0.0,1.1.0.0]'::inetrange)")";
  [ "$result" = "[1.0.0.1,1.1.0.0]" ]
}

@test "canonicalize open-open" {
  result="$(query "SELECT inetrange_canonical('(1.0.0.0,1.1.0.0)'::inetrange)")";
  [ "$result" = "[1.0.0.1,1.0.255.255]" ]
}

@test "canonicalize inf-closed" {
  result="$(query "SELECT inetrange_canonical(inetrange(null, '1.1.0.0', '[]'))")";
  [ "$result" = "(,1.1.0.0]" ]
}

@test "canonicalize closed-inf" {
  result="$(query "SELECT inetrange_canonical(inetrange('1.0.0.0', null, '[]'))")";
  [ "$result" = "[1.0.0.0,)" ]
}

@test "diff by 0.0.0.1" {
  result="$(query "SELECT inet_diff('1.0.0.1', '1.0.0.0')")";
  [ "$result" = "1" ]
}

@test "diff by 0.0.1.0" {
  result="$(query "SELECT inet_diff('1.0.1.0', '1.0.0.0')")";
  [ "$result" = "256" ]
}
