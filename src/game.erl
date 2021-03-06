%%%-------------------------------------------------------------------
%%% @author nadav ashkenazi
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. Apr 2021 12:46
%%%-------------------------------------------------------------------
-module(game).
-author("nadav ashkenazi").

%% API
-export([canWin/1, nextMove/1, explanation/0]).


switchPlayer(Player) ->
  case Player == 1 of
    true -> 2;
    false -> 1
  end.

%% ================ run game functions ========================

play(N, _Player) when N < 0 ->
  false;

play(0, Player) ->
  case Player == 1 of
    true -> false;
    false -> true
  end;

play(N, Player) when N == 1 orelse N == 2 ->
  case Player == 2 of
    true -> false;
    false -> true
  end;

%% recursive function to decide if player 1 can win
play(N, Player) ->
  case Player == 1 of
    true -> play(N-1, switchPlayer(Player)) or play(N-2, switchPlayer(Player)); % player 1 turn -> needs to win with one of the moves
    false -> play(N-1, switchPlayer(Player)) and play(N-2, switchPlayer(Player)) % player 2 turn -> needs to loose with ether move
  end.

canWin(N) ->
  play(N, 1).

nextMove(N) ->
  case play(N-1, 2) of % player 1 takes 1 Match
    true -> {true, 1};
    false -> case play(N-2, 2) of % player 1 takes 2 Matches
               true -> {true, 2};
               false -> false
             end
  end.


explanation() -> "A tail recursive function will return the result reached at the recurtion depth.
Because in this Question we have to compere 2 recursive senarios, we cannot return such result,
we have to return all the way to the original function call to be able to compare the two results.".


