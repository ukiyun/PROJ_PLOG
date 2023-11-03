:- use_module(library(system)).
:- consult('board.pl').

% display pieces on the board

write_char(clear) :- write('   ').
write_char(b) :- write(' B ').
write_char(r) :- write(' R ').
write_char(division) :- write('|').

% NÃO TENHO A CERTEZA DESDE DISPLAY, MAS ACHO QUE É ISTO (?)

% Predicate to display the board.
display_board(Board) :- nl,nl,nl,
                        write('    1   2   3   4   5   6   7   8\n'),
                        write('  |-------------------------------|\n'),
                        print_board(Board, 1),
                        nl.

% Predicate to print the board.
print_board([], _).
print_board([Row|Rest], RowNum) :-
    write(RowNum), write(' |'), print_row(Row),write('\n'),write('  |-------------------------------|\n'),
    NextRowNum is RowNum + 1,
    print_board(Rest, NextRowNum).

print_row([]).
print_row([Cell|Rest]) :-
    write_char(Cell), write_char(division),
    print_row(Rest).