:- use_module(library(system)).
:- consult('board.pl').
:- consult('moves.pl')
:- consult('display.pl').

start_game(Level) :-
    initialBoard(Board),
    game_loop(Board, r, 0 ,Level).-

game_loop(Board, _, 24, _) :-
    display_board(Board). % <--- mudar para , quando se acrescentar a outra função
    % Depende de quem tiver mais pontos no fim

/*game_loop(Board, Player, Round, Level) :-
    (Player == r
    ->  initialBoard(Board),
        nl,
        print(' ____________________________________________ '), nl,
        print('|                                            |'), nl,
        print('|              RED PLAYERS TURN              |'), nl,
        print('|____________________________________________|'),
        sum_coords(Player, Board, Cards).
        ).