list([],0) :- !.
list([N|T],N) :-
    N1 is N - 1,
    list(T,N1).

s1(Q,Limit) :-
    list(Q,1747).

s2(Q,Limit) :-
    list(Q,145).

s3(Q,Limit) :-
    list(Q,86).

s4([[4,13,17,52]],Limit).


list1(Max,L,R):-
    Max > 0,
    Max1 is Max-1,
    list1(Max1,[Max1|L],R).
list1(0,L,L).
