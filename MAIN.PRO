/*
Title : Panduan Memilih Genre Lagu berdasarkan Mood User
Packed by Group 3
*/

% Knowledge Base
music(A) :-
  tree(T),
  tree_music(T, A).

tree(if_then_else(like_listening_to_music,
      if_then_else(feel_positive,
          if_then_else(feel_dancing,
              music(disco),
              if_then_else(feel_in_love,
                  music(love_songs),
                  if_then_else(feel_relaxed,
                      music(new_age_or_classical),
                      if_then_else(feel_excited,
                          music(rock_punk_or_reggae),
                          if_then_else(feel_inspiration,
                              music(broadways),
                              music(pop_songs)))))),
          if_then_else(feel_heartbroken,
              music(sad_love_songs_or_piano_ballad),
              if_then_else(feel_anxious,
                  music(rnb),
                  if_then_else(feel_angry,
                      music(heavy_metal),
                      if_then_else(feel_motivation,
                          music(rap_or_hiphop),
                          if_then_else(feel_tired,
                              music(lo_fi),
                              music(slow_songs))))))),
  music(thank_you_for_trying_this_program))).

tree_music(music(A), A).
tree_music(if_then_else(Cond,Then,Else), A) :-
  (   is_true(Cond) ->
      tree_music(Then, A)
  ;   tree_music(Else, A)
  ).

is_true(Q) :-
  format("~w?\n", [Q]),
  read(yes).

% User Interface 
listening_music(X) :- 
  menuask(like_listening_to_music, X, is_true(_)).
feel_positive(X) :- 
  menuask(feel_positive, X, is_true(_)).
feel_dancing(X) :- 
  menuask(feel_like_dancing, X, is_true(_)).
feel_in_love(X) :- 
  menuask(feel_in_love, X, is_true(_)).
feel_relaxed(X) :- 
  menuask(feel_relaxed, X, is_true(_)).
feel_excited(X) :- 
  menuask(feel_excited, X, is_true(_)).
feel_inspiration(X) :- 
  menuask(feel_like_in_need_of_inspiration, X, is_true(_)).
feel_heartbroken(X) :- 
  menuask(feel_heartbroken, X, is_true(_)).
feel_anxious(X) :- 
  menuask(feel_anxious, X, is_true(_)).
feel_angry(X) :- 
  menuask(feel_angry, X, is_true(_)).
feel_motivation(X) :- 
  menuask(need_motivation, X, is_true(_)).
feel_tired(X) :- 
  menuask(feel_tired, X, is_true(_)).

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