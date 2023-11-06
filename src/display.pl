:- use_module(library(system)).
:- consult('board.pl').

% display pieces on the board

write_char(empty) :- write('   ').
write_char(b) :- write(' B ').
write_char(r) :- write(' R ').
write_char(division) :- write('|').


player_piece(Piece, Player):-
    (
        Player == 1 
    ->  Piece = r
    ;   Player == 2 
    ->  Piece = b
    ).


% Predicate to display the board.
display_board(Board) :- nl,nl,nl,
                        write('    1   2   3   4   5   6   7   8\n'),
                        write('  |---|---|---|---|---|---|---|---|\n'),
                        print_board(Board, 1),
                        nl.

% Predicate to print the board.
print_board([], _).
print_board([Row|Rest], RowNum) :-
    write(RowNum), write(' |'), print_row(Row),write('\n'),write('  |---|---|---|---|---|---|---|---|\n'),
    NextRowNum is RowNum + 1,
    print_board(Rest, NextRowNum).

print_row([]).
print_row([Cell|Rest]) :-
    write_char(Cell), write_char(division),
    print_row(Rest).


% ======================================================= %


% Displaying the cards with specific paths

display_card(1) :- 
    nl,nl,
    print('[1]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   | X | X |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   | X |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X | X |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl.

display_card(2) :- 
    nl,nl,
    print('[2]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X | X | X | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X |   |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl.

display_card(3) :- 
    nl,nl,
    print('[3]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   | X |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X | X |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl.

display_card(4) :- 
    nl,nl,
    print('[4]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X | X | X | X |   |'), nl,
    print('|---|---|---|---|---|'), nl.

display_card(5) :- 
    nl,nl,
    print('[5]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X | X | X | X | X |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl.

display_card(6) :- 
    nl,nl,
    print('[6]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   | X | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   | X |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl.

display_card(7) :- 
    nl,nl,
    print('[7]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   | X | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X | X |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl.

display_card(8) :- 
    nl,nl,
    print('[8]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   | X | X | X |   |'), nl,
    print('|---|---|---|---|---|'), nl.

display_card(9) :- 
    nl,nl,
    print('[9]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   | X | X | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl.

display_card(10) :- 
    nl,nl,
    print('[10]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   | X |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   | X |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl.

display_card(11) :- 
    nl,nl,
    print('[11]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('| X | X | X | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X |   |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl.

display_card(12) :- 
    nl,nl,
    print('[12]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   | X |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   | X |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl.

display_players_turn(Player):-
    (
        Player == 1
    ->  print(' ____________________________________________ '), nl,
        print('|                                            |'), nl,
        write('|              RED PLAYERS TURN              |'), nl,
        print('|____________________________________________|')
    
    ;   Player == 2
    ->  print(' ____________________________________________ '), nl,
        print('|                                            |'), nl,
        write('|              BLUE PLAYERS TURN             |'), nl,
        print('|____________________________________________|')
    ).


display_current_round(Round):-
    nl,nl,
    print(' ______________________ '), nl,
    print('|                      |'), nl,
    format('         ROUND ~d        ', [Round]), nl, 
    print('|______________________|'),nl,nl.
    

display_winner(Winner):-
    (
        Winner == 1
    ->  print(' ____________________________________________ '), nl,
        print('|                                            |'), nl,
        write('|               RED PLAYER WINS!             |'), nl,
        print('|____________________________________________|')
    
    ;   Winner == 2
    ->  print(' ____________________________________________ '), nl,
        print('|                                            |'), nl,
        write('|               BLUE PLAYER WINS!            |'), nl,
        print('|____________________________________________|')

    ;   Winner == 3
    ->  print(' ____________________________________________ '), nl,
        print('|                                            |'), nl,
        write('|                 ITS A DRAW!                |'), nl,
        print('|____________________________________________|')    
    ).
