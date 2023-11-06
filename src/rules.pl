:- use_module(library(random)).
:- use_module(library(lists)).
:- consult('board.pl').


% Choose a random player to start
% PlayerOne is 1 and PlayerTwo is 3 (because the upperbound is not included in the interval)
% choosePlayer(+PlayerOne, +PlayerTwo, -FirstToPlay)

choosePlayer(PlayerOne, PlayerTwo, FirstToPlay):-
    random(PlayerOne, PlayerTwo, FirstToPlay).

% ======================================================= %

% Change players turns
% changeTurn(+CurrPlayer, -NextPlayer)



changeTurn(CurrPlayer, NextPlayer):-
    (
    CurrentPlayer =:= 1 
    -> NextPlayer = 2
    ; NextPlayer = 1, incrementTurn(turns, X)
    ).

% ======================================================= %

% Check if a row is valid
% checkRow(+IsValid, -Row)

checkRow(IsValid, Row):-
    repeat,
    read(Number),
    (
       memberchk(Number,[1,2,3,4,5,6,7,8])
    -> IsValid = 'True', Row = Number, !, true
    ; write('Invalid Row\n'), IsValid = 'False'
    ).

% ======================================================= %

%% Getter of a row
% getRow(+Board, +Row, -ReturnRow)

getRow(Board, Row, ReturnRow):-
    nth1(Row, Board, ReturnRow).

% ======================================================= %

% Check if a column is valid
% checkColumn(+IsValid, -Column)

checkColumn(IsValid, Column):-
    repeat,
    read(Number),
    (
       memberchk(Number,[1,2,3,4,5,6,7,8])
    -> IsValid = 'True', Column = Number, !, true
    ; write('Invalid Column\n'), nl, IsValid = 'False'
    ).


% ======================================================= %

auxcopy([],[]).
auxcopy([H|T],[H|T1]):-auxcopy(T,T1).
copy(L1,L2):- auxcopy(L1,L2).

cicleRows(Board, Rows, ColumnNum, L, ReturnColumn, FinalColumn):-
    nth1(Rows, Board, ReturnRow),
    nth1(ColumnNum, ReturnRow, Elem),
    append(L, [Elem], Column),
    C_Aux = Column,
    I is Rows + 1,
    (
        i == 9
        -> copy(Column, FinalColumn), !
        ; cicleRows(Board, I, ColumnNum, Column, C_Aux, FinalColumn)
    ).

% Getter of a column
% getColumn(+Board, +Column, -ReturnColumn)

getColumn(Board, ColumnNum, FinalColumn):-
    loopRows(Board, 1, ColumnNum, [], ReturnColumn, FinalColumn).

% ======================================================= %

% Verify is there is a piece on the desired position
% checkDestinationPiece(+NewRow, +NewColumn, -IsValid)

% ======================================================= %

% Check if there is a piece between the original and destination positions
% checkPieceBetween(+Board, +Origin, +Destination)

checkPieceBetween(Board, Origin, Destination) :-
    getRow(Board, Origin, Row),
    getRow(Board, Destination, DestRow),
    getColumn(Board, Origin, Column),
    getColumn(Board, Destination, DestColumn),
    (
        Origin < Destination
        -> checkPieceBetweenAux(Row, Column, DestRow, DestColumn, 1, 1)
        ; checkPieceBetweenAux(Row, Column, DestRow, DestColumn, -1, -1)
    ).

checkPieceBetweenAux(Row, Column, DestRow, DestColumn, RowInc, ColInc) :-
    NextRow is Row + RowInc,
    NextCol is Column + ColInc,
    (
        NextRow == DestRow, NextCol == DestColumn
        -> true
        ; nth1(NextRow, Board, NextBoardRow),
          nth1(NextCol, NextBoardRow, Piece),
          Piece == empty,
          checkPieceBetweenAux(NextRow, NextCol, DestRow, DestColumn, RowInc, ColInc)
    ).


% ======================================================= %

