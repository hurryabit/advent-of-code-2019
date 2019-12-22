-module(day07_1).
-export([main/0]).

inserts(X, []) -> [[X]];
inserts(X, [H|T]) -> [ [X,H|T] | lists:map(fun(I) -> [H|I] end, inserts(X, T)) ].

perms([]) -> [[]];
perms([H|T]) -> lists:flatmap(fun(P) -> inserts(H, P) end, perms(T)).

prog() -> array:from_list([3,8,1001,8,10,8,105,1,0,0,21,42,55,76,89,114,195,276,357,438,99999,3,9,1001,9,3,9,1002,9,3,9,1001,9,3,9,1002,9,2,9,4,9,99,3,9,102,2,9,9,101,5,9,9,4,9,99,3,9,102,3,9,9,101,5,9,9,1002,9,2,9,101,4,9,9,4,9,99,3,9,102,5,9,9,1001,9,3,9,4,9,99,3,9,1001,9,4,9,102,5,9,9,1001,9,5,9,1002,9,2,9,101,2,9,9,4,9,99,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99]).

run_amp(Phase, InputSignal) -> loop(prog(), 0, [Phase, InputSignal], 0).

loop(Memory, Pctr, Input, Output) ->
  Get = fun(A) -> array:get(A, Memory) end,
  Set = fun(A, V) -> array:set(A, V, Memory) end,
  Instr = array:get(Pctr, Memory),
  GetOp = fun(M, A) ->
    case (Instr div M) rem 10 of
      0 -> Get(A);
      _ -> A
    end
  end,
  X = GetOp(100, Pctr+1),
  Y = GetOp(1000, Pctr+2),
  Z = GetOp(10000, Pctr+3),
  case Instr rem 100 of
    1 -> loop(array:set(Z, Get(X)+Get(Y), Memory), Pctr+4, Input, Output);
    2 -> loop(array:set(Z, Get(X)*Get(Y), Memory), Pctr+4, Input, Output);
    3 ->
      [H | T] = Input,
      loop(Set(X, H), Pctr+2, T, Output);
    4 -> loop(Memory, Pctr+2, Input, Get(X));
    5 ->
      A = case Get(X) =/= 0 of
        true -> Get(Y);
        false -> Pctr+3
      end,
      loop(Memory, A, Input, Output);
    6 ->
      A = case Get(X) =:= 0 of
        true -> Get(Y);
        false -> Pctr+3
      end,
      loop(Memory, A, Input, Output);
    7 ->
      C = case Get(X) < Get(Y) of
        true -> 1;
        false -> 0
      end,
      loop(Set(Z, C), Pctr+4, Input, Output);
    8 ->
      C = case Get(X) =:= Get(Y) of
        true -> 1;
        false -> 0
      end,
      loop(Set(Z, C), Pctr+4, Input, Output);
    99 -> Output
  end.

run_chain(Phases) -> lists:foldl(fun(P, I) -> run_amp(P, I) end, 0, Phases).

main() -> lists:max(lists:map(fun(P) -> run_chain(P) end, perms([0, 1, 2, 3, 4]))).
