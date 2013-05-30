%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc Callbacks for the axos_web application.

-module(axos_web_app).
-author('author <author@example.com>').

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for axos_web.
start(_Type, _StartArgs) ->
    axos_web_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for axos_web.
stop(_State) ->
    ok.
