functor
import  
    LogicGates at 'c:/users/matheus/desktop/cap4/functor/gates.ozf'
export 
    circ4:Circ4
define
    proc {Circ4 X Y Z ?R} % (XvY) ^ (XvZ) ^ (YvZ) **retorna 0 quando 2 ou mais valores são 0
        K L M N
    in
        K = {LogicGates.org X Y}
        L = {LogicGates.org X Z}
        M = {LogicGates.org Y Z}
        N = {LogicGates.andg K L}
        R = {LogicGates.andg N M}
    end
end

% declare
% X = 1|_ 
% Y = 1|_ 
% Z = 0|_ R in
% {Circ4 X Y Z ?R}
% {Browse inp(X Y Z)#output(R)}