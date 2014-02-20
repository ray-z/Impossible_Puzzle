/*<lz474, Lei Zeng>


*/

% is_prime(Number)
%
% Number: any number, true if it is a prime.

is_prime(2).
is_prime(3).
is_prime(Num) :-
    Num > 3,
    Num mod 2 =\= 0,
    \+ has_factor(Num, 3).

%  has_factor(Number,Factor)
%
%  Number: odd number only
%  Factor: the smallest factor of the Number,
%          smaller than sqrt of the Number. 

has_factor(Num,F) :-
    Num mod F =:= 0.
has_factor(Num,F) :-
    F * F < Num,
    F1 is F + 2,
    has_factor(Num,F1).

%  numList(Minmum,Maximum,PrimeList,CompositeList)
%
%  Minmum: 2 or any odd numbers lager than 2.

numList(Min,Max,[],[]) :-
    Min > Max,
    !.
numList(2,Max,[2|T],L) :-
    numList(3,Max,T,L),
    !.
numList(Min,Max,[Min|T],[Min1|T1]) :-
    is_prime(Min),
    !,
    Min1 is Min + 1,
    Min2 is Min + 2,
    numList(Min2,Max,T,T1).
numList(Min,Max,L,[Min|[Min1|T]]) :-
    Min1 is Min + 1,
    Min2 is Min + 2,
    numList(Min2,Max,L,T).
    
s1XY([X,Y,S,P],PL,CL,Limit) :-
    member(X,PL),
    X =< Limit//2,
    member(Y,CL),
    X < Y,
    S is X + Y,
    S =< Limit,
    P is X * Y.

s1XY([X,Y,S,P],_,CL,Limit) :-
    member(X,CL),
    X =< Limit//2,
    member(Y,CL),
    X < Y,
    S is X + Y,
    S =< Limit,
    P is X * Y.

s1(Q,Limit) :-
    numList(2,Limit,PL,CL),
    findall([X,Y,S,P],s1XY([X,Y,S,P],PL,CL,Limit),Q).


