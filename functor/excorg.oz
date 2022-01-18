functor
import  
    LogicGates at 'c:/users/matheus/desktop/cap4/functor/gates.ozf'
export 
    xorg:ExcOrG
define
    proc {ExcOrG X Y ?R} %Construçao do ou exclusivo com portas logicas menores
        K L M N
    in
        K = {LogicGates.notg X}
        L = {LogicGates.notg Y}
        M = {LogicGates.andg X L}
        N = {LogicGates.andg Y K}
        R = {LogicGates.org M N}
    end
end

% declare
% X=1|_
% Y=0|_ Z in
% {ExcOrG X X Z}
% {Browse inp(X X)#output(Z)}