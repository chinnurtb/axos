%% @author author <author@example.com>
%% @copyright YYYY author.
%% @doc Example webmachine_resource.

-module(axos_web_resource).
-export([init/1, to_html/2]).

-include_lib("webmachine/include/webmachine.hrl").

init(Target) -> {ok, Target}.

to_html(ReqData, Target) ->
    {"<html><body>Hello, Axos</body></html>", ReqData, Target}.
