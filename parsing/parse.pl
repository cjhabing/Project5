
%%%%%%%%%%%%%%%%%
% Your code here:
%%%%%%%%%%%%%%%%%

parse(X) :- parse_lines(X, []).

parse_lines(X, Rest) :-
    parse_item(X, Temp),
    (Temp = [';' | Next] -> parse_lines(Next, Rest) ; Rest = Temp).

parse_item(X, Rest) :-
    parse_number(X, Temp),
    (Temp = [',' | Next] -> parse_item(Next, Rest) ; Rest = Temp).

parse_number([Digit | Rest], Remaining) :-
    valid_digit(Digit),
    (parse_number(Rest, Remaining) ; Remaining = Rest).

valid_digit(Char) :- member(Char, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']).



% Example execution:
% ?- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2']).
% true.
% ?- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2', ',']).
% false.
% ?- parse(['3', '2', ',', ';', '0']).
% false.
