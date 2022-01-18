functor
import 
    LogicGates at 'c:/users/matheus/desktop/cap4/functor/gates.ozf'
export 
    circ2:Circ2
define
    proc {Circ2 W X Y Z ?R} % (((W AND X) AND Y) AND Z)
        K L 
    in
        K = {LogicGates.andg W X}
        L = {LogicGates.andg K Y}
        R = {LogicGates.andg L Z}
    end
end