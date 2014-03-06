/*<lz474, Lei Zeng>


*/

% is_prime(Number)
%
% Number: any number, true if it is a prime.

getn([_|T],R,N) :-
    Rnew is R + 1,
    getn(T,Rnew,N).
getn([],R,R).
counts1(Limit,N) :-
    s1(Q,Limit),
    getn(Q,0,N).
counts2(Limit,N) :-
    s2(Q,Limit),
    getn(Q,0,N).
counts3(Limit,N) :-
    s3(Q,Limit),
    getn(Q,0,N).

% is_prime(Num)
%
% true is Num is prime.
is_prime(2).
is_prime(3).
is_prime(Num) :-
    Num > 3,
    Num mod 2 =\= 0,
    no_factor(Num, 3).

% no_factor(Number,Factor)
%
% Number: odd number only
% Factor: the smallest factor of the Number,
%         smaller than sqrt of the Number. 
no_factor(Num,F) :-
    F * F > Num,
    !.
no_factor(Num,F) :-
    Num mod F =\= 0,
    F1 is F + 2,
    no_factor(Num,F1).

% smallest_factor(Num,SmallestPossibleFactor,Factor) :-
%
% Factor: the smallest factor of Num. 
smallest_factor(Num,F,F) :-
    Num mod F =:= 0,
    !.
smallest_factor(Num,F,R) :-
    F * F < Num,
    F1 is F + 1,
    smallest_factor(Num,F1,R).

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


% app(FirstList,SecondList,List)
%
% List = FirstList + SecondList
app([],L,L).
app([E|T],L,[E|M]) :-
    app(T,L,M).

% mem(Element,List)
%
% Check if Element is in List
mem(X,[X|_]).
mem(X,[_|T]) :-
    mem(X,T).


%% dupList(InputList,DuplicateList)
%%
%% DuplicateList: a List shows the duplicate item of InputList
%dupList([],[]).
%dupList([H|T1],[H|T2]) :-
%    mem(H,T1),
%    !,
%    dupList(T1,T2).
%dupList([_|T1],L) :-
%    dupList(T1,L).
%
%% filterMultiP(OriginalList,FilterList,ResultList)
%%
%% only elements with P which shows only once are allowed
%filterMultiP([],_,[]).
%filterMultiP([[_,_,_,P]|T],L1,L2) :-
%    mem(P,L1),
%    !,
%    filterMultiP(T,L1,L2).
%filterMultiP([H|T1],L,[H|T2]) :-
%    filterMultiP(T1,L,T2).
%
%% removeMultiS(OriginalList,FilterList,ResultList)
%%
%% only elements with S which shows only once are allowed
%removeMultiS([],_,[]).
%removeMultiS([[_,_,S,_]|T],L1,L2) :-
%    mem(S,L1),
%    !,
%    removeMultiS(T,L1,L2).
%removeMultiS([H|T1],L,[H|T2]) :-
%    removeMultiS(T1,L,T2).

% quicksortP(List,SortedList)
%
% 1. split List into Small List and Big List 
% first element of list will be the pivot;
% 2. sort the Small List and Big List;
% 3. do it recursively until all elements are sorted.
quicksortP([],[]).
quicksortP([H|T],Sorted) :-
    splitP(H,T,Small,Big),
    quicksortP(Small,SortedSmall),
    quicksortP(Big,SortedBig),
    app(SortedSmall,[H|SortedBig],Sorted).

% splitP(Head,Tail,Small,Big)
%
% ListToSplit = [Head|Tail]
% Small = [All elements that smaller than Head]
% Big = [All elements that bigger than Head]
splitP(_,[],[],[]).
splitP([X,Y,S,P],[[X1,Y1,S1,P1]|T],[[X1,Y1,S1,P1]|Small],Big) :-
    P > P1,
    !,
    splitP([X,Y,S,P],T,Small,Big).
splitP([X,Y,S,P],[[X1,Y1,S1,P1]|T],Small,[[X1,Y1,S1,P1]|Big]) :-
    splitP([X,Y,S,P],T,Small,Big).

% quicksortS(List,SortedList)
%
% Same logic as quicksortP.
quicksortS([],[]).
quicksortS([H|T],Sorted) :-
    splitS(H,T,Small,Big),
    quicksortS(Small,SortedSmall),
    quicksortS(Big,SortedBig),
    app(SortedSmall,[H|SortedBig],Sorted).

% splitS(Head,Tail,Small,Big)
%
% same logic as quicksortP
splitS(_,[],[],[]).
splitS([X,Y,S,P],[[X1,Y1,S1,P1]|T],[[X1,Y1,S1,P1]|Small],Big) :-
    S > S1,
    !,
    splitS([X,Y,S,P],T,Small,Big).
splitS([X,Y,S,P],[[X1,Y1,S1,P1]|T],Small,[[X1,Y1,S1,P1]|Big]) :-
    splitS([X,Y,S,P],T,Small,Big).

