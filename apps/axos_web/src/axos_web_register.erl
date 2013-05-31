-module(axos_web_register).
-export([
		init/1, 
		allowed_methods/2,
		content_types_accepted/2,
		accept_form/2,
		accept_json/2,
		post_is_create/2,
		process_post/2,
		allow_missing_post/2,
		to_html/2]).

-include_lib("webmachine/include/webmachine.hrl").

-include("axos_web.hrl").

%% our context, ctx, record that we'll pass around to each function
-record(ctx, {}).

%% Rememember that ``ReqData`` is an instance of the webmachine record
%% #wm_reqdata, the fields of this record can be found here: 
%% 
%% https://github.com/basho/webmachine/blob/master/include/wm_reqdata.hrl

init([]) -> 
	Context = #ctx{},
	{ok, Context}.

to_html(ReqData, Context) ->
    {"<html><body>Hello, new register...</body></html>", ReqData, Context}.

allowed_methods(ReqData, Context) ->
	{['POST', 'GET'], ReqData, Context}.

allow_missing_post(ReqData, Context) ->
	{true, ReqData, Context}.

%% Okay - I get this now, this is accept as POST body payloads.
%% So let's just so we don't accept any content types.
content_types_accepted(ReqData, Context) ->
	{[], ReqData, Context}.

accept_form(ReqData, Context) ->
	%% gonna need to do something here soon...
	{true, ReqData, Context}.

accept_json(ReqData, Context) ->
	%% same, do something - soon...
	{true, ReqData, Context}.

post_is_create(ReqData, Context) ->
	{false, ReqData, Context}.

%% from the dispatch.conf, the pathspec is: 
%% 		["register", srv_key, obj_id, obj_name, obj_desc]
process_post(ReqData, Context) ->
	SrvKey = wrq:path_info(srv_key, ReqData),
	ObjId = wrq:path_info(obj_id, ReqData),
	ObjName = wrq:path_info(obj_name, ReqData),
	ObjDesc = wrq:path_info(obj_desc, ReqData),
	Content = io_lib:format("<html><body>~p ~p ~p ~p</body></html>", 
					[SrvKey, ObjId, ObjName, ObjDesc]),
	%%Content = "<html><body><h1>Created.</h1></body></html>",
	Resp0 = wrq:set_resp_header("Content-Type", "text/html", ReqData),
	Resp1 = wrq:set_resp_body(Content, Resp0), 
	{true, Resp1, Context}.
