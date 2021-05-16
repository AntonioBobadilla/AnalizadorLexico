Definitions.

D = [0-9]

Rules.
\t|\n : skip_token.
\s|\r :  {token, indentado(TokenLine, TokenChars)}.
{D}+ : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
[A-Z][a-zA-Z]+[\.] : {token, functions(TokenLine, TokenChars)}.
[a-zA-Z?][a-zA-Z0-9]* :  {token, analyze(TokenLine, TokenChars)}.
[|][>] :  {token, analyze(TokenLine, TokenChars)}.
[\+\-\!\*\%\,\=\>\.\_\|\/]* :  {token, analyze(TokenLine, TokenChars)}.
[\(\)] : {token, {list_to_atom(TokenChars), TokenLine, TokenChars}}.
[\[\]] : {token, {list_to_atom(TokenChars), TokenLine, TokenChars}}.
[\{\}] : {token, {list_to_atom(TokenChars), TokenLine, TokenChars}}.
[#][\sa-zA-Z0-9]* :  {token, comment(TokenLine, TokenChars)}.


Erlang code.

functions(TokenLine, TokenChars) -> {function, TokenLine, TokenChars}.

comment(TokenLine, TokenChars) -> {comment, TokenLine, TokenChars}.


indentado(TokenLine, TokenChars) -> {indentado, TokenLine, TokenChars}.


analyze(TokenLine, TokenChars) ->
    IsKW = lists:member(TokenChars, ["defmodule", "do", "use", "def", "end", "fn", "->", "if", "else", "=", "!", ">", "<", "=>", "==", "!=", "nil", "true", "false", "do:"]),
    IsDot = lists:member(TokenChars, ["."]),
    Ispipe = lists:member(TokenChars, ["|>"]),
    if
        IsKW -> {keyword, TokenLine, TokenChars};
        IsDot -> {dot, TokenLine, TokenChars};
        Ispipe -> {pipe, TokenLine, TokenChars};
        true -> {identifier, TokenLine, TokenChars}
    end.

