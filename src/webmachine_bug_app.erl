-module(webmachine_bug_app).

-behaviour(application).
-export([
    start/2,
    stop/1
]).

start(_Type, _StartArgs) ->
    webmachine_bug_sup:start_link().

stop(_State) ->
    ok.