% length of a list
% list_length(+List, -Length)
% list_length(+List, +Acc, -Length)

list_length(List, Length) :- list_length(List, 0, Length).
list_length([], Length, Length).
list_length([_|List], Acc, Length) :-
    Acc1 is Acc + 1,
    list_length(List, Acc1, Length).

% ======================================================= %

%loopPath(+RowOrColumn, +Origin, +Destination, +CheckInFront, -IsValid)

loopPath(RowOrColumn, Origin, Destination, CheckInFront, IsValid) :-
    (
        CheckInFront == 'True'
    ->  Counter is Origin+1,
        Check_Counter is Destination+1,
        (
            Counter == Check_Counter
        ->  IsValid = 'False', !
        ;   nth1(Counter, RowOrColumn, Element),
            (
                Element == clear
            ->  loopPath(RowOrColumn, Counter, Destination, CheckInFront, IsValid)
            ;   IsValid = 'True', !
            )
        )
    ;   Counter is Origin-1,
        Check_Counter is Destination-1,
        (
            Counter == Check_Counter
        ->  isValid = 'False', !
        ;   nth1(Counter, RowOrColumn, Element),
            (
                Element == clear
            ->  loopPath(RowOrColumn, Counter, Destination, CheckInFront, IsValid)
            ;   IsValid = 'True', !
            )
        )
    ).

% checkPath(+RowOrColumn, +Origin, +Destination, +CheckInFront, -IsValid)

checkPath(RowOrColumn, Origin, Destination, CheckInFront, IsValid):-
    loopPath(RowOrColumn, Origin, Destination, CheckInFront, IsValid),
    (
        IsValid == 'True'
    ->  isValid = 'True', !
    ;   isValid = 'False'
    ).

% ======================================================= %

% check if the move is horizontal
% checkHorizontal(+Column, +Row, -FinalC, +FinalR, -IsValid)

checkHorizontal(Column, Row, FinalC, FinalR, IsValid):-
    (
        Column \= FinalC
    ->  (
        Row == FinalR
        ->  IsValid = 'True'
        ;   IsValid = 'False'
        )
    ;   IsValid = 'False'
    ).

% ======================================================= %

% check if the move is vertical
% checkVertical(+Column, +Row, -FinalC, +FinalR, -IsValid)

checkVertical(Column, Row, FinalC, FinalR, IsValid):-
    (
        Row \= FinalR
    ->  (
        Column == FinalC
        ->  IsValid = 'True'
        ;   IsValid = 'False'
        )
    ;   IsValid = 'False'
    ).

% ======================================================= %

% check if the move is diagonal
% checkDiagonal(+Column, +Row, -FinalC, +FinalR, -IsValid)

checkDiagonal(Column, Row, FinalC, FinalR, IsValid):-
    (
        Row \= FinalR
    ->  (
        Column \= FinalC
        ->  (
            abs(Column - FinalC) == abs(Row - FinalR)
            ->  IsValid = 'True'
            ;   IsValid = 'False'
            )
        ;   IsValid = 'False'
        )
    ;   IsValid = 'False'
    ).

% ======================================================= %

% check if the move is valid
% checkMove(+Board, +InitialColumn, +InitialRow, +FinalColumn, +FinalRow, -IsValid)

