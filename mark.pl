/* This Prolog program marks CM20214/221A 2013/14 CW2 as specified in <http://www.cs.bath.ac.uk/ag/CM20214-20221A/CM20214-21A-CW2-2014.pdf>

v0.1 Alessio Guglielmi (University of Bath)

Instructions:

1) Put the file mark.pl in the same directory as your solution Prolog program, which we suppose is called abc12.pl (where abc12 is your BUCS id).

2) Run SWI-Prolog in that directory and do:

   ?- consult(mark).
   ?- mark('abc12.pl').

The result should be the grade for your solution and an explanation.

In case built-ins are used a manual inspection of the program by the instructor is needed and some marks will be detracted in accordance with the coursework specification.

If Prolog loops or crashes, the most likely cause is the presence of an infinite number of answers. In that case a manual grading will be performed and marks will be subtracted as specified in the coursework specification.

Tip: if you want to check whether a query, say ?- s2(Q,100), admits multiple answers, just perform

   ?- findall(Q,s2(Q,100),L), length(L,N).

If the answer for N is different from 1 (including Prolog looping) then there are multiple answers.

This is an example run on a correct program with a good but not spectacular efficiency in finding the solutions:

   ?- mark('abc12.pl').
   % abc12.pl compiled 0.00 sec, 43 clauses
   Task 1 is solved correctly and with no multiple answers.
   Task 2 is solved correctly and with no multiple answers.
   Task 3 is solved correctly and with no multiple answers.
   Task 4 is solved correctly and with no multiple answers.
   Task 5 is solved correctly and with no multiple answers.
   Task 5 requires 26690812 inferences.
   The grades for tasks 1 to 5 are: 20 + 20 + 20 + 14 + 8 = 82.
   The penalty for multiple answers is 0.
   No built-ins found.
   The coursework grade is 82.
   true.

Please note that I reserve the right to add other built-ins to the list contained in this program. In fact, the specification tells you exactly what you can use, all the rest you can't! There simply are too many possibilities for me to list them all in this program.

Further tips:

1) To run SWI-Prolog with more memory than the default, use something like

   swipl -G32g

on the command line.

2) Use the following to get unabbreviated answers (for lists of quadruples especially):

   ?- set_prolog_flag(toplevel_print_options,[quoted(true), portray(true)]).

A final recommendation: please make sure that your program does not write anything to the display (in other words, don't use write/1 and similar and take care of all the warnings, such as for singleton variables). This is so that there is no interference with the marking program's output.                   */

mark(X) :- consult(X),
           check1(   M1,Mul1),
           check2(   M2,Mul2),
           check3(   M3,Mul3),
           check4(  MP4,Mul4),
           check5(I5,M5,Mul5),
           f(I5,MP5),
           M4 is round(max(0,MP4 - (18 - MP5)/2)),
           write('The grades for tasks 1 to 5 are: '),
           write(M1), write(' + '),
           write(M2), write(' + '),
           write(M3), write(' + '),
           write(M4), write(' + '),
           write(M5), write(' = '), M is M1 + M2 + M3 + M4 + M5,
           write(M ), write('.\n'),
           penalty(Mul1,Mul2,Mul3,Mul4,Mul5,Pen),
           write('The penalty for multiple answers is '), write(Pen),
           write('.\n'),
           read_file_to_codes(X,XC,[]),
           string_codes(XC,XS),
           built-ins(BL),
           check_built_ins(BL,XS,F),
           final_mark(M,Pen,F).

f(X,Y) :- Y is min(18,(12500/X^0.45)).

built-ins(['bagof(',
           'call(',
           'findall(',
           'forall(',
           'setof(',
           '\\+']).

check1(M1,Mul1) :- current_predicate(s1/2),
                   !,
                   findall(QQ1,s1(QQ1,100),LQ1),
                   length(LQ1,S1),
                   [Q1|_] = LQ1,
                   length(Q1,L1),
                   marks1(L1,S1,M1,Mul1).
check1( 0,   0) :-
   write('Task 1 is not solved because predicate s1/2 does not exist.\n').

check2(M2,Mul2) :- current_predicate(s2/2),
                   !,
                   findall(QQ2,s2(QQ2,100),LQ2),
                   length(LQ2,S2),
                   [Q2|_] = LQ2,
                   length(Q2,L2),
                   marks2(L2,S2,M2,Mul2).
check2( 0,   0) :-
   write('Task 2 is not solved because predicate s2/2 does not exist.\n').

check3(M3,Mul3) :- current_predicate(s3/2),
                   !,
                   findall(QQ3,s3(QQ3,100),LQ3),
                   length(LQ3,S3),
                   [Q3|_] = LQ3,
                   length(Q3,L3),
                   marks3(L3,S3,M3,Mul3).
