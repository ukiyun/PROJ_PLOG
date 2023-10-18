% piece[color, shape]

bluepiece = (blue, "〇").
redpiece(red, "ⓧ").

getPieceColor(Piece, Color) :-
    color(0,Piece, Color).

getPieceSymbol(Piece, Symbol) :-
    shape(1,Piece, Shape).