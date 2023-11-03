%:- consult('game.pl')

print_menu :-
    nl,nl,nl,
    print(' ============================================ '), nl,
    print('|                   TRAXIT                   |'), nl,
    print('|============================================|'), nl,
    print('|                                            |'), nl,
    print('|                 1 - Play                   |'), nl,
    print('|                 2 - How to play            |'), nl,
    print('|                 3 - Exit                   |'), nl,
    print('|                                            |'), nl,
    print('|____________________________________________|'), nl.

menu_option(3).
menu_option(1):- play_menu.
menu_option(2):- print_how_to_play.


print_play_menu:-
    nl,nl,nl,
    print(' ============================================ '), nl,
    print('|                    PLAY                    |'), nl,
    print('|============================================|'), nl,
    print('|                                            |'), nl,
    print('|           1 - Player vs Player             |'), nl,
    print('|           2 - Player vs BOT                |'), nl,
    print('|           3 - BOT vs BOT                   |'), nl,
    print('|           4 - BOT vs Player                |'), nl,
    print('|           5 - Back                         |'), nl,
    print('|                                            |'), nl,
    print('|____________________________________________|'), nl.

play_option(5) :- play.
play_option(1) :- start_game(1).
play_option(2) :- start_game_2(1).
play_option(3) :- start_game_3(1).
play_option(4) :- start_game_4(1).


print_bot_menu:-
    nl,nl,nl,
    print(' ============================================ '), nl,
    print('|                     BOT                    |'), nl,
    print('|============================================|'), nl,
    print('|                                            |'), nl,
    print('|               1 - Level 1                  |'), nl,
    print('|               2 - Level 2                  |'), nl,
    print('|               4 - Back                     |'), nl,
    print('|                                            |'), nl,
    print('|____________________________________________|'), nl.

ai_option(3) :- play_menu.
ai_option(1) :- start_game(1).
ai_option(2) :- start_game(2).

print_how_to_play:-
    nl,nl,nl,
    print(' ============================================ '), nl,
    print('|                 HOW TO PLAY                |'), nl,
    print('|============================================|'), nl,
    print('|                                            |'), nl,
    print('|  Each player has 2 pawns and 16 path tiles |'), nl,
    print('|                                            |'), nl,
    print('|  Each of the 16 path tiles are unique      |'), nl,
    print('|                                            |'), nl,
    print('|  Chose a path tile that, after use, is     |'), nl,
    print('| discarded                                  |'), nl,
    print('|                                            |'), nl,
    print('|  You cant move through other pawns, nor    |'), nl,
    print('| outside the board, and if you cant move    |'), nl,
    print('| at all, your pawn is moved to the lowest   |'), nl,
    print('| level corner                               |'), nl,
    print('|____________________________________________|'), nl,
    print_menu,
    read(Input),
    menu_option(Input).


play :-
    print_menu,
    read(Input),
    menu_option(Input).

play_menu :-
    print_play_menu,
    read(Input),
    play_option(Input).

bot_menu :-
    print_bot_menu,
    read(Input),
    ai_option(Input).
