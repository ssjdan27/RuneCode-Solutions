main :-
    read_int(A),
    read_int(B),
    S is A + B,
    write(S),
    nl,
    halt.

read_int(N) :-
    skip_spaces(C),
    parse_int(C, 1, 0, N).

skip_spaces(C) :-
    get_code(C0),
    skip_spaces_from(C0, C).

skip_spaces_from(C0, C) :-
    ( C0 =:= 32 ; C0 =:= 10 ; C0 =:= 13 ; C0 =:= 9 ),
    !,
    get_code(Next),
    skip_spaces_from(Next, C).
skip_spaces_from(C, C).

parse_int(45, _, Acc, N) :-
    !,
    get_code(C),
    parse_digits(C, -1, Acc, N).
parse_int(C, Sign, Acc, N) :-
    parse_digits(C, Sign, Acc, N).

parse_digits(C, Sign, Acc, N) :-
    C >= 48,
    C =< 57,
    !,
    NewAcc is Acc * 10 + C - 48,
    get_code(Next),
    parse_digits(Next, Sign, NewAcc, N).
parse_digits(_, Sign, Acc, N) :-
    N is Sign * Acc.

:- initialization(main).