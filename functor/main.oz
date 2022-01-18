declare[XorG] = {Module.link ['c:/users/matheus/desktop/cap4/functor/excorg.ozf']}
declare[Circuit2] = {Module.link ['c:/users/matheus/desktop/cap4/functor/circ2.ozf']}
declare[Circuit3] = {Module.link ['c:/users/matheus/desktop/cap4/functor/circ3.ozf']}
declare[Circuit4] = {Module.link ['c:/users/matheus/desktop/cap4/functor/circ4.ozf']}

/*  ------------------------------------------------------------------------------------------

    Circuitos implementados: 
    1 ExcOrG. Ou exclusivo(a partir de portas lógicas menores, 2 inputs, 1 output)
    2 Circ2. AND para 4 variáveis booleanas (4 inputs, 1 output)
    3 Circ3. Soma de um digito binaria (2 inputs, 2 outputs onde o output é a parte mais significativa e menos significativa da soma)
    4 Circ4. Verificação de pares ordenados, caso 2 tenham valor Falso retornaremos falso. (3 inputs, 1 output)
    
    ------------------------------------------------------------------------------------------
*/

% -------------------- Main --------------------
declare
X = 1|_
Y = 0|_ R in
{XorG.xorg X Y ?R} 
{Browse inp(X Y)#output(R)}

declare
W = 1|_
X = 0|_ 
Y = 1|_
Z = 0|_ R in
{Circuit2.circ2 W X Y Z ?R}
{Browse inp(W X Y Z)#output(R)}

declare
X = 1|_ 
Y = 0|_ C S in
{Circuit3.circ3 X Y ?C ?S}
{Browse inp(X Y)#output(C S)}

declare
X = 1|_ 
Y = 1|_ 
Z = 0|_ R in
{Circuit4.circ4 X Y Z ?R}
{Browse inp(X Y Z)#output(R)}

