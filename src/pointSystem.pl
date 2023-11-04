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



:- consult('rules.pl').
:- consult('display.pl').


% ======================================================= %
% ==================== INITIALIZE LISTS ================= %
turns([]).

PointsListBlue([]).
PointsListRed([]).

% ======================================================= %

% ===================== TURNS ========================= %

incrementTurn(turns, X) :-
    last(turns, Last),
    X is Last + 1.
    append(turns, X, new_turns),
    last(new_turns, CurrentTurn),
    FirstRow is 1,
    FirstColumn is 1,
    (
        CurrentTurn =:= 4
        ->  iterateBoard(Board, FirstRow, FirstColumn, Occupation, PointsListRed, NewPointsListRed, PointsListBlue, NewPointsListBlue),
        ;  CurrentTurn =:= 8
        ->  iterateBoard(Board, FirstRow, FirstColumn, Occupation, PointsListRed, NewPointsListRed, PointsListBlue, NewPointsListBlue),
        ;  CurrentTurn =:= 12
        ->  iterateBoard(Board, FirstRow, FirstColumn, Occupation, PointsListRed, NewPointsListRed, PointsListBlue, NewPointsListBlue),
        ;  CurrentTurn =:= 16
        ->  iterateBoard(Board, FirstRow, FirstColumn, Occupation, PointsListRed, NewPointsListRed, PointsListBlue, NewPointsListBlue),
            total_score(NewPointsListRed, NewPointsListBlue, ScoreRed, ScoreBlue),
            write("Red Score: "), write(ScoreRed), nl,
            write("Blue Score: "), write(ScoreBlue), nl,
            (
                ScoreRed > ScoreBlue
                ->  write("Red Wins!"), nl
                ; ScoreBlue > ScoreRed
                ->  write("Blue Wins!"), nl
                ; ScoreRed == ScoreBlue
                ->  write("It's a tie!"), nl
            )
    ).

% ======================================================= %

% ===================== BOARD ITERATION ========================= %


boardCheck(Board, I, J, Occupation) :-
    nth0(I, Board, Row),
    nth0(J, Row, Occupation).


iterateBoard(Board, I, J, Occupation, PointsListRed, NewPointsListRed, PointsListBlue, NewPointsListBlue) :-
    checkRow(isValid, I),
    (
        isValid == true
        ->  write("Iterating through board"),
        checkColumn(isValid, J),
        (
            isValid == true
            ->  boardCheck(Board, I, J, Occupation),
                (
                    Occupation == 1        % 1 is red
                    -> checkPositionPoints(I, J, Points), append(PointsListRed, Points, NewPointsListRed), 
                    ; Occupation == 2      % 2 is blue
                    -> checkPositionPoints(I, J, Points), append(PointsListBlue, Points, NewPointsListBlue),
                    ; Occupation == clear      % clear is empty
                    -> write("Empty space")
                ),
                J1 is J + 1,
                iterateBoard(Board, I, J, Occupation, NewPointsListRed, NewerPointsListRed, NewPointsListBlue, NewerPointsListBlue)
            ;   I1 is I + 1,
                J1 is 1,
                iterateBoard(Board, I, J, Occupation, NewPointsListRed, NewerPointsListRed, NewPointsListBlue, NewerPointsListBlue)
        
        ),
        ;   write("Finished iterating through board")

    ).

% ======================================================= %


% ===================== POINTS ========================= %

checkPositionPoints(Row, Column, Points):-
    (
            Row == 1
                ->  Points = 0
        ;   Row == 2
                -> (    
                            Column == 1
                                ->  Points = 0
                        ;   Column == 8
                                ->  Points = 0
                        ;   Points = 25
                    ),
        ;   Row == 3
                ->  (
                            Column == 1
                                ->  Points = 0
                        ;   Column == 8
                                ->  Points = 0
                        ;   Column == 2
                                ->  Points = 25
                        ;   Column == 7
                                ->  Points = 25
                        ;   Points = 50
                    )
        ;   Row == 4
                ->  (
                            Column == 1
                                ->  Points = 0
                        ;   Column == 8
                                ->  Points = 0
                        ;   Column == 2
                                ->  Points = 25
                        ;   Column == 7
                                ->  Points = 25
                        ;   Column == 3
                                ->  Points = 50
                        ;   Column == 6
                                ->  Points = 50
                        ;   Points = 100
                    )
        ;   Row == 5
                ->  (
                            Column == 1
                                ->  Points = 0
                        ;   Column == 8
                                ->  Points = 0
                        ;   Column == 2
                                ->  Points = 25
                        ;   Column == 7
                                ->  Points = 25
                        ;   Column == 3
                                ->  Points = 50
                        ;   Column == 6
                                ->  Points = 50
                        ;   Points = 100
                    )
        ;   Row == 6
                ->  (
                            Column == 1
                                ->  Points = 0
                        ;   Column == 8
                                ->  Points = 0
                        ;   Column == 2
                                ->  Points = 25
                        ;   Column == 7
                                ->  Points = 25
                        ;   Points = 50
                    )
        ;   Row == 7
                ->  (
                            Column == 1
                                ->  Points = 0
                        ;   Column == 8
                                ->  Points = 0
                        ;   Points = 25
                    )
        ;   Row == 8
                ->  Points = 0
        
    ).

% ======================================================= %

% ===================== TOTAL SCORE ========================= %

total_score(PointsListRed, PointsListBlue, ScoreRed, ScoreBlue):-
    sum_list(PointsListRed, ScoreRed),
    sum_list(PointsListBlue, ScoreBlue).

% ======================================================= %
