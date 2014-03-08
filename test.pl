test(Max,Max,[]) :- !.

test(Min,Max,[H|T]) :-
    Min < Max,
    H is Min + 1,
    test(H,Max,T).
    
t1([],_,S,Acc) :- S > Acc.
t1(L,X,S,Acc) :- 
    X >= S/2,
    !,
    S1 is S + 1,
    t1(L,2,S1,Acc).
t1([[X,Y]|T],X,S,Acc) :-
    Y is S - X,
    X < Y,
    X1 is X + 1,
    t1(T,X1,S,Acc). 

     
t2(X,[X|_]).
t2(X,[_|T]) :-
    t2(X,Tail).
