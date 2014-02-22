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

% next_prime(Number,NextPrime)
%
% NextPrime will be the 1st prime occurs after Number.
next_prime(P,P1) :-
    P1 is P + 1,
    is_prime(P1),
    !.
next_prime(P,P1) :-
    P2 is P + 1,
    next_prime(P2,P1).

% sortP







%  numList(Minmum,Maximum,PrimeList,CompositeList)
%
%  Minmum: 2 or any odd numbers lager than 2.
%
%numList(Min,Max,[],[]) :-
%    Min > Max,
%    !.
%numList(2,Max,[2|T],L) :-
%    numList(3,Max,T,L),
%    !.
%numList(Min,Max,[Min|T],[Min1|T1]) :-
%    is_prime(Min),
%    !,
%    Min1 is Min + 1,
%    Min2 is Min + 2,
%    numList(Min2,Max,T,T1).
%numList(Min,Max,L,[Min|[Min1|T]]) :-
%    Min1 is Min + 1,
%    Min2 is Min + 2,
%    numList(Min2,Max,L,T).
    
%s1XY([X,Y,S,P],PL,CL,Limit) :-
%    member(X,PL),
%    X =< Limit//2,
%    member(Y,CL),
%    X < Y,
%    S is X + Y,
%    S =< Limit,
%    P is X * Y.
%
%s1XY([X,Y,S,P],_,CL,Limit) :-
%    member(X,CL),
%    X =< Limit//2,
%    member(Y,CL),
%    X < Y,
%    S is X + Y,
%    S =< Limit,
%    P is X * Y.
%
%
%s1_List([],_,_,_,_).
%s1_List([X|_],_,_,_,Limit) :- 
%    X > Limit//2,
%    !.
%s1_List([X|PL],[Y|CL],Acc,[[X,Y,S,P]|T],Limit) :-
%    X < Y,
%    S is X + Y,
%    S =< Limit,
%    P is X * Y,
%    !,
%    s1_List([X|PL],CL,[Y|Acc],T,Limit).
%
%s1_List([X|PL],[Y|CL],Acc,L,Limit) :-
%    s1_List([X|PL],CL,[Y|Acc],L,Limit),
%    !.
%
%s1_List([_|PL],[],Acc,L,Limit) :-
%    s1_List(PL,Acc,[],L,Limit).
%
%
%s1X(Min,Max,[]) :- Min >= Max-1, !.
%s1X(Min,Max,[X|T]) :-
%    X is Min + 1,
%    s1X(X,Max,T).

% s1 starts here.
% ------------------------------------------------------------------------------
% s1 will sort out all possilble X and Y, where:
%   1. X and Y can not be both prime;
%   2. S =< Max, where Max is the next prime of Limit/2:
%      Reason: if S > Max, suppose: 
%              X = N, Y = Max, so S = Max + N, P = Max * N:
%              - if N is prime, not satisfied (1);
%              - if N is not prime, N = A * B (1 < A < B):
%                P = Max * (A * B),
%                A * Max >= P,
%                so the only answser will be: X = N, Y = Max.


% s1_splitSum(ResultList,MinX,MinSum,Limit)
% 
% Increase MinSum from MinSum to Limit, for each
% MinSum, find possible X and Y, where:
%   S =< Limit,
%   S = X + Y,
%   X < Y,
%   X and Y cannot be both primes. 
s1_splitSum([],_,S,Limit) :-
    next_prime(Limit//2, Max),
    S > Max,
    !.
s1_splitSum(L,X,S,Limit) :-
    X >= S/2,
    !,
    S1 is S + 1,
    s1_splitSum(L,2,S1,Limit).
s1_splitSum(L,X,S,Limit) :-
    Y is S - X,
    is_prime(X),
    is_prime(Y),
    !,
    X1 is X + 1,
    s1_splitSum(L,X1,S,Limit).
s1_splitSum([[X,Y,S,P]|T],X,S,Limit) :-
    Y is S - X,
    X1 is X + 1,
    P is X * Y,
    s1_splitSum(T,X1,S,Limit).

% s1(ResulitList,Limit)
% Generate a list which satisfied (a)
s1(Q,Limit) :-
    s1_splitSum(Q,2,6,Limit).


% s2 starts here.
% ------------------------------------------------------------------------------
% s2 will sort out all possilble X and Y, where:
%   1. S cannot be expressed as a sum of two primes.
    
%prime_addends(Num,Acc) :-
%    R is Num - Acc,
%    is_prime(Acc),
%    is_prime(R),
%    !.
%prime_addends(Num,Acc) :-
%    Acc < Num/2,
%    Acc1 is Acc + 1,
%    prime_addends(Num,Acc1).


% s2_sumList(SmallestOdd,Limit,SumList)
%
% Sum =\= (prime + prime) :
%   1. odd number only - Goldbach conjecture;
%   2. (Sum - 2) must not be a prime;
%      Reason: - Sum = odd + even;
%              - the even number can be 2, which is a prime.
%                Therefore the odd number must not be a
%                prime.
%   3. S =< Max, where Max is the next prime of Limit/2 - according to s1.
s2_sumList(Odd,Limit,[]) :- 
    next_prime(Limit//2,Max),
    Odd > Max,
    !.
s2_sumList(Odd,Limit,L) :-
    Odd1 is Odd - 2,
    is_prime(Odd1),
    !,
    Odd2 is Odd + 2,
    s2_sumList(Odd2,Limit,L).
s2_sumList(Odd,Limit,[Odd|T]) :-
    Odd1 is Odd + 2,
    s2_sumList(Odd1,Limit,T).

% s2_splitSum(ResultList,MinX,SumList)
% 
% Almost same as s1_splitSum.
% s2_splitSum will split the Sum in SumList into 2
% numbers where they are not both primes.
s2_splitSum([],_,[]).
s2_splitSum(L,X,[S|T]) :-
    X >= S/2,
    !,
    s2_splitSum(L,2,T).
s2_splitSum(L,X,[S|T]) :-
    Y is S - X,
    is_prime(X),
    is_prime(Y),
    !,
    X1 is X + 1,
    s2_splitSum(L,X1,[S|T]).
s2_splitSum([[X,Y,S,P]|T1],X,[S|T2]) :-
    Y is S - X,
    X1 is X + 1,
    P is X * Y,
    s2_splitSum(T1,X1,[S|T2]).

% s2(ResulitList,Limit)
% Generate a list which satisfied (b)
s2(Q,Limit) :-
    s2_sumList(5,Limit,L),
    s2_splitSum(Q,2,L).



%split(_,[],[],[]).
%split(P,[H|T],[H|Small],Big) :-
%    H < P,
%    !,
%    split(P,T,Small,Big).
%split(P,[H|T],Small,[H|Big]) :-
%    split(P,T,Small,Big).
%
%splitSum(_,[],[],[]).
%splitSum([_,_,S1,_],[[X,Y,S,P]|T],[[X,Y,S,P]|Small],Big) :-
%    S < S1,
%    !,
%    splitSum([_,_,S1,_],T,Small,Big).
%splitSum(P,[H|T],Small,[H|Big]) :-
%    splitSum(P,T,Small,Big).
%
%sortSum([],[]).
%sortSum([H|T],Sorted) :-
%    splitP(H,T,Small,Big),
%    sortSum(Small,SortedSmall),
%    sortSum(Big,SortedBig),
%    append(SortedSmall,[H|SortedBig],Sorted).
%
%splitP(_,[],[],[]).
%splitP([_,_,_,P1],[[X,Y,S,P]|T],[[X,Y,S,P]|Small],Big) :-
%    P > P1,
%    !,
%    splitP([_,_,_,P1],T,Small,Big).
%splitP(P,[H|T],Small,[H|Big]) :-
%    splitP(P,T,Small,Big).

%s11(Q,Limit) :-
%    numList(2,Limit,PL,CL),
%    findall(R,s1XY(R,PL,CL,Limit),Q).
%
%s12(Q,Limit) :-
%    numList(2,Limit,PL,CL),
%    findall(R,s1XY(R,PL,CL,Limit),L),
%    sortSum(L,Q).

