-module(axos_provenance).

-export([
	to_json/1,
	from_json/1
	]).

%% exported functions
to_json({msg, ProvData}) ->
  to_json_internal(ProvData).

from_json(ProvJson) ->
  from_json_internal(ProvJson).

to_json_internal(ProvData) ->
  axos_json:to_json(ProvData, fun is_string/1).

from_json_internal(ProvJson) ->
  {msg, axos_json:from_json(ProvJson, fun is_string/1)}.

%% 	Msg = {msg, [{status, "success"}, {received, [
%% 		{service_name, SrvName},
%% 		{event, Event},
%% 		{category, Category}]}]},

is_string(service_name) -> true;
is_string(category) -> true;
is_string(event) -> true;
is_string(status) -> true;
is_string(_) -> false.