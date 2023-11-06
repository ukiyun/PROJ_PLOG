:- use_module(library(system)).
:- use_module(library(lists)).
:- consult('board.pl').
:- consult('moves.pl').
:- consult('display.pl').

start_game(Level) :-
    initialBoard(Board),
    cards(RedCards, 1),
    cards(BlueCards, 2),
    game_loop(1, Board, BlueCards, RedCards, 1).

start_game_2(Level) :-
    initialBoard(Board),
    cards(RedCards, 1),
    cards(BlueCards, 2),
    game_loop_2(1, Board, BlueCards, RedCards, 1).
