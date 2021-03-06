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
  case DiseaseLevel of
    ?OUTBREAK_THRESHOLD ->
      outbreak;
    _ ->
      UpdatedLevel = DiseaseLevel + 1,
      {CityName, Levels} = City,
      {infected, {CityName, Levels#{Disease => UpdatedLevel}}}
  end.

infection_level(City, Disease) ->
  {_, Levels} = City,
  maps:get(Disease, Levels, 0).
