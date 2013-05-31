-module(axos_web_lookup).

%% Resource methods 

-export([
	init/1, 
	allowed_methods/2,
	content_types_provided/2
	]).

-export([
	to_html/2,
	to_json/2
	]).

-include_lib("webmachine/include/webmachine.hrl").

-include("axos_web.hrl").

-record(ctx, {}).

init([]) -> 
	Ctx = #ctx{},
	{ok, Ctx}.

to_html(ReqData, Target) ->
    {"<html><body>Hello, new lookup</body></html>", ReqData, Target}.

to_json(RD, Ctx) ->
	% ["lookup", srv_key, obj_id]
	SrvKey = wrq:path_info(srv_key, RD),
	ObjId = wrq:path_info(obj_id, RD),
	Msg = {msg, [{status, <<"success">>}, {received, [
				{service_key, SrvKey},
				{object_id, ObjId}]}]},
	Content = axos_provenance:to_json(Msg), 
	{Content, RD, Ctx}.

allowed_methods(RD, Ctx) ->
	{['HEAD', 'GET'], RD, Ctx}.

content_types_provided(RD, Ctx) ->
	{[{?MT_APPJSON, to_json},
	  {?MT_TXTHTML, to_html}], RD, Ctx}.