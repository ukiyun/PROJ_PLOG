:- use_module(library(system)).
:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(between)).

:- consult('rules.pl').
:- consult('display.pl').

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
    nth1(Row, Board, OldRow),        % Select the row using nth1/3
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
    replace(BoardRow, Col, '    ', NewRow), % Replace the element in the row using replace/4
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
    check_starting_position(Board, StartCol, StartRow, Player),

    /*  
        por alguma razão o StartRow e o StartCol estão a ser lidos como  _4427 e _4425
        pode ser por causa do check_starting_position ou mesmo do checkRow e checkColumn
        
        
        "StartCol, and StartRow are not instantiated or used further in your code, which may be why 
        they appear as don't care variables (prefixed with underscores). 
        It's a way for Prolog to indicate that these variables are not being used for any purpose.
        If you intend to use these variables, make sure they are properly instantiated 
        within the predicates and that their values are used. 
        If you don't intend to use them, you can safely ignore the presence of the underscores."
    

    */
    
    display_card_numbers(Cards),


    write('Choose a card to use: \n'),
    read(Id),nl,

    get_card_by_id(Id, Cards, Card),
    write('That Cards Possible Moves:'),nl,
    nl, write(Card),nl,

    /*  Escreveste isto por alguma razão?
    write(StartRow),nl,
    write(StartCol),nl,
    */

    nl, write('Final coords can be:'), nl,
    nl, sum_coords_aux(Card, StartRow, StartCol), nl,

    write('Give me a option to rotate:'),read(Number),nl,
    get_card_by_number(Number, Card, CardId),
    write(CardId),
    [X,Y] = CardId,
    FinalRow is StartRow + X,
    FinalCol is StartCol + Y,
    write(FinalRow),nl,
    write(FinalCol),nl,
     
    % (Valid_move(...) -> alterar a lista (retirar a Card) ;  sum_coords(Id,Player)),

    player_piece(Piece,Player),

    remove_piece(Board, StartRow, StartCol, TempBoard),
    change_cell(TempBoard, FinalRow, FinalCol, Piece, NewBoard),

    nl,nl,nl,nl,nl,

    (Player = 1 -> NextPlayer = 2 ; NextPlayer = 1),
    sum_coords(NextPlayer,NewBoard).

get_card_by_number(Number, Card,CardId) :-
    nth1(Number, Card, CardId).


% Predicate to obtain the card by its ID
get_card_by_id(Id, [[Id, Coords] | _], Coords) :- !.
get_card_by_id(Id, [_ | Tail], Coords) :-
    get_card_by_id(Id, Tail, Coords).


% NÃO ESTÁ A FUNCIONAR ALGUM ERRO NO SUM COORDS DE ARITMETICA
%
sum_coords_aux([], _, _).
sum_coords_aux([[X, Y] | Tail], StartRow, StartCol) :-
    NewSumX is StartRow + X,
    NewSumY is StartCol + Y,
    write(NewSumX), write(' '), write(NewSumY),nl,
    sum_coords_aux(Tail, StartRow, StartCol).
    

% ======================================================= %

% check the starting position of the piece

% WORKING LETS FUCKING GOOOOOOOO
check_starting_position(Board, Column, Row, Player) :-
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
                /* ValidRow = Row,
                ValidColumn = Column,*/         % Declarações que estavam a turnar a Col e Row em booleans 
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