checkMove(Board, InitialColumn, InitialRow, FinalColumn, FinalRow, IsValid):-
    checkHorizontal(InitialColumn, InitialRow, FinalColumn, FinalRow, IsHorizontal),
    (
        IsHorizontal == 'True'
    ->  (
            FinalColumn > InitialColumn
        ->  CheckInFront = 'True'
        ;   CheckInFront = 'False'
        ),
        getRow(Board, InitialRow, ReturnRow),
        checkDestinationPiece(ReturnRow, FinalColumn, ValidDestination),
        (
            ValidDestination == 'True'
        ->  IsValid = 'False', !
        ;   checkPath(ReturnRow, InitialColumn, FinalColumn, CheckInFront, ValidPath),
            (
                ValidPath == 'True'
            ->  IsValid = 'True', !
            ;   IsValid = 'False', !
            )
        )
    ;   checkVertical(InitialColumn, InitialRow, FinalColumn, FinalRow, IsVertical),
        (
            IsVertical == 'True'
        ->  (
                FinalRow < InitialRow
            ->  CheckInFront = 'True'
            ;   CheckInFront = 'False'
            ),
            getColumn(Board, InitialColumn, ReturnColumn),
            checkDestinationPiece(ReturnColumn, FinalRow, ValidDestination),
            (
                ValidDestination == 'True'
            ->  IsValid = 'False', !
            ;   checkPath(ReturnColumn, InitialRow, FinalRow, CheckInFront, ValidPath),
                (
                    ValidPath == 'True'
                ->  IsValid = 'False', !
                ;   IsValid = 'True', !
                )
            )
        ;   IsValid = 'False', !
        )
    ).






% ======================================================= %
% ==================== INITIALIZE LISTS ================= %
turns =[].

PointsListBlue = [].
PointsListRed = [].

isValid(true).
isValid(false).

% ======================================================= %

% ===================== TURNS ========================= %

incrementTurn(turns, X) :-
    last(turns, Last),
    X is Last + 1,
    append(turns, [X], new_turns),
    last(new_turns, CurrentTurn),
    FirstRow is 1,
    FirstColumn is 1,
    (
        CurrentTurn =:= 4
        ->  iterateBoard(Board, FirstRow, FirstColumn, Occupation, PointsListRed, NewPointsListRed, PointsListBlue, NewPointsListBlue)
        ;  CurrentTurn =:= 8
        ->  iterateBoard(Board, FirstRow, FirstColumn, Occupation, PointsListRed, NewPointsListRed, PointsListBlue, NewPointsListBlue)
        ;  CurrentTurn =:= 12
        ->  iterateBoard(Board, FirstRow, FirstColumn, Occupation, PointsListRed, NewPointsListRed, PointsListBlue, NewPointsListBlue),
            total_score(NewPointsListRed, NewPointsListBlue, ScoreRed, ScoreBlue),
            write("Red Score: "), write(ScoreRed), nl,
            write("Blue Score: "), write(ScoreBlue), nl,
            (
                ScoreRed > ScoreBlue
                ->  display_winner(1)
                ; ScoreBlue > ScoreRed
                ->  display_winner(2)
                ; ScoreRed == ScoreBlue
                ->  display_winner(3)
            )
    ).


% ======================================================= %

isEmpty(Board, Row, Column) :-
    nth1(Row, Board, RowList),
    nth1(Column, RowList, Value),
    Value == empty.

% ===================== BOARD ITERATION ========================= %


boardCheck(Board, I, J, Occupation) :-
    nth0(I, Board, Row),
    nth0(J, Row, Occupation).


iterateBoard(_, 9, _, PointsListRed, PointsListRed, PointsListBlue, PointsListBlue).  % Base case when we've reached beyond the board

iterateBoard(Board, I, J, PointsListRed, NewPointsListRed, PointsListBlue, NewPointsListBlue) :-
checkRow(isValid, I),
(
        isValid == true
        ->  
        checkColumn(isValid, J),
        (
                isValid == true
                ->  
                boardCheck(Board, I, J, Occupation),
                (
                        Occupation == 1        % 1 is red
                        -> checkPositionPoints(I, J, Points), append(PointsListRed, [Points], TempList),
                        J1 is J + 1,
                        iterateBoard(Board, I, J1, TempList, NewPointsListRed, PointsListBlue, NewPointsListBlue)
                        ; Occupation == 2      % 2 is blue
                        -> checkPositionPoints(I, J, Points), append(PointsListBlue, [Points], TempList),
                        J1 is J + 1,
                        iterateBoard(Board, I, J1, PointsListRed, NewPointsListRed, TempList, NewPointsListBlue)
                        ; Occupation == clear  % clear is empty
                        -> J1 is J + 1,
                        iterateBoard(Board, I, J1, PointsListRed, NewPointsListRed, PointsListBlue, NewPointsListBlue)
                )
                ;   I1 is I + 1,
                J1 is 1,
                iterateBoard(Board, I1, J1, PointsListRed, NewPointsListRed, PointsListBlue, NewPointsListBlue)
        )
        ;   write("Finished iterating through board")
).


