%%-----------------------------------------------------------------------------
%% Test to figure out inets/httpc & webmachine behavior.
%%-----------------------------------------------------------------------------

-module(seq_post_tests).

-include_lib("eunit/include/eunit.hrl").

-define(URL, "http://localhost:8080/test").
-define(CONTENT_TYPE_JSON, "application/json").
-define(SAMPLE_JSON_CONTENT, "{\"hello\":\"world\"}").

same_inets_for_post_calls_test() ->

    ibrowse:start(),
    ibrowse:send_req(?URL, [], post, ?SAMPLE_JSON_CONTENT),
    ibrowse:send_req(?URL, [], post, ?SAMPLE_JSON_CONTENT),
    ibrowse:stop().

%    inets:start(),
%    {ok, {{_, Status1, _}, _, _}} =
%        httpc:request(post, {?URL, [], ?CONTENT_TYPE_JSON, ?SAMPLE_JSON_CONTENT}, [], []),
%    ?assertEqual(401, Status1),
%
%    {ok, {{_, Status2, _}, _, _}} =
%        httpc:request(post, {?URL, [], ?CONTENT_TYPE_JSON, ?SAMPLE_JSON_CONTENT}, [], []),
%    ?assertEqual(401, Status2),
%    inets:stop().

