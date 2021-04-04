/*
Title : Panduan Memilih Genre Lagu berdasarkan Mood User
Packed by Group 3
*/

% Knowledge Base 
music(thank_you_for_trying_this_program) :-
  listening_music(no).

% Positive
music(disco) :-
  listening_music(yes),
  feel_positive(yes),
  feel_dancing(yes).

music(love_songs) :-
  listening_music(yes),
  feel_positive(yes),
  feel_dancing(no),
  feel_in_love(yes).

music(new_age_or_classical) :-
  listening_music(yes),
  feel_positive(yes),
  feel_dancing(no),
  feel_in_love(no),
  feel_relaxed(yes).

music(rock_punk_or_reggae) :-
  listening_music(yes),
  feel_positive(yes),
  feel_dancing(no),
  feel_in_love(no),
  feel_relaxed(no),
  feel_excited(yes).

music(broadways) :-
  listening_music(yes),
  feel_positive(yes),
  feel_dancing(no),
  feel_in_love(no),
  feel_relaxed(no),
  feel_excited(no),
  feel_inspiration(yes).

music(pop_songs) :-
  listening_music(yes),
  feel_positive(yes),
  feel_dancing(no),
  feel_in_love(no),
  feel_relaxed(no),
  feel_excited(no),
  feel_inspiration(no).
  

% Negative

music(sad_love_songs_or_piano_ballad) :-
  listening_music(yes),
  feel_positive(no),
  feel_heartbroken(yes).

music(rnb) :-
  listening_music(yes),
  feel_positive(no),
  feel_heartbroken(no),
  feel_anxious(yes).

music(heavy_metal) :-
  listening_music(yes),
  feel_positive(no),
  feel_heartbroken(no),
  feel_anxious(no),
  feel_angry(yes).

music(rap_or_hiphop) :-
  listening_music(yes),
  feel_positive(no),
  feel_heartbroken(no),
  feel_anxious(no),
  feel_angry(no),
  feel_motivation(yes).

music(lo_fi) :-
  listening_music(yes),
  feel_positive(no),
  feel_heartbroken(no),
  feel_anxious(no),
  feel_angry(no),
  feel_motivation(no),
  feel_tired(yes).

music(slow_songs) :-
  listening_music(yes),
  feel_positive(no),
  feel_heartbroken(no),
  feel_anxious(no),
  feel_angry(no),
  feel_motivation(no),
  feel_tired(no).

/* User Interface */
listening_music(X) :- 
  menuask(like_listening_to_music, X, [yes, no]).
feel_positive(X) :- 
  menuask(feel_positive, X, [yes, no]).
feel_dancing(X) :- 
  menuask(feel_like_dancing, X, [yes, no]).
feel_in_love(X) :- 
  menuask(feel_in_love, X, [yes, no]).
feel_relaxed(X) :- 
  menuask(feel_relaxed, X, [yes, no]).
feel_excited(X) :- 
  menuask(feel_excited, X, [yes, no]).
feel_inspiration(X) :- 
  menuask(feel_like_in_need_of_inspiration, X, [yes, no]).
feel_heartbroken(X) :- 
  menuask(feel_heartbroken, X, [yes, no]).
feel_anxious(X) :- 
  menuask(feel_anxious, X, [yes, no]).
feel_angry(X) :- 
  menuask(feel_angry, X, [yes, no]).
feel_motivation(X) :- 
  menuask(need_motivation, X, [yes, no]).
feel_tired(X) :- 
  menuask(feel_tired, X, [yes, no]).

/* UI rules */
menuask(A, V, _) :-
  known(yes, A, V), % succeed if true
  !. % stop looking
menuask(A, V, _) :-
  known(_, A, V), % fail if false
  !,
  fail.
menuask(A, V, MenuList) :-
  write('Do you '), write(A), write('?'), nl,
  write(MenuList), nl,
  read(X),
  check_val(X, A, V, MenuList),
  asserta(known(yes, A, X)),
  X == V. 

/* Check input if still in member */
check_val(X, _A, _V, MenuList) :-
  member(X, MenuList),
  !.
check_val(X, A, V, MenuList) :-
  write(X), write(' is not a legal value, try again.'), nl,
  menuask(A, V, MenuList). 

/* Member rules */
member(X,[X|_]).
member(X,[_|T]) :- member(X,T).

top_goal(X) :- music(X). 

solve :-
  abolish(known, 3),
  top_goal(X),
  write('The answer is '), write(X), nl.
solve :-
  write('No answer found.'), nl. 

/* Command looping */
go :-  
  greeting,
  repeat,
  write('> '),
  read(X),
  do(X),
  X == quit.

greeting :-
  write('This is the Music Genre Recommendation of Music Prolog ExSys.'), nl,
  write('Enter start or quit at the prompt.'), nl.

/* Running program */
do(start) :-
  solve,
  !. 

/* Quit program */
do(quit).
do(X) :-
  write(X),
  write('is not a legal command.'), nl,
  fail. 

/* Handle undefined procedure */
:- unknown(trace, fail).