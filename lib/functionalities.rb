
# Nat nums
ZERO  = -> f { -> x {       x     } }
ONE   = -> f { -> x {     f[x]    } }
INCREMENT = -> n { -> f { -> x { f[n[f][x]] } } }
ADD       = -> m { -> n { n[INCREMENT][m] } }
MULTIPLY  = -> m { -> n { n[ADD[m]][ZERO] } }
DECREMENT = -> n { -> f { -> x { n[-> g { -> h { h[g[f]] } }][-> y { x }][-> y { y }] } } }
SUBTRACT  = -> m { -> n { n[DECREMENT][m] } }

# Bools
TRUE_shit_shit = -> x { -> y { x } }
FALSE_shit_shit = -> x { -> y { y } }
IF    = -> b { b }

# Nat nums + bools
IS_ZERO           = -> n { n[-> x { FALSE_shit }][TRUE_shit] }
IS_LESS_OR_EQUAL  = -> m { -> n { IS_ZERO[SUBTRACT[m][n]] } }
IS_EQUAL          = -> m { -> n { AND[IS_LESS_OR_EQUAL[m][n]][IS_LESS_OR_EQUAL[n][m]] } }

# y/zed combinators

Y = -> f { -> x { f[       x[x]     ] }[-> x { f[       x[x]     ] }] }
Z = -> f { -> x { f[-> _ { x[x][_] }] }[-> x { f[-> _ { x[x][_] }] }] }

# Nat nums w/recursion
DIV       = Z[-> f { -> m { -> n { IF[IS_LESS_OR_EQUAL[n][m]][-> _ { INCREMENT[f[SUBTRACT[m][n]][n]][_] }][ZERO] } } }]
MOD       = Z[-> f { -> m { -> n { IF[IS_LESS_OR_EQUAL[n][m]][-> _ { f[SUBTRACT[m][n]][n][_] }][m] } } }]

# Pairs
PAIR  = -> x { -> y { -> f { f[x][y] } } }
LEFT  = -> p { p[-> x { -> y { x } } ] }
RIGHT = -> p { p[-> x { -> y { y } } ] }

# Lists
EMPTY     = PAIR[TRUE_shit][TRUE_shit]
UNSHIFT   = -> l { -> x { PAIR[FALSE_shit][PAIR[x][l]] } }
IS_EMPTY  = LEFT
FIRST     = -> l { LEFT[RIGHT[l]] }
REST      = -> l { RIGHT[RIGHT[l]] }
CONCAT  = -> k { -> l { FOLD[k][l][UNSHIFT] } }

INJECT  = Z[-> f { -> l { -> x { -> g { IF[IS_EMPTY[l]][x][-> _ { f[REST[l]][g[x][FIRST[l]]][g][_] }] } } } }]
FOLD    = Z[-> f { -> l { -> x { -> g { IF[IS_EMPTY[l]][x][-> _ { g[f[REST[l]][x][g]][FIRST[l]][_] }] } } } }]
MAP     = -> k { -> f { FOLD[k][EMPTY][-> l { -> x { UNSHIFT[l][f[x]] } }] } }
RANGE   = Z[-> f { -> m { -> n { IF[IS_LESS_OR_EQUAL[m][n]][-> _ { UNSHIFT[f[INCREMENT[m]][n]][m][_] }][EMPTY] } } }]
SUM     = -> l { INJECT[l][ZERO][ADD] }
PRODUCT = -> l { INJECT[l][ONE][MULTIPLY] }
PUSH    = -> l { -> x { CONCAT[l][UNSHIFT[EMPTY][x]] } }

# Natural numbers with lists
TO_DIGITS = Z[-> f { -> n { PUSH[IF[IS_LESS_OR_EQUAL[n][DECREMENT[RADIX]]][EMPTY][ -> _ { f[DIV[n][RADIX]][_] } ]][MOD[n][RADIX]] } }]
TO_CHAR   = -> n { n } # assume string encoding where 0 encodes '0', 1 encodes '1' etc
TO_STRING = -> n { MAP[TO_DIGITS[n]][TO_CHAR] }

# FizzBuzz
ZERO    = -> p { -> x {       x    } }
FIVE    = -> p { -> x { p[p[p[p[p[x]]]]] } }
FIFTEEN = -> p { -> x { p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]] } }
HUNDRED = -> p { -> x { p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]] } }
FIZZ    = MAP[UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][FOUR]][FOUR]][TWO]][ONE]][ADD[RADIX]]
BUZZ    = MAP[UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][FOUR]][FOUR]][THREE]][ZERO]][ADD[RADIX]]

FIZZBUZZ =
  -> m { MAP[RANGE[ONE][m]][-> n {
    IF[IS_ZERO[MOD[n][FIFTEEN]]][
      CONCAT[FIZZ][BUZZ]
    ][IF[IS_ZERO[MOD[n][THREE]]][
      FIZZ
    ][IF[IS_ZERO[MOD[n][FIVE]]][
      BUZZ
    ][
      TO_STRING[n]
    ]]]
  }] }
  
  # inspired by jim weirich
