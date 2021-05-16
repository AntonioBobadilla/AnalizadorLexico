Definitions.

D = [0-9]

Rules.
\t|\n : skip_token.
\s|\r :  {token, indentado(TokenLine, TokenChars)}.
{D}+ : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
[\:][a-zA-Z0-9]+ : {token, atomo(TokenLine, TokenChars)}.
[\&][\&]+ : {token, bitwise(TokenLine, TokenChars)}.
[\|\~\^\<\>][\|\~\^\<\>][\|\~\^\<\>] : {token, bitwise(TokenLine, TokenChars)}.
[A-Z][a-zA-Z]+[\.] : {token, functions(TokenLine, TokenChars)}.
[a-zA-Z][\?a-zA-Z0-9\:]* :  {token, analyze(TokenLine, TokenChars)}.
[|][>] :  {token, analyze(TokenLine, TokenChars)}.
[\+\-\!\*\%\,\=\>\.\_\|\/\'\"\~\&\<\:] :  {token, analyze(TokenLine, TokenChars)}.
[\(\)] : {token, {list_to_atom(TokenChars), TokenLine, TokenChars}}.
[\[\]] : {token, {list_to_atom(TokenChars), TokenLine, TokenChars}}.
[\{\}] : {token, {list_to_atom(TokenChars), TokenLine, TokenChars}}.
[#][\sa-zA-Z0-9]* :  {token, comment(TokenLine, TokenChars)}.
[@][a-zA-Z0-9]+ : {token, modulo(TokenLine, TokenChars)}.
[~][A-Z][\[][0-9\-\:\s]+[\]] : {token, fecha(TokenLine, TokenChars)}.


Erlang code.

atomo(TokenLine, TokenChars) -> {atomo, TokenLine, TokenChars}.
functions(TokenLine, TokenChars) -> {function, TokenLine, TokenChars}.
comment(TokenLine, TokenChars) -> {comment, TokenLine, TokenChars}.
indentado(TokenLine, TokenChars) -> {indentado, TokenLine, TokenChars}.
modulo(TokenLine, TokenChars) -> {modulo, TokenLine, TokenChars}.
fecha(TokenLine, TokenChars) -> {fecha, TokenLine, TokenChars}.
bitwise(TokenLine, TokenChars) -> {bitwise, TokenLine, TokenChars}.


analyze(TokenLine, TokenChars) ->
    IsKW = lists:member(TokenChars, ["defmodule", "do", "do:", "use", "def", "end", "fn", "->", "if", "else", "=", "!", ">", "<", "=>", "==", "!="]),
    Isbool = lists:member(TokenChars, ["true", "false", "nil"]),
    IsDot = lists:member(TokenChars, [".", ","]),
    Ispipe = lists:member(TokenChars, ["|>"]),
    if
        IsKW -> {keyword, TokenLine, TokenChars};
        Isbool -> {bool, TokenLine, TokenChars};
        IsDot -> {dot, TokenLine, TokenChars};
        Ispipe -> {pipe, TokenLine, TokenChars};
        true -> {identifier, TokenLine, TokenChars}
    end.
