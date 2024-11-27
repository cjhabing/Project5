%%%%%%%%%%%%%%%%%
% Your code here:
%%%%%%%%%%%%%%%%%

initial_state(state(Position, no_red, no_blue, no_black)) :-
    initial(Position).

final_state(state(Position, _, _, _)) :-
    treasure(Position).

move_action(state(From, RedK, BlueK, BlackK), move(From, To), state(To, RedK, BlueK, BlackK)) :-
    (door(From, To); door(To, From)).

move_action(state(From, no_red, BlueK, BlackK), move(From, To), state(To, has_red, BlueK, BlackK)) :-
    door(From, To),
    key(To, red).

move_action(state(From, RedK, no_blue, BlackK), move(From, To), state(To, RedK, has_blue, BlackK)) :-
    door(From, To),
    key(To, blue).

move_action(state(From, RedK, BlueK, no_black), move(From, To), state(To, RedK, BlueK, has_black)) :-
    door(From, To),
    key(To, black).

move_action(state(From, RedK, BlueK, BlackK), move(From, To), state(To, RedK, BlueK, BlackK)) :-
    (locked_door(From, To, red), RedK = has_red);
    (locked_door(From, To, blue), BlueK = has_blue);
    (locked_door(From, To, black), BlackK = has_black);
    (locked_door(To, From, red), RedK = has_red);
    (locked_door(To, From, blue), BlueK = has_blue);
    (locked_door(To, From, black), BlackK = has_black).

take_steps(State, [Action], FinalState) :-
    move_action(State, Action, FinalState).

take_steps(State, [Action | Rest], FinalState) :-
    move_action(State, Action, IntermediateState),
    take_steps(IntermediateState, Rest, FinalState).

search(Actions) :-
    initial_state(InitialState),
    length(Actions, _),
    take_steps(InitialState, Actions, FinalState),
    final_state(FinalState), !.
