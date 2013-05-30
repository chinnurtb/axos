-module(axos_web_lookup).
-export([init/1, to_html/2]).

-include_lib("webmachine/include/webmachine.hrl").

init(Target) -> {ok, Target}.

to_html(ReqData, Target) ->
    {"<html><body>Hello, new lookup</body></html>", ReqData, Target}.
