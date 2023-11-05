:- use_module(library(system)).
:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(between)).

:- consult('rules.pl').
:- consult('display.pl').

:- dynamic list_indexes/1.

% ======================================================= %

% list of the cards and their paths

%red cards
cards([
    [1, [[4,2], [4,-2], [-4,2], [-4,-2], [2,4], [2,-4], [-2,4], [-2,-4]]],
    [2, [[3,0], [-3,0], [0,3], [0,-3]]],
    [3, [[3,-1], [3,1], [-3,-1], [-3,1], [1,3], [1,-3], [-1,3], [-1,-3]]],
    [4, [[3,-1], [3,1], [-3,-1], [-3,1], [1,3], [1,-3], [-1,3], [-1,-3]]],
    [5, [[4,0], [-4,0], [0,4], [0,-4]]],
    [6, [[3,2], [3,-2], [-3,2], [-3,-2], [2,3], [2,-3], [-2,3], [-2,-3]]],
    [7, [[3,-1], [3,1], [-3,-1], [-3,1], [1,3], [1,-3], [-1,3], [-1,-3]]],
    [8, [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]]],
    [9, [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]]],
    [10, [[2,2], [-2,2], [-2,-2], [2,-2]]],
    [11, [[2,3], [-2,3], [-3,2], [2,-3], [-2,-3], [3,-2], [-3,-2], [3,2]]],
    [12, [[1,1], [-1,1], [-1,-1], [1,-1]]]
    ], 1).


%blue cards
cards([
    [1, [[4,2], [4,-2], [-4,2], [-4,-2], [2,4], [2,-4], [-2,4], [-2,-4]]],
    [2, [[3,0], [-3,0], [0,3], [0,-3]]],
    [3, [[3,-1], [3,1], [-3,-1], [-3,1], [1,3], [1,-3], [-1,3], [-1,-3]]],
    [4, [[3,-1], [3,1], [-3,-1], [-3,1], [1,3], [1,-3], [-1,3], [-1,-3]]],
    [5, [[4,0], [-4,0], [0,4], [0,-4]]],
    [6, [[3,2], [3,-2], [-3,2], [-3,-2], [2,3], [2,-3], [-2,3], [-2,-3]]],
    [7, [[3,-1], [3,1], [-3,-1], [-3,1], [1,3], [1,-3], [-1,3], [-1,-3]]],
    [8, [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]]],
    [9, [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]]],
    [10, [[2,2], [-2,2], [-2,-2], [2,-2]]],
    [11, [[2,3], [-2,3], [-3,2], [2,-3], [-2,-3], [3,-2], [-3,-2], [3,2]]],
    [12, [[1,1], [-1,1], [-1,-1], [1,-1]]]
    ], 2).

% ======================================================= %


% Predicate to select a piece at a specific row and column on the board.
select_piece(Board, Row, Col, Piece) :-
    nth1(Row, Board, BoardRow),  % Select the row using nth1/3
    nth1(Col, BoardRow, Piece).  % Select the element in the row using nth1/3


% Predicate to change the value of a cell at a specific row and column in the board.
change_cell(Board, Row, Col, NewValue, NewBoard) :-
    nth1(Row, Board, OldRow),            % Select the row using nth1/3
    replace(OldRow, Col, NewValue, ModifiedRow),  % Replace the element in the row using replace/4
    replace(Board, Row, ModifiedRow, NewBoard).  % Replace the row in the board using replace/4

