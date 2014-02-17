/*<lz474, Lei Zeng>


*/

%! True is a number is prime.
%  Check all odd number only.
is_prime(2).
is_prime(3).
is_prime(Num) :-
    Num > 3,
    Num mod 2 =\= 0,
    \+ has_factor(Num, 3).

%! F is the smallest factor of Num.
%  Num will be odd only, so only check odd factor.
%  F must be smaller than the sqrt of Num. 
has_factor(Num,F) :-
    Num mod F =:= 0.
has_factor(Num,F) :-
    F * F < Num,
    F1 is F + 2,
    has_factor(Num,F1).

%! A List of prime numbers in range of Min and Max.
%  Min and Max are included.
%  Min should be 2 or any odd numbers lager than 2.
primeList(Min,Max,[]) :-
    Min > Max,
    !.
primeList(2,Max,[2|T]) :-
    primeList(3,Max,T),
    !.
primeList(Min,Max,[Min|T]) :-
    is_prime(Min),
    !,
    Min1 is Min + 2,
    primeList(Min1,Max,T).
primeList(Min,Max,L) :-
    Min1 is Min + 2,
    primeList(Min1,Max,L).

s1([X,Y,S,P],Limit) :-
    gen(2,Limit,X),
    gen(2,Limit,Y),
    S is X + Y,
    S =< Limit,
    P is X * Y.


    