% ======================================================= %


% ===================== POINTS ========================= %

checkPositionPoints(Row, Column, Points) :-
    (
        Row == 1 -> Points = 0
        ; Row == 2 -> (
            Column == 1 -> Points = 0
            ; Column == 8 -> Points = 0
            ; Points = 25
        )
        ; Row == 3 -> (
            Column == 1 -> Points = 0
            ; Column == 8 -> Points = 0
            ; Column == 2 -> Points = 25
            ; Column == 7 -> Points = 25
            ; Points = 50
        )
        ; Row == 4 -> (
            Column == 1 -> Points = 0
            ; Column == 8 -> Points = 0
            ; Column == 2 -> Points = 25
            ; Column == 7 -> Points = 25
            ; Column == 3 -> Points = 50
            ; Column == 6 -> Points = 50
            ; Points = 100
        )
        ; Row == 5 -> (
            Column == 1 -> Points = 0
            ; Column == 8 -> Points = 0
            ; Column == 2 -> Points = 25
            ; Column == 7 -> Points = 25
            ; Column == 3 -> Points = 50
            ; Column == 6 -> Points = 50
            ; Points = 100
        )
        ; Row == 6 -> (
            Column == 1 -> Points = 0
            ; Column == 8 -> Points = 0
            ; Column == 2 -> Points = 25
            ; Column == 7 -> Points = 25
            ; Points = 50
        )
        ; Row == 7 -> (
            Column == 1 -> Points = 0
            ; Column == 8 -> Points = 0
            ; Points = 25
        )
        ; Row == 8 -> Points = 0
    ).


% ======================================================= %

% ===================== TOTAL SCORE ========================= %

total_score(PointsListRed, PointsListBlue, ScoreRed, ScoreBlue):-
    sum_list(PointsListRed, ScoreRed),
    sum_list(PointsListBlue, ScoreBlue).

% ======================================================= %


% ===================== SIMPLER TURN COUNTER ========================= %

:- dynamic (roundCount/1).  % initialize the round count to 1
roundCount(1).

incrementRoundCount :-
    retract(roundCount(X)),
    NewCount is X + 1,
    assert(roundCount(NewCount)).

get_round_count(Round) :-
    roundCount(Round).

start_new_round :-
    retract(roundCount(_)),
    assert(roundCount(1)).


/*

At the end of game_loop do
incrementRoundCount

then get_round_count(Round)
    (
        Round == 4
        ->  iterateBoard(Board, FirstRow, FirstColumn, Occupation, PointsListRed, NewPointsListRed, PointsListBlue, NewPointsListBlue)
        ;  Round == 8
        ->  iterateBoard(Board, FirstRow, FirstColumn, Occupation, PointsListRed, NewPointsListRed, PointsListBlue, NewPointsListBlue)
        ;  Round == 12
        ->  iterateBoard(Board, FirstRow, FirstColumn, Occupation, PointsListRed, NewPointsListRed, PointsListBlue, NewPointsListBlue),
            total_score(NewPointsListRed, NewPointsListBlue, ScoreRed, ScoreBlue),
            write("Red Score: "), write(ScoreRed), nl,
            write("Blue Score: "), write(ScoreBlue), nl,
            (
                ScoreRed > ScoreBlue
                ->  display_winner(1)
                ; ScoreBlue > ScoreRed
                ->  display_winner(2)
                ; ScoreRed == ScoreBlue
                ->  display_winner(3)
            )    
    )
*/


% ======================================================= %