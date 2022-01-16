declare 
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
declare
AndG =  {GateMaker fun {$ X Y} X*Y end}
OrG =   {GateMaker fun {$ X Y} X+Y-X*Y end}
NandG = {GateMaker fun {$ X Y} 1-X*Y end}
NorG =  {GateMaker fun {$ X Y} 1-X-Y+X*Y end}
XorG =  {GateMaker fun {$ X Y} X+Y-2*X*Y end}    

% declare
% X = 1|_
% Y = 1|_
% Z = 0|_

%Testando portas logicas
% {Browse{AndG X Y}} % 1 1 -> 1
% {Browse{AndG X Z}} % 1 0 -> 0
% {Browse{AndG Z Z}} % 0 0 -> 0

% {Browse{OrG X Y}} % 1 1 -> 1
% {Browse{OrG X Z}} % 1 0 -> 1
% {Browse{OrG Z Z}} % 0 0 -> 0

% {Browse{XorG X Y}} % 1 1 -> 0
% {Browse{XorG X Z}} % 1 0 -> 1

proc {FullAdder X Y Z ?C ?S}
    K L M
in
    K={AndG X Y}?
    L={AndG Y Z}
    M={AndG X Z}
    C={OrG K {OrG L M}}
    S={XorG Z {XorG X Y}}
end

% declare
% X=1|1|0|_
% Y=0|1|0|_
% Z=1|1|1|_ C S in
% {FullAdder X Y Z C S}
% {Browse inp(X Y Z)#sum(C S)}

declare
fun {DelayG Xs}
    0|Xs
end

fun {Latch C DI}
    DO X Y Z F
in
    F={DelayG DO}
    X={AndG F C}
    Z={NotG C}
    Y={AndG Z DI}
    DO={OrG X Y}
    DO
end

fun {Clock}
    fun {Loop B}
        {Delay 1000} B|{Loop B}
    end
in
    thread {Loop 1} end
end


/*
------------------------------------------------------------------------------------------

The program from now on does not appear on ctmcp, these are implementations for a college work.
Circuitos implementados: 
1 ExcOrG. Ou exclusivo(a partir de portas lógicas menores, 2 inputs, 1 output)
2 Circ2. AND para 4 variáveis booleanas (4 inputs, 1 output)
3 Circ3. Soma de um digito binaria (2 inputs, 2 outputs onde o output é a parte mais significativa e menos significativa da soma)
4 Circ4. Verificação de pares ordenados, caso 2 tenham valor Falso retornaremos falso. (3 inputs, 1 output)

------------------------------------------------------------------------------------------
*/

proc {ExcOrG X Y ?R} %Exclusive Or with minor gates.
    K L M N
in
    K = {NotG X}
    L = {NotG Y}
    M = {AndG X L}
    N = {AndG Y K}
    R = {OrG M N}
end

% declare
% X=1|_
% Y=0|_ Z in
% {ExcOrG X X Z}
% {Browse inp(X X)#output(Z)}

proc {Circ2 W X Y Z ?R} % (((W AND X) AND Y) AND Z)
    K L 
in
    K = {AndG W X}
    L = {AndG K Y}
    R = {AndG L Z}
end

% declare
% W = 1|_
% X = 0|_ 
% Y = 1|_
% Z = 0|_ R in
% {Circ2 W W W X ?R}
% {Browse inp(W W W X)#output(R)}

proc {Circ3 X Y ?C ?S} % (SIMPLE SUM (One digit sum)) 
    K L M
in
    K = {AndG X Y}
    L = {XorG X Y}
    C = K 
    S = L
end

% declare
% X = 1|_ 
% Y = 1|_ C S in
% {Circ3 X Y ?C ?S}
% {Browse inp(X Y)#output(C S)}

proc {Circ4 X Y Z ?R} % (XvY) ^ (XvZ) ^ (YvZ) **returns 0 when 2 or more variables equals 0
    K L M N
in
    K = {OrG X Y}
    L = {OrG X Z}
    M = {OrG Y Z}
    N = {AndG K L}
    R = {AndG N M}
end

% declare
% X = 1|_ 
% Y = 1|_ 
% Z = 0|_ R in
% {Circ4 X Y Z ?R}
% {Browse inp(X Y Z)#output(R)}

% -------------------- Main --------------------

declare
X = 1|_
Y = 0|_ R in
{ExcOrG X Y ?R} 
{Browse inp(X Y)#output(R)}

declare
W = 1|_
X = 0|_ 
Y = 1|_
Z = 0|_ R in
{Circ2 W X Y Z ?R}
{Browse inp(W X Y Z)#output(R)}

declare
X = 1|_ 
Y = 0|_ C S in
{Circ3 X Y ?C ?S}
{Browse inp(X Y)#output(C S)}

declare
X = 1|_ 
Y = 1|_ 
Z = 0|_ R in
{Circ4 X Y Z ?R}
{Browse inp(X Y Z)#output(R)}








    