-module(toto).

%% API
% /2 : function's arity (arguments count)
-export([add/1, add/2, divide/2]).

add([]) -> 0;
add([Head | Tail]) -> add0([Head | Tail], 0).

% Tail recursion
add0([], Acc) -> Acc;
add0([Head | Tail], Acc) -> add0(Tail, Head + Acc).

add({Xa, Ya}, {Xb, Yb}) -> {Xa + Ya, Xb + Yb};
add(A, B) -> A + B.

divide(A, 0) when A >= 0 -> p_infinite;
divide(A, 0) when A < 0 -> m_infinite;
divide(A, B) -> A / B.
