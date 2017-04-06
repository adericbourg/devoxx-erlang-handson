-module(toto).

%% API
% /2 : function's arity (arguments count)
-export([add/2, divide/2]).

add(A, B) -> A + B.

divide(A,0) -> infinite;
divide(A, B) -> A / B.