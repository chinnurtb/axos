-module(axos_web_provenance).
-export([init/1, to_html/2]).

-include_lib("webmachine/include/webmachine.hrl").

init(Target) -> {ok, Target}.

to_html(ReqData, Target) ->
    {"<html><body>Hello, provenance</body></html>", ReqData, Target}.
