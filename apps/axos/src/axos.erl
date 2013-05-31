%% majority of this module Copyright OJ Reeves. 
%% based on code from his Code Smackdown blog post.
-module(axos).
-include("axos.hrl").
-include_lib("riak_core/include/riak_core_vnode.hrl").

-export([
         ping/0
        ]).

%% Public API

-export([
	start/0,
	start_link/0,
	stop/0
	]).

%% @doc Pings a random vnode to make sure communication is functional
ping() ->
    DocIdx = riak_core_util:chash_key({<<"ping">>, term_to_binary(now())}),
    PrefList = riak_core_apl:get_primary_apl(DocIdx, 1, axos),
    [{IndexNode, _Type}] = PrefList,
    riak_core_vnode_master:sync_spawn_command(IndexNode, ping, axos_vnode_master).

ensure_started(App) ->
	case application:start(App) of 
		ok ->
			ok;
		{error, {already_started, App}} ->
			ok
	end.

%% @spec start_link() -> {ok, Pid::pid()}
%% @doc Starts the app for inclusion in a supervisor tree
start_link() ->
	ensure_started(crypto),
	csd_core_sup:start_link().

%% @spec start() -> ok
%% @doc Start the axos server.
start() ->
	ensure_started(crypto),
	application:start(axos).

%% @spec stop() -> ok
%% @doc Stop the axos server.
stop() ->
	Res = application:stop(axos),
	application:stop(crypto),
	Res.