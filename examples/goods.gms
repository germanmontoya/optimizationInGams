*Modelo1

$ontext
Set i articulos
/a1   articulo 1
 a2   articulo 2
 a3   articulo 3
 a4   articulo 4
 a5   articulo 5
/;
$offtext

$Set TOTALARTICULOS  10

Set k   articulos / a1*a%TOTALARTICULOS% /;
Set i(k) cinco articulos /a1*a5/;
Set j(k) cuatro articulos /a2*a5/;

*Set i   articulos / 1, 2, 3, 4, 5 /;

*$Set NARTICULOS  5

*Set i   articulos / a1*a%NARTICULOS% /;

*alias (i, j) ;


$Set PRESUPUESTO  10

Scalar PRESUPUESTO presupuesto /%PRESUPUESTO%/;


Parameter  valor(i)   valor de cada articulo
                    /  a1 12, a2 5, a3 9, a4 6, a5 4  /;

Variables
  x(i)        Determino si selecciono el articulo i
  z           minimizacion;

Binary Variable x;

Equations
FunObj                      Funcion Objetivo

restriccion1                restriccion presupuesto;


FunObj              ..      z =e= sum(i, valor(i) * x(i));

restriccion1        ..      sum(i, valor(i) * x(i)) =e= PRESUPUESTO;

Model Modelo1 /all/ ;

option mip=CPLEX
Solve Modelo1 using mip minimizing z

Display x.l;


Display z.l;
