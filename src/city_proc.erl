-module(city_proc).


%% API
-export([start/2]).
-export([loop/2]).
-export([infection_level/2, infects/2, infects/3]).

start(CityName, Links) ->
  spawn(?MODULE, loop, [city:new(CityName), Links]).

loop(City, Links) ->
  receive
    {infection_level, Disease, ReplyTo} ->
      Level = city:infection_level(City, Disease),
      reply(ReplyTo, {infection_level, city:name_of(City), Disease, Level}),
      loop(City, Links);

    {infect, Disease, ReplyTo} ->
      Result = city:infects(City, Disease),
      case Result of
        {infected, NewCity} ->
          Level = city:infection_level(NewCity, Disease),
          reply(ReplyTo, {infected, city:name_of(City), Disease, Level}),
          loop(NewCity, Links);

        outbreak ->
          reply(ReplyTo, {outbreak, city:name_of(City), Disease, Links}),
          loop(City, Links)

      end
  end.

infection_level(City, Disease) ->
  City ! {infection_level, Disease, self()},
  receive
    {infection_level, _, Disease, Level} ->
      {ok, Level};
    Other ->
      {error, Other}
  end.

infects(City, Disease) ->
  City ! {infect, Disease, noreply}.

infects(City, Disease, ReplyTo) ->
  City ! {infect, Disease, ReplyTo}.


reply(noreply, _) -> ok;
reply(ReplyTo, Message) -> ReplyTo ! Message.
