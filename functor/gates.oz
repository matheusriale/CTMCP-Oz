functor
export notgate:NotGate notg:NotG gatemaker:GateMaker andg:AndG org:OrG norg:NorG nandg:NandG xorg:XorG
define 
    fun {NotGate Xs}
        case Xs of X|Xr then (1-X)|{NotGate Xr} end
        /* exemplo 101...    1|01
        (1-1)   |NotGate 01
        0 (1-0) |NotGate 1 
        01 (1-1)| null
        010 
        */
    end

    local
        fun {NotLoop Xs}
            case Xs of X|Xr then (1-X)|{NotLoop Xr} end
        end
    in
        fun {NotG Xs}
            thread {NotLoop Xs} end
            %Calling NotG creates a new Not gate in its OWN THREAD
        end
    end
    
    fun {GateMaker F}
        fun {$ Xs Ys}
            fun {GateLoop Xs Ys}
                case Xs#Ys of (X|Xr)#(Y|Yr) then
                    {F X Y}|{GateLoop Xr Yr}
                end
            end
        in
            thread {GateLoop Xs Ys} end
        end
    end
    %Portas logicas basicas
    AndG =  {GateMaker fun {$ X Y} X*Y end}
    OrG =   {GateMaker fun {$ X Y} X+Y-X*Y end}
    NandG = {GateMaker fun {$ X Y} 1-X*Y end}
    NorG =  {GateMaker fun {$ X Y} 1-X-Y+X*Y end}
    XorG =  {GateMaker fun {$ X Y} X+Y-2*X*Y end}
end

