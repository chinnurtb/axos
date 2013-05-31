-module(axos_web_provenance).
-export([
	init/1,
	allowed_methods/2,
	content_types_accepted/2,
	content_types_provided/2,
	process_post/2
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

to_html(RD, Ctx) ->
    {"<html><body>Hello, provenance</body></html>", RD, Ctx}.

to_json(RD, Ctx) ->
	% ["provenance", srv_name, event, category]
	SrvName = wrq:path_info(srv_name, RD),
	Event = wrq:path_info(event, RD),
	Category = wrq:path_info(category, RD),
	Msg = {msg, [{status, <<"success">>}, {received, [
				{service_name, SrvName},
				{event, Event},
				{category, Category}]}]},
	Content = axos_provenance:to_json(Msg), 
	{Content, RD, Ctx}.

%% define the allowed HTTP methods
%%
%% Rd - request data, an opaque record, #wm_reqdata
%% Ctx - resource's context that is provided
allowed_methods(RD, Ctx) ->
	{['POST', 'GET'], RD, Ctx}.

content_types_accepted(ReqData, Context) ->
	{[{?MT_FORMENC, accept_form},
	  {?MT_APPJSON, accept_json}], ReqData, Context}.

content_types_provided(RD, Ctx) ->
    {[{?MT_APPJSON, to_json},
      {"text/html", to_html}], RD, Ctx}.

process_post(RD, Ctx) -> 
	{RespContent, _, _} = to_json(RD, Ctx),
	Resp0 = wrq:set_resp_header("Content-Type", ?MT_APPJSON, RD),
	Resp1 = wrq:set_resp_body(RespContent, Resp0), 
	{true, Resp1, Ctx}.