%%-----------------------------------------------------------------------------
%% Test to figure out inets/httpc & webmachine behavior.
%%-----------------------------------------------------------------------------

-module(seq_post_tests).

-include_lib("eunit/include/eunit.hrl").

-define(URL, "http://localhost:8080/test").
-define(CONTENT_TYPE_JSON, "application/json").
-define(SAMPLE_JSON_CONTENT, "{\"hello\":\"world\"}").

%% Invoke POST REST API calls via separate inets/httpc processes
separate_inets_per_call_test() ->

    inets:start(),

    {ok, {{_, Status1, _}, _, _}} =
        httpc:request(post, {?URL, [], ?CONTENT_TYPE_JSON, ?SAMPLE_JSON_CONTENT}, [], []),
    ?assertEqual(401, Status1),

    inets:stop(),
    inets:start(),

    {ok, {{_, Status2, _}, _, _}} =
        httpc:request(post, {?URL, [], ?CONTENT_TYPE_JSON, ?SAMPLE_JSON_CONTENT}, [], []),
    ?assertEqual(401, Status2),

    inets:stop().

%% Invoke GET REST API calls via same inets/httpc processes
same_inets_for_get_calls_test() ->

    inets:start(),

    {ok, {{_, Status1, _}, _, _}} =
        httpc:request(get, {?URL, []}, [], []),
    ?assertEqual(401, Status1),

    {ok, {{_, Status2, _}, _, _}} =
        httpc:request(get, {?URL, []}, [], []),
    ?assertEqual(401, Status2),

    inets:stop().

%% Invoke REST API calls via same inets/httpc processes
%%
%% NOTE: This test will fail with tracing enabled for test resource
%%
same_inets_for_post_calls_test() ->

    inets:start(),

    {ok, {{_, Status1, _}, _, _}} =
        httpc:request(post, {?URL, [], ?CONTENT_TYPE_JSON, ?SAMPLE_JSON_CONTENT}, [], []),
    ?assertEqual(401, Status1),

    {ok, {{_, Status2, _}, _, _}} =
        httpc:request(post, {?URL, [], ?CONTENT_TYPE_JSON, ?SAMPLE_JSON_CONTENT}, [], []),
    ?assertEqual(401, Status2),

    inets:stop().
