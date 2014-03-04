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


mergeSort([],[]).
mergeSort([A],[A]).
mergeSort([A,B|T],Sorted) :-
    split([A,B|T],L1,L2),
    mergeSort(L1,Sorted1),
    mergeSort(L2,Sorted2),
    merge(Sorted1,Sorted2,Sorted).

split([],[],[]).
split([A],[A],[]).
split([A,B|T],[A|T1],[B|T2]) :-
    split(T,T1,T2).

%merge([],L,L).
%merge(L,[],L).
%merge([A|T1],[B|T2],[A|T3]) :-
%    A =< B,
%    !,
%    merge(T1,[B|T2],T3).
%merge([A|T1],[B|T2],[B|T3]) :-
%    merge([A|T1],T2,T3).

mergeP([],L,L).
mergeP(L,[],L).
mergeP([[X1,Y1,S1,P1]|T1],[[X2,Y2,S2,P2]|T2],[[X1,Y1,S1,P1]|T3]) :-
    P1 =< P2,
    !,
    mergeP(T1,[[X2,Y2,S2,P2]|T2],T3).
mergeP([[X1,Y1,S1,P1]|T1],[[X2,Y2,S2,P2]|T2],[[X2,Y2,S2,P2]|T3]) :-
    mergeP([[X1,Y1,S1,P1]|T1],T2,T3).

mergeS([],L,L).
mergeS(L,[],L).
mergeS([[X1,Y1,S1,P1]|T1],[[X2,Y2,S2,P2]|T2],[[X1,Y1,S1,P1]|T3]) :-
    S1 =< S2,
    !,
    mergeS(T1,[[X2,Y2,S2,P2]|T2],T3).
mergeS([[X1,Y1,S1,P1]|T1],[[X2,Y2,S2,P2]|T2],[[X2,Y2,S2,P2]|T3]) :-
    mergeS([[X1,Y1,S1,P1]|T1],T2,T3).

mergesortP([],[]).
mergesortP([A],[A]).
mergesortP([A,B|T],Sorted) :-
    split([A,B|T],L1,L2),
    mergesortP(L1,Sorted1),
    mergesortP(L2,Sorted2),
    mergeP(Sorted1,Sorted2,Sorted).

mergesortS([],[]).
mergesortS([A],[A]).
mergesortS([A,B|T],Sorted) :-
    split([A,B|T],L1,L2),
    mergesortS(L1,Sorted1),
    mergesortS(L2,Sorted2),
    mergeS(Sorted1,Sorted2,Sorted).

% numList(Minmum,Maximum,PrimeList,CompositeList)
%
% Minmum: 2 or any odd numbers lager than 2.
numList(Min,Max,[],[]) :-
    Min > Max.
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

% get_pcList(PrimeList,CompositeList,ResultList,Limit)
get_pcList([],_,[],_).
get_pcList([H|T],CL,R,Limit) :-
    pcList(H,CL,L,Limit),
    app(L,R1,R),
    get_pcList(T,CL,R1,Limit).
% pcList(PrimeNumber,CompositeList,ResultList,Limit)
pcList(_,[],[],_).
pcList(X,[Y|T],L,Limit) :-
    X + Y > Limit,
    pcList(X,T,L,Limit),
    !.
pcList(X,[Y|T2],[[X,Y,S,P]|T3],Limit) :-
    X < Y,
    !,
    S is X + Y,
    P is X * Y,
    pcList(X,T2,T3,Limit).
pcList(Y,[X|T2],[[X,Y,S,P]|T3],Limit) :-
    S is X + Y,
    P is X * Y,
    pcList(Y,T2,T3,Limit).
% get_ccList(CompositeList,ResultList,Limit)
get_ccList([],[],_).
get_ccList([H|T],R,Limit) :-
    ccList(H,T,L,Limit),
    app(L,R1,R),
    get_ccList(T,R1,Limit).
% ccList(CompositeNumber,CompositeList,ResultList,Limit)
ccList(_,[],[],_).
ccList(X,[Y|T],L,Limit) :-
    X + Y > Limit,
    ccList(X,T,L,Limit),
    !.
ccList(X,[Y|T1],[[X,Y,S,P]|T2],Limit) :-
    S is X + Y,
    P is X * Y,
    ccList(X,T1,T2,Limit).

