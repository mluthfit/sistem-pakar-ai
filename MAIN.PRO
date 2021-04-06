/*
Title   : Panduan Memilih Genre Lagu berdasarkan Mood User

Authored by Group 3
Members :
1) Muhammad Luthfi Taufiqurrahman (140810190036)
2) Gregorius Evangelist Wijayanto (140810190040)
3) Ihsanuddin Dwi Prasetyo (140810190048)
*/

/* Knowledge Base */
music(A) :-
  tree(T),
  tree_music(T, A).

tree(if_then_else(like_listening_to_music,
      if_then_else(feel_positive,
          if_then_else(feel_like_dancing,
              music(disco),
              if_then_else(feel_in_love,
                  music(love_songs),
                  if_then_else(feel_relaxed,
                      music(new_age_or_classical),
                      if_then_else(feel_excited,
                          music(rock_punk_or_reggae),
                          if_then_else(feel_like_in_need_of_inspiration,
                              music(broadways),
                              music(pop_songs)))))),
          if_then_else(feel_heartbroken,
              music(sad_love_songs_or_piano_ballad),
              if_then_else(feel_anxious,
                  music(rnb),
                  if_then_else(feel_angry,
                      music(heavy_metal),
                      if_then_else(need_motivation,
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

/* User Interface & Question Menu */
is_true(Q) :-
  format("Do you ~w? [yes/no]\n", [Q]),
  read(yes).

/* Simple Shell */
top_goal(X) :- music(X). 

solve :-
  top_goal(X),
  write('The answer is '), write(X), nl.
solve :-
  write('No answer found.'), nl. 

/* Command looping */
go :-  
  greeting,
  repeat,
  nl,
  write('> '),
  read(X),
  do(X),
  X == quit.

greeting :-
  write('===================================================================='), nl,
  write('Recommending Music Genre Based on Users Mood by Reading Users Input.'), nl,
  write('Using Prolog Expert System or ExSys.'), nl,
  write('--------------------------------------------------------------------'), nl,
  write('Enter start or quit at the prompt.'), nl, 
  write('===================================================================='), nl.

/* Running program */
do(start) :-
  solve,
  !. 

/* Quit program */
do(quit).
do(X) :-
  write(X),
  write(' is not a legal command.'), nl,
  fail. 

/* Handle undefined procedure */
:- unknown(trace, fail).