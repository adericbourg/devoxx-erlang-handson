-module(city).


%% API
-export([new/1, name_of/1, infects/2, infection_level/2]).
-define(OUTBREAK_THRESHOLD, 3).

new(CityName) ->
  {ok, {CityName, #{}}}.

name_of(City) ->
  {CityName, _} = City,
  CityName.

infects(City, Disease) ->
  DiseaseLevel = infection_level(City, Disease),
  UpdatedLevel = DiseaseLevel + 1,
  infection_result(City, Disease, UpdatedLevel).

infection_result(_, _, Level) when Level > ?OUTBREAK_THRESHOLD -> outbreak;
infection_result(City, Disease, Level) ->
  {CityName, Levels} = City,
  {infected, {CityName, Levels#{Disease => Level}}}.

infection_level(City, Disease) ->
  {_, Levels} = City,
  maps:get(Disease, Levels, 0).
