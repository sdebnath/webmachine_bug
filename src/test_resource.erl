-module(test_resource).
-export([
    init/1,
    is_authorized/2,
    allowed_methods/2,
    content_types_provided/2,
    process_get/2,
    process_post/2
]).

-include_lib("webmachine/include/webmachine.hrl").

-spec init(list()) -> {ok, term()}.
init(Config) ->
%%
%% Without tracing, 2 POST requests sequentially to the same inets process works fine.
%%
%%    {ok, undefined}.

%%
%% Enabling trace causes HTTP/1.1 persistent connections to be dropped!
%%
    {{trace, "traces"}, Config}.

is_authorized(ReqData, Context) ->
    {{halt, 401}, ReqData, Context}.

allowed_methods(ReqData, Context) ->
    {['GET', 'POST'], ReqData, Context}.

content_types_provided(ReqData, Context) ->
    {[{"application/json", process_get}], ReqData, Context}.

process_get(ReqData, Context) ->
    Json = {struct, [{"Hello","World"}]},
    Body = mochijson:encode(Json),
    {Body, ReqData, Context}.

process_post(ReqData, Context) ->
    Json = {struct, [{"Hello","World"}]},
    Body = mochijson:encode(Json),
    {true, wrq:append_to_response_body(Body, ReqData), Context}.