check3( 0,   0) :-
   write('Task 3 is not solved because predicate s3/2 does not exist.\n').

check4(M4,Mul4) :- current_predicate(s4/2),
                   !,
                   findall(QQ4,s4(QQ4,100),LQ4),
                   marks4(LQ4,M4,Mul4).
check4( 0,   0) :-
   write('Task 4 is not solved because predicate s4/2 does not exist.\n').

check5(I5,M5,Mul5) :- current_predicate(s4/2),
                      !,
                      statistics(inferences,B5),
                      findall(QQ5,s4(QQ5,500),LQ5),
                      statistics(inferences,A5),
                      I5 is A5 - B5 - 11,
                      marks5(LQ5,I5,M5,Mul5).
check5( 1, 0,   0) :-
   write('Task 5 is not solved because predicate s4/2 does not exist.\n').

marks1(1747,1,20,0) :-         !,
   write('Task 1 is solved correctly and with no multiple answers.\n').
marks1(1747,N,20,1) :- N >= 1, !,
   write('Task 1 is solved correctly but there are multiple answers.\n').
marks1(   _,1, 0,0) :-         !,
   write('Task 1 is not solved correctly but there are no multiple answers.\n').
marks1(   _,N, 0,1) :- N >= 1   ,
   write('Task 1 is not solved correctly and there are multiple answers.\n').

marks2( 145,1,20,0) :-         !,
   write('Task 2 is solved correctly and with no multiple answers.\n').
marks2( 145,N,20,1) :- N >= 1, !,
   write('Task 2 is solved correctly but there are multiple answers.\n').
marks2(   _,1, 0,0) :-         !,
   write('Task 2 is not solved correctly but there are no multiple answers.\n').
marks2(   _,N, 0,1) :- N >= 1   ,
   write('Task 2 is not solved correctly and there are multiple answers.\n').

marks3(  86,1,20,0) :-         !,
   write('Task 3 is solved correctly and with no multiple answers.\n').
marks3(  86,N,20,1) :- N >= 1, !,
   write('Task 3 is solved correctly but there are multiple answers.\n').
marks3(   _,1, 0,0) :-         !,
   write('Task 3 is not solved correctly but there are no multiple answers.\n').
marks3(   _,N, 0,1) :- N >= 1   ,
   write('Task 3 is not solved correctly and there are multiple answers.\n').

marks4([[[4,13,17,52]]  ]  ,20,0) :-         !,
   write('Task 4 is solved correctly and with no multiple answers.\n').
marks4([[[4,13,17,52]]|_]  ,20,1) :-         !,
   write('Task 4 is solved correctly but there are multiple answers.\n').
marks4([               _]  , 0,0) :-         !,
   write('Task 4 is not solved correctly but there are no multiple answers.\n').
marks4([[           _]|_]  , 0,1) :-
   write('Task 4 is not solved correctly and there are multiple answers.\n').

marks5([[[4,13,17,52]]  ],I,M5,0) :-         !,
   write('Task 5 is solved correctly and with no multiple answers.\n'),
   write('Task 5 requires '), write(I), write(' inferences.\n'),
   f(I,MP5),
   M5 is round(MP5 + 2).
marks5([[[4,13,17,52]]|_],I,M5,1) :-         !,
   write('Task 5 is solved correctly but there are multiple answers.\n'),
   write('Task 5 requires '), write(I), write(' inferences.\n'),
   f(I,MP5),
   M5 is round(MP5 + 2).
marks5([               _],_, 0,0) :-         !,
   write('Task 5 is not solved correctly but there are no multiple answers.\n').
marks5([[           _]|_],_, 0,1) :-
   write('Task 5 is not solved correctly and there are multiple answers.\n').

penalty(0,0,0,0,0, 0) :- !.
penalty(_,_,_,_,_,20).

check_built_ins([   ], _,0) :- !.
check_built_ins([B|R],XS,F) :- sub_string(exact,B,XS),
                               !,
                               write('Found built-in '), write(B),
                               write('.\n'),
                               check_built_ins(R,XS,G),
                               F is G + 1.
check_built_ins([_|R],XS,F) :- check_built_ins(R,XS,F).

final_mark(M,Pen,0) :- !,
                       write('No built-ins found.\n'),
                       Grade is M - Pen,
                       write('The coursework grade is '), write(Grade),
                       write('.\n').
final_mark(M,Pen,N) :- N > 0,
                       Grade is M - Pen,
                       write('The coursework grade will be at most '),
                       write(Grade),
    write(', and marks will be manually deducted for the use of built-ins.\n').