% Helper predicate to replace an element in a list at a given position.
replace([_|T], 1, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
    I > 1,
    I1 is I - 1,
    replace(T, I1, X, R).


% Predicate to remove a piece at a specific row and column on the board
remove_piece(Board, Row, Col, NewBoard) :-
    nth1(Row, Board, BoardRow),     % Select the row using nth1/3
    replace(BoardRow, Col, empty, NewRow), % Replace the element in the row using replace/4
    replace(Board, Row, NewRow, NewBoard). % Replace the row in the board using replace/4    

% ======================================================= %

% Predicate to show cards and take away the one that the player chooses


draw_card(Player, [Card | CardsLeft], RemainingCards, Card) :-      % ainda não testei para ver se funciona
    PlayerDeck = [Card | CardsLeft],
    RemainingCards = CardsLeft.

display_card_numbers(Cards) :-
    sleep(0.8),
    write('Your Cards: '),
    display_card_numbers_aux(Cards).

display_card_numbers_aux([]) :- nl.
display_card_numbers_aux([[Number, _] | Rest]) :-
    display_card(Number),
    sleep(0.4),
    display_card_numbers_aux(Rest).


% ======================================================= %
% Predicate to calculate the sum of the coordinates 
sum_coords(Player,Board) :-
    display_board(Board),
    cards(Cards,Player),
    check_starting_position(Board, Column, Row, Player, ReturnRow, ReturnColumn),
    
    display_card_numbers(Cards),
    write('Choose a card to use: \n'),
    read(Id),nl,

    (is_valid_card_number(Id, Cards) ->
        true
    ;
        write('Invalid card number. Please select a valid card.\n'),
        sleep(3),
        sum_coords(Player, Board) % Retry the turn
    ), 
    % what if user does not want to use that card?

    get_card_by_id(Id, Cards, Card),
    write('That Cards Possible Moves:'),nl,
    nl, write(Card),nl,

    nl, write('Final coords can be:'), nl,nl,
    write(' Row   |   Col'),nl,

    initialize_indexes,
    sum_coords_aux(Card, ReturnRow, ReturnColumn, List), nl,
    list_indexes(List),
    reverse(List, FinalList), nl,


    write('Select the desired coordinates: '), read(Number),nl,
   
    nth1(Number, FinalList, FinalCoords),
    write(FinalCoords),nl,
    [FinalRow, FinalColumn] = FinalCoords,


    % (Valid_move(...) -> alterar a lista

    remove_card(Id, Cards, RemainingCards),
    
    player_piece(Piece,Player),

    write(FinalRow),nl,
    write(FinalColumn),nl,

    remove_piece(Board, ReturnRow, ReturnColumn, TempBoard),
    change_cell(TempBoard, FinalRow, FinalColumn, Piece, NewBoard),

    nl,nl,nl,

    (Player = 1 -> NextPlayer = 2 ; NextPlayer = 1),
    sum_coords(NextPlayer,NewBoard).

get_card_by_number(Number, Card,CardId) :-
    nth1(Number, Card, CardId).


% Predicate to obtain the card by its ID
get_card_by_id(Id, [[Id, Coords] | _], Coords) :- !.
get_card_by_id(Id, [_ | Tail], Coords) :-
    get_card_by_id(Id, Tail, Coords).
    
% remove_card(+CardId, +Cards, -RemainingCards)
remove_card(CardId, Cards, RemainingCards) :-
    select([CardId, _], Cards, RemainingCards).


sum_coords_aux([], _, _,_).
sum_coords_aux([[X, Y] | Tail], StartRow, StartCol, Indexs) :-
    NewSumX is StartRow + X,
    NewSumY is StartCol + Y,
    (
        (NewSumX > 0, NewSumX =< 8, NewSumY > 0, NewSumY =< 8)
    ->  write('    [ '), write(NewSumX), write(', '), write(NewSumY), write(']'),nl,
        Coordinates = [NewSumX,NewSumY],
        add_to_list(Coordinates)
    ;   true 
    ),
    sum_coords_aux(Tail, StartRow, StartCol, ValidIndexes).


% ======================================================= %

initialize_indexes :-
    assert(list_indexes([])).

add_to_list(X) :-
    retract(list_indexes(List)),
    assert(list_indexes([X | List])).


% ======================================================= %

% check the starting position of the piece

check_starting_position(Board, Column, Row, Player, ReturnRow, ReturnColumn) :-
    nl, write('Choose a piece to move: '),nl,
    write('\nColumn: '),
    checkColumn(ValidColumn, InputColumn),
    write('\nRow: '),
    checkRow(ValidRow, InputRow),
    nth1(InputRow, Board, RowList),
    nth1(InputColumn, RowList, Piece),
    % convert the user input to
    (
        (Piece == 'r' ; Piece == 'b') ->
        (
            (Piece == 'r'->
                Pieces = 1
            ;   Pieces = 2),

            (Pieces == Player)->
            (
                /*ValidRow = Row,
                ValidColumn = Column, */         % Declarações que estavam a turnar a Col e Row em booleans 
                ReturnColumn is InputColumn,
                ReturnRow is InputRow,
                write('\nYour turn to make a move!\n'), nl
            )
            ;
            write('\nNot your piece! That piece belongs to the other player!\n'),
            write('\nTry again!\n'),
            check_starting_position(Board, Column, Row, Player)
        )
        ;
        write('\nNo piece in that position!\n'),
        check_starting_position(Board, Column, Row, Player)
    ).


% ======================================================= %

% check if the card number is valid

is_valid_card_number(Id, Cards) :-
    member([Id, _], Cards).

% ======================================================= %