remove([],[]).
remove([_],[]).
remove([A,A],[A,A]).
remove([A,A,A|T1],[A|T2]) :-
    remove([A,A|T1],T2),
    !.
remove([A,A,B|T1],[A,A|T2]) :-
    remove([B|T1],T2),
    !.
remove([_,B|T],L) :-
    remove([B|T],L).

removeSingle([],[]).
removeSingleP([_],[]).
removeSingleP([[X1,Y1,S1,P],[X2,Y2,S2,P]],[[X1,Y1,S1,P],[X2,Y2,S2,P]]).
removeSingleP([[X1,Y1,S1,P],[X2,Y2,S2,P],[X3,Y3,S3,P]|T1],[[X1,Y1,S1,P]|T2]) :-
    removeSingleP([[X2,Y2,S2,P],[X3,Y3,S3,P]|T1],T2),
    !.
removeSingleP([[X1,Y1,S1,P],[X2,Y2,S2,P],H|T1],[[X1,Y1,S1,P],[X2,Y2,S2,P]|T2]) :-
    removeSingleP([H|T1],T2),
    !.
removeSingleP([_,H|T],L) :-
    removeSingleP([H|T],L).

removeSingleS([],[]).
removeSingleS([_],[]).
removeSingleS([[X1,Y1,S,P1],[X2,Y2,S,P2]],[[X1,Y1,S,P1],[X2,Y2,S,P2]]).
removeSingleS([[X1,Y1,S,P1],[X2,Y2,S,P2],[X3,Y3,S,P3]|T1],[[X1,Y1,S,P1]|T2]) :-
    removeSingleS([[X2,Y2,S,P2],[X3,Y3,S,P3]|T1],T2),
    !.
removeSingleS([[X1,Y1,S,P1],[X2,Y2,S,P2],H|T1],[[X1,Y1,S,P1],[X2,Y2,S,P2]|T2]) :-
    removeSingleS([H|T1],T2),
    !.
removeSingleS([_,H|T],L) :-
    removeSingleS([H|T],L).

s1_noSort(Q,Limit) :-
    numList(2,Limit,P,C),
    get_pcList(P,C,L1,Limit),
    get_ccList(C,L2,Limit),
    app(L1,L2,Q).

s1(Q,Limit) :-
    s1_noSort(L1,Limit),
    mergesortP(L1,L2),
    removeSingleP(L2,L3),
    mergesortS(L3,Q).


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

s2_filter([],[],_).
s2_filter([[_,_,S,_]|T],L,Max) :-
    is_prime(S - 2),
    !,
    s2_filter(T,L,Max). 
s2_filter([[X,Y,S,P]|T1],[[X,Y,S,P]|T2],Max) :-
    S mod 2 =:= 1,
    S =< Max,
    !,
    s2_filter(T1,T2,Max).
s2_filter([_|T],L,Max) :-
    s2_filter(T,L,Max). 

s2_noSort(Q,Limit) :-
    next_prime(Limit//2,Max),
    s1_noSort(L,Limit),
    s2_filter(L,Q,Max).

s2(Q,Limit) :-
    s2_noSort(L1,Limit),
    %mergesortP(L1,L2),
    %removeSingleP(L2,L3),
    %mergesortP(L3,L4),
    %removeSingleS(L4,Q).
    mergesortP(L1,Q).




%factorize_P(P,X,[],_) :-
%    X * X > P,
%    !.
%factorize_P(P,X,[[X,Y]|T],Limit) :-
%    P mod X =:= 0,
%    Y is P / X,
%    X + Y =< Limit,
%    !,    
%    X1 is X + 1,
%    factorize_P(P,X1,T,Limit). 
%factorize_P(P,X,L,Limit) :-
%    X1 is X + 1,
%    factorize_P(P,X1,L,Limit). 
%
%is_multiP(_,2) :-
%    !.
%is_multiP([_|T],Acc) :-
%    Acc1 is Acc + 1,
%    is_multiP(T,Acc1).
%
%filter_P([],[],_).
%filter_P([H|T],L,Limit) :-
%    factorize_P(H,2,R,Limit),
%    is_multiP(R,0),
%    !,
%    app(R,L2,L),
%    filter_P(T,L2,Limit).
%filter_P([_|T],L,Limit) :-
%    filter_P(T,L,Limit).
%
%s1_noSort(Q,Limit) :-
%    numList(2,62250,_,C),
%    filter_P(C,Q,Limit).

