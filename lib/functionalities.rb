TRUE    = -> x { -> y { x } }
FALSE   = -> x { -> y { y } }
IF      = -> b { b }
IS_ZERO = -> n { n[-> x { FALSE }][TRUE] }
INCREMENT = -> n { -> p { -> x { p[n[p][x]] } } }
DECREMENT = -> n { -> f { -> x { n[-> g { -> h { h[g[f]] } }]
                                  [-> y { x }][-> y { y }] } } }
ADD      = -> m { -> n { n[INCREMENT][m] } }
SUBTRACT = -> m { -> n { n[DECREMENT][m] } }
MULTIPLY = -> m { -> n { n[ADD[m]][ZERO] } }
POWER    = -> m { -> n { n[MULTIPLY[m]][ONE] } }