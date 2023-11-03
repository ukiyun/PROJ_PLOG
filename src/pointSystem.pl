% Every 4 turns the players score will be tallied, at the end all of the scores will be added up and the player with the highest score wins.

% Game is a 8x8 board, so 64 spaces
% rectangle formed by 1st row and column and 8th row and column are worth 0 points
% rectangle formed by 2nd row and column and 7th row and column are worth 25 points
% rectangle formed by 3rd row and column and 6th row and column are worth 50 points
% rectangle formed by 4th row and column and 5th row and column are worth 100 points


/*
    [0,  0,  0,   0,   0,  0,  0, 0],
    [0, 25, 25,  25,  25, 25, 25, 0],
    [0, 25, 50,  50,  50, 50, 25, 0],
    [0, 25, 50, 100, 100, 50, 25, 0],
    [0, 25, 50, 100, 100, 50, 25, 0],
    [0, 25, 50,  50,  50, 50, 25, 0],
    [0, 25, 25,  25,  25, 25, 25, 0],
    [0,  0,  0,   0,   0,  0,  0, 0]

*/

turn(0).

score_red(0).
score_blue(0).

incrementTurn(Turn, NewTurn):- 
    NewTurn is Turn + 1.

checkTurn(Turn):-
    Turn =:= 4.



