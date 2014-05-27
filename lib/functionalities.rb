TRUE              = -> x { -> y { x } }
FALSE             = -> x { -> y { y } }
IF                = -> b { b }
IS_ZERO           = -> n { n[-> x { FALSE }][TRUE] }
INCREMENT         = -> n { -> p { -> x { p[n[p][x]] } } }
DECREMENT         = -> n { -> f { -> x { n[-> g { -> h { h[g[f]] } }]
                                  [-> y { x }][-> y { y }] } } }
ADD               = -> m { -> n { n[INCREMENT][m] } }
SUBTRACT          = -> m { -> n { n[DECREMENT][m] } }
MULTIPLY          = -> m { -> n { n[ADD[m]][ZERO] } }
POWER             = -> m { -> n { n[MULTIPLY[m]][ONE] } }
IS_LESS_OR_EQUAL  = -> m { -> n {
                    IS_ZERO[SUBTRACT[m][n]]
                    } }

MOD =
  Z[-> f { -> m { -> n {
    IF[IS_LESS_OR_EQUAL[n][m]][
      -> x {
        f[SUBTRACT[m][n]][n][x]
        }][m]
        } } }]

Z = -> f { -> x { f[-> y { x[x][y] }] }
          [-> x { f[-> y { x[x][y] }] }] }

PAIR  = -> x { -> y { -> f { f[x][y] } } }
LEFT  = -> p { p[-> x { -> y { x } } ] }
RIGHT = -> p { p[-> x { -> y { y } } ] }
EMPTY     = PAIR[TRUE][TRUE]
UNSHIFT   = -> l { -> x {
              PAIR[FALSE][PAIR[x][l]]
            } }

IS_EMPTY  = LEFT
FIRST     = -> l { LEFT[RIGHT[l]] }
REST      = -> l { RIGHT[RIGHT[l]] }
RANGE     = Z[-> f {
            -> m { -> n {
              IF[IS_LESS_OR_EQUAL[m][n]][-> x { UNSHIFT[f[INCREMENT[m]][n]][m][x] } ] [EMPTY] } } }]

FOLD      = Z[-> f { -> l { -> x { -> g { 
              IF[IS_EMPTY[l]][x][-> y 
                {g[f[REST[l]][x][g]][FIRST[l]][y]}]
                } 
              } 
            }
          }]
