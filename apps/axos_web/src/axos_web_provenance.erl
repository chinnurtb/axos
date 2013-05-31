-module(axos_web_provenance).
-export([
	init/1,
	allowed_methods/2,
	content_types_accepted/2
%%	content_types_provided/2
	]).

-export([
	to_html/2
	]).

-include_lib("webmachine/include/webmachine.hrl").

-include("axos_web.hrl").

-record(ctx, {}).

init([]) ->
	Ctx = #ctx{},
	{ok, Ctx}.

to_html(RD, Ctx) ->
    {"<html><body>Hello, provenance</body></html>", RD, Ctx}.

%% define the allowed HTTP methods
%%
%% Rd - request data, an opaque record, #wm_reqdata
%% Ctx - resource's context that is provided
allowed_methods(RD, Ctx) ->
	{['POST', 'GET'], RD, Ctx}.

content_types_accepted(ReqData, Context) ->
	{[{?MT_FORMENC, accept_form},
	  {?MT_APPJSON, accept_json}], ReqData, Context}.

%%content_types_provided(RD, Ctx) ->
%%    {[ {?MT_APPJSON, to_json} ], RD, Ctx}.

