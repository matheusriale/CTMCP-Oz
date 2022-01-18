functor
import 
    LogicGates at 'c:/users/matheus/desktop/cap4/functor/gates.ozf'
export 
    circ3:Circ3
define
    proc {Circ3 X Y ?C ?S} % (SIMPLE SUM (One digit sum)) 
        K L 
    in
        K = {LogicGates.andg X Y}
        L = {LogicGates.xorg X Y}
        C = K 
        S = L
    end
end
% declare
% X = 1|_ 
% Y = 1|_ C S in
% {Circ3 X Y ?C ?S}
% {Browse inp(X Y)#output(C S)}