TRUE  = -> x { -> y { x } }
FALSE = -> x { -> y { y } }
IF    = -> b { -> x { -> y { b[x][y] } } }
