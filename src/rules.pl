:- use_module(library(random)).
:- use_module(library(lists)).
:- consult('board.pl').

% Choose a random player to start
% PlayerOne is 1 and PlayerTwo is 3 (because the upperbound is not included in the interval)
% choosePlayer(+PlayerOne, +PlayerTwo, -FirstToPlay)

choosePlayer(PlayerOne, PlayerTwo, FirstToPlay):-
    random(PlayerOne, PlayerTwo, FirstToPlay).

% -----------------------------------------------

% Change players turns
% changeTurn(+CurrPlayer, -NextPlayer)

changeTurn(CurrPlayer, NextPlayer):-
    (
    CurrentPlayer =:= 1 
    -> NextPlayer = 2
    ; NextPlayer = 1
    ).

% -----------------------------------------------

% Check if the row is valid
% checkRow(+IsValid, -Row)

checkRow(IsValid, Row):-
    repeat,
    read(Number),
    (
       memberchk(Number,[0,1,2,3,4,5,6,7])
    -> IsValid = 'True', Row = Number, !, true
    ; write('Invalid Row\n'), IsValid = 'False'
    ).