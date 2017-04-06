-module(city_test).


%% API
-export([]).
-include_lib("eunit/include/eunit.hrl").

should_create_new_city__test() ->
  {ok, City} = city:new(paris),
  {CityName, _} = City,
  ?assertEqual(paris, CityName).

should_not_be_infected_by_default__test() ->
  {ok, City} = city:new(london),
  ?assertEqual(0, city:infection_level(City, blue)).

should_increase_infection_level_when_infected__test() ->
  {ok, City1} = city:new(london),
  {infected, City2} = city:infects(City1, blue),
  ?assertEqual(1, city:infection_level(City2, blue)),
  ?assertEqual(0, city:infection_level(City2, black)),
  ?assertEqual(0, city:infection_level(City2, red)),
  ?assertEqual(0, city:infection_level(City2, white)).

should_outbreak_when_infection_level_reaches_the_threshold__test() ->
  {ok, City1} = city:new(london),
  {infected, City2} = city:infects(City1, blue),
  {infected, City3} = city:infects(City2, blue),
  {infected, City4} = city:infects(City3, blue),
  Result = city:infects(City4, blue),
  ?assertEqual(outbreak, Result).