:- use_module(library(system)).
:- use_module(library(lists)).
:- use_module(library(random)).

:- consult('rules.pl').
:- consult('display.pl').

% --------------------------------- %

% check the starting position of the piece

check_starting_position(Board, Column, Row, Player) :-
    write('Choose a piece to move: '),
    write('Column:\n'),
    checkColumn(ValidColumn, InputColumn),
    write('Row:\n'),
    checkRow(ValidRow, InputRow),

    nth1(InputRow, Board, RowList),
    nth1(InputColumn, RowList, Piece),
    (
        Piece == Player
    -> ValidRow = Row,
       ValidColumn = Column, !, true
    ;  write('Invalid piece!\n'),
       check_starting_position(Board, Column, Row, Player)
     ).

% --------------------------------- %

% Check 