% removeSingleP(InputList,ResultList)
%
% ResultList: remove all elements with P occurs only once.
removeSingleP([],[]).
removeSingleP([[X,Y,S,P]|T],L1) :-
    mem([_,_,_,P],T),
    !,
    collect_P(P,[[X,Y,S,P]|T],NewT,R),
    app(R,L2,L1),
    removeSingleP(NewT,L2).
removeSingleP([_|T],L) :-
    removeSingleP(T,L).

% collect_P(Product,List,NewList,Result)
%
% NewList: List of elements without P = Product;
% Result: List of elements with P = Product.
collect_P(_,[],[],[]).
collect_P(P,[[X,Y,S,P]|T1],L,[[X,Y,S,P]|T2]) :-
    !,
    collect_P(P,T1,L,T2).
collect_P(P,[H|T1],[H|T2],L) :-
    collect_P(P,T1,T2,L).

% removeMultiP(InputList,ResultList)
%
% ResultList: remove all elements with P occurs more that once.
removeMultiP([],[]).
removeMultiP([[_,_,_,P]|T],L1) :-
    mem([_,_,_,P],T),
    !,
    delete_P(P,T,L2),
    removeMultiP(L2,L1).
removeMultiP([H|T1],[H|T2]) :-
    removeMultiP(T1,T2).

% removeMultiS(InputList,ResultList)
%
% ResultList: remove all elements with S occurs more that once.
removeMultiS([],[]).
removeMultiS([[_,_,S,_]|T],L1) :-
    mem([_,_,S,_],T),
    !,
    delete_S(S,T,L2),
    removeMultiS(L2,L1).
removeMultiS([H|T1],[H|T2]) :-
    removeMultiS(T1,T2).

% delete_P(Product,List,Result)
%
% Result: List of elements without P = Product.
delete_P(_,[],[]).
delete_P(P,[[_,_,_,P]|T],L) :-
    !,
    delete_P(P,T,L).
delete_P(P,[H|T1],[H|T2]) :-
    delete_P(P,T1,T2).

% delete_S(Sum,List,Result)
%
% Result: List of elements without S = Sum.
delete_S(_,[],[]).
delete_S(S,[[_,_,S,_]|T],L) :-
    !,
    delete_S(S,T,L).
delete_S(S,[H|T1],[H|T2]) :-
    delete_S(S,T1,T2).

% s1 starts here.
% ------------------------------------------------------------------------------
% s1 will sort out all possilble X and Y, where:
%   1. X and Y can not be both prime;
%   2. If Y is prime:
%      Y < next prime of Limit//2.
%      Reason: X is not prime so it has factor F, Y * F > Limit.
%   3. If Y is not prime:
%      X * F < Limit, F is the smallest factor of Y.
%      Reason: if X * F > Limit, there will be only one answer.

% s1_splitSum(ResultList,MinX,MinSum,Limit)
% 
% Increase MinSum from MinSum to Limit, for each
% MinSum, find possible X and Y, where:
%   S =< Limit,
%   S = X + Y,
%   X < Y,
%   X and Y cannot be both primes. 
s1_splitSum([],_,S,Limit) :-
    S > Limit,
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
% P^3
s1_splitSum(L,X,S,Limit) :-
    is_prime(X),
    Y is S - X,
    X * X =:= Y,
    !,
    X1 is X + 1,
    s1_splitSum(L,X1,S,Limit).
% P^4
s1_splitSum(L,X,S,Limit) :-
    is_prime(X),
    Y is S - X,
    X * X * X =:= Y,
    !,
    X1 is X + 1,
    s1_splitSum(L,X1,S,Limit).
