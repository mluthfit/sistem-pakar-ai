/*
Title : Panduan Memilih Genre Lagu berdasarkan Mood User
Packed by Group 3
*/

% Knowledge Base 


% User Interface
listening_music(X) :- 
  menuask(do_you_like_listening_to_music, X, [yes, no]).
feel_positive(X) :- 
  menuask(do_you_feel_positive, X, [yes, no]).
feel_dancing(X) :- 
  menuask(ko_you_feel_dancing, X, [yes, no]).
feel_in_love(X) :- 
  menuask(do_you_feel_in_love, X, [yes, no]).
feel_relaxed(X) :- 
  menuask(do_you_feel_relaxed, X, [yes, no]).
feel_excited(X) :- 
  menuask(do_you_feel_excited, X, [yes, no]).
feel_inspiration(X) :- 
  menuask(do_you_feel_like_in_need_of_inspiration, X, [yes, no]).
feel_heartbroken(X) :- 
  menuask(do_you_feel_heartbroken, X, [yes, no]).
feel_anxious(X) :- 
  menuask(do_you_feel_anxious, X, [yes, no]).
feel_angry(X) :- 
  menuask(do_you_feel_angry, X, [yes, no]).
feel_motivation(X) :- 
  menuask(do_you_feel_need_motivation, X, [yes, no]).
feel_tired(X) :- 
  menuask(do_you_feel_tired, X, [yes, no]).

% UI rules
menuask(A, V, _) :-
  known(yes, A, V), % succeed if true
  !. % stop looking

menuask(A, V, _) :-
  known(_, A, V), % fail if false
  !,
  fail.

menuask(A, V, MenuList) :-
  write(A), write('?'), nl,
  write(MenuList), nl,
  read(X),
  check_val(X, A, V, MenuList),
  asserta( known(yes, A, X) ),
  X == V. 

% Check input if still in member
check_val(X, _A, _V, MenuList) :-
  member(X, MenuList),
  !.
check_val(X, A, V, MenuList) :-
  write(X), write(' is not a legal value, try again.'), nl,
  menuask(A, V, MenuList). 

% Member rules
member(X,[X|_]).
member(X,[_|T]) :- member(X,T).

top_goal(X) :- music(X). 

solve :-
  abolish(known, 3),
  top_goal(X),
  write('The answer is '), write(X), nl.
solve :-
  write('No answer found.'), nl. 

% Command looping
go :-  
  greeting,
  repeat,
  write('> '),
  read(X),
  do(X),
  X == quit.

greeting :-
  write('This is the Genre Recommendation of Music Prolog Exsys.'), nl,
  write('Enter start or quit at the prompt.'), nl.

% Running program 
do(start) :-
  solve,
  !. 

% Quit program
do(quit).
do(X) :-
  write(X),
  write('is not a legal command.'), nl,
  fail. 

% Handle undefined procedure
:- unknown(trace, fail).