s1_splitSum(L,X,S,Limit) :-
    Y is S - X,
    is_prime(Y),
    next_prime(Limit//2,Max),
    Y >= Max,
    !,
    X1 is X + 1,
    s1_splitSum(L,X1,S,Limit).
% P C
s1_splitSum(L,X,S,Limit) :-
    is_prime(X),
    Y is S - X,
    smallest_factor(Y,2,F),
    X * F + Y >= Limit,
    !,
    X1 is X + 1,
    s1_splitSum(L,X1,S,Limit).
% C C
%s1_splitSum(L,X,S,Limit) :-
%    Y is S - X,
%    smallest_factor(X,2,F1),
%    smallest_factor(Y,2,F2),
%    X * F2 / F1 + Y * F1 / F2 > Limit,
%    !,
%    X1 is X + 1,
%    s1_splitSum(L,X1,S,Limit).
%s1_splitSum(L,X,S,Limit) :-
%    Y is S - X,
%    smallest_factor(Y,2,F),
%    X * F + Y >= Limit,
%    !,
%    X1 is X + 1,
%    s1_splitSum(L,X1,S,Limit).
s1_splitSum([[X,Y,S,P]|T],X,S,Limit) :-
    Y is S - X,
    X1 is X + 1,
    P is X * Y,
    s1_splitSum(T,X1,S,Limit).

% s1(ResulitList,Limit)
% Generate a list which satisfied (a)
s1(Q,Limit) :-
    s1_splitSum(Q,2,6,Limit).

s1_test(Q,Limit) :-
    s1t_splitSum(L,2,6,Limit),
    %removeSingleP(L,Q).
    quicksortP(L,Q).

s1_result(Limit,Diff) :-
    s1(L1,Limit),
    s1_test(L2,Limit),
    s1_diff(L2,L1,Diff).

s1_diff([],_,[]).
s1_diff([H|T],L,R) :-
    mem(H,L),
    !,
    s1_diff(T,L,R).
s1_diff([H|T1],L,[H|T2]) :-
    s1_diff(T1,L,T2).

s1t_splitSum([],_,S,Limit) :-
    S > Limit,
    !.
s1t_splitSum(L,X,S,Limit) :-
    X >= S/2,
    !,
    S1 is S + 1,
    s1t_splitSum(L,2,S1,Limit).
s1t_splitSum(L,X,S,Limit) :-
    Y is S - X,
    is_prime(X),
    is_prime(Y),
    !,
    X1 is X + 1,
    s1t_splitSum(L,X1,S,Limit).
s1t_splitSum([[X,Y,S,P]|T],X,S,Limit) :-
    Y is S - X,
    X1 is X + 1,
    P is X * Y,
    s1t_splitSum(T,X1,S,Limit).
% s1 new
%
%next_factor(_,2,3) :- !.
%next_factor(Num,F,NF) :-
%    F * F < Num,
%    !,
%    NF is F + 2.
%next_factor(Num,_,Num).
%
%prime_factors([],1,_) :- !.
%prime_factors([F|T],Num,F) :-
%    Num mod F =:= 0,
%    R is Num / F,
%    !,
%    prime_factors(T,R,F).
%prime_factors(L,Num,F) :-
%    next_factor(Num,F,NF),
%    prime_factors(L,Num,NF).
%
%len([],Len,Len).
%len([_|T],Len,Acc) :-
%    Acc1 is Acc + 1,
%    len(T,Len,Acc1).
%
%s1_noSort([],Limit,Limit) :- !.
%s1_noSort([H|T],Limit,Acc) :-
%    prime_factors(H,Acc,2),
%    Acc1 is Acc + 1,
%    s1_noSort(T,Limit,Acc1).




% s2 starts here.
% ------------------------------------------------------------------------------
% s2 will sort out all possilble X and Y, where:
%   1. S is odd number only - Goldbach conjecture
%   2. S =< Max, where Max is the next prime of Limit//2:
%      Reason: if S > Max, suppose: 
%              X = N, Y = Max, so S = Max + N, P = Max * N:
%              - if N is prime, not satisfied (1);
%              - if N is not prime, N = A * B (1 < A < B):
%                P = Max * (A * B),
%                A * Max >= P,
%                so the only answser will be: X = N, Y = Max.
%   3. (Sum - 2) must not be a prime;
%      Reason: - Sum = odd + even;
%              - the even number can be 2, which is a prime.
%                Therefore the odd number must not be a
%                prime.
%   4. S =\= Prime + Prime
    
% s2_filterMultiS(InputList,ResultList)
%
% ResultList: all possible answser according to description above.
s2_filterMultiS([],[],_).
s2_filterMultiS([[_,_,S,_]|T1],L,Limit) :-
    S mod 2 =:= 0,
    !,
    s2_filterMultiS(T1,L,Limit).
s2_filterMultiS([[_,_,S,_]|T1],L,Limit) :-
    next_prime(Limit//2,Max),
    S > Max,
    !,
    s2_filterMultiS(T1,L,Limit).
s2_filterMultiS([[_,_,S,_]|T1],L,Limit) :-
    S1 is S - 2,
    is_prime(S1),
    !,
    s2_filterMultiS(T1,L,Limit).
s2_filterMultiS([H|T1],[H|T2],Limit) :-
    s2_filterMultiS(T1,T2,Limit).
    
% s2_noSort(List,Limit)
%
% List: a list which satified (b)
s2_noSort(Q,Limit) :-
    s1(L,Limit),
    s2_filterMultiS(L,Q,Limit).

% s2(ResulitList,Limit)
%
% Generate a list which satisfied (b),
% and sorted by ascending values of P.
s2(Q,Limit) :-
    s2_noSort(L,Limit),
    quicksortP(L,Q).

% s3 starts here.
% ------------------------------------------------------------------------------
% s3 will sort out all possilble X and Y, where:
%   1. P only occurs once in s2


% s3_noSort(List,Limit)
%
% List: a list which satified (b)
s3_noSort(Q,Limit) :-
    s2_noSort(L,Limit),
    removeMultiP(L,Q).

% s3(ResulitList,Limit)
%
% Generate a list which satisfied (x),
% and sorted by ascending values of S.
s3(Q,Limit) :-
    s3_noSort(L,Limit),
    quicksortS(L,Q).

% s4 starts here.
% ------------------------------------------------------------------------------
% s4 will sort out all possilble X and Y, where:
%   1. S only occurs once in s3


s4(Q,Limit) :-
    s3_noSort(L,Limit),
    removeMultiS(L,Q).

