*************************************************************************
***      SP - Shortest Path  - Funcion: Saltos                        ***
***                                                                   ***
***    Yezid E. Donoso Meisel                                         ***
*************************************************************************
Sets
  i   nodos red / n1*n10 /
alias(j,i)


set iter iteraciones /it1*it11/;

scalar w1 peso 1 / 0 /;
scalar w2 peso 2 / 0 /;

parameter w1_vec(iter) vector de valores de w1
                 /it1 1, it2 0.9, it3 0.8, it4 0.7, it5 0.6, it6 0.5, it7 0.4, it8 0.3, it9 0.2, it10 0.1, it11 0/;

parameter w2_vec(iter)  vector de valores de w1;

Table h(i,j) Costo del Enlace
                 n1       n2      n3      n4      n5      n6      n7      n8      n9     n10
n1               999       1       1     999     999       1     999     999     999     999
n2               999     999     999       1     999     999       3     999     999     999
n3               999     999     999     999       1       1     999     999     999     999
n4               999     999     999     999       1       1       1       1       1     999
n5               999     999     999     999     999       1     999     999       1       1
n6               999     999     999     999     999     999     999     999     999     999
n7               999     999     999     999     999     999     999       1     999     999
n8               999     999     999     999     999     999     999     999       1     999
n9               999     999     999     999     999     999     999     999     999       1
n10              999     999     999     999     999     999     999     999     999     999
;

h(j,i)$(h(i,j) lt 999)=h(i,j);

Table c(i,j) Costo del Enlace
                 n1       n2      n3      n4      n5      n6      n7      n8      n9     n10
n1               999       3       5     999     999       5     999     999     999     999
n2               999     999     999       3     999     999       2     999     999     999
n3               999     999     999     999       3       1     999     999     999     999
n4               999     999     999     999     0.2       1     0.3       1       3     999
n5               999     999     999     999     999       4     999     999     0.1       3
n6               999     999     999     999     999     999     999     999     999     999
n7               999     999     999     999     999     999     999       1     999     999
n8               999     999     999     999     999     999     999     999       1     999
n9               999     999     999     999     999     999     999     999     999       2
n10              999     999     999     999     999     999     999     999     999     999
;

c(j,i)$(c(i,j) lt 999)=c(i,j);


Variables
  x(i,j)      Indica si el enlace i j es utilizado o no en el SP
  z           minimizacion
  f1          funcion 1
  f2          funcion 2;

Binary Variable x;

Equations
Camino_Mas_Corto       Funcion Objetivo
nodo_origen(i)         nodo origen
nodo_destino(j)        nodo destino
nodo_intermedio        nodo intermedio
valor_f1                 resultado f1
valor_f2                 resultado f2;

Camino_Mas_Corto                    ..  z =e= w1*sum((i,j), h(i,j)*x(i,j)) + w2*sum((i,j), c(i,j) * x(i,j)) ;

nodo_origen(i)$(ord(i) = 1)         ..  sum((j), x(i,j)) =e= 1;

nodo_destino(j)$(ord(j) = 10)        ..  sum((i), x(i,j)) =e= 1;

nodo_intermedio(i)$(ord(i) <> 1 and ord(i) ne 10)
                                    ..  sum((j), x(i,j)) - sum((j), x(j,i)) =e= 0;

valor_f1                    ..      f1=e= sum((i,j), h(i,j)*x(i,j));

valor_f2                    ..      f2=e= sum((i,j), c(i,j) * x(i,j));


Model transport /all/ ;

parameter z_res(iter) "z results to store";

parameter f1_res(iter) "f1 results to store";

parameter f2_res(iter) "f2 results to store";

parameter x_res(i,j,iter) "x results to store";


loop (iter,
    w1=w1_vec(iter);
    w2=1 - w1_vec(iter);
    w2_vec(iter)=w2;

    option mip=BONMIN;
    Solve transport using mip minimizing z;
    z_res(iter)=z.l;
    f1_res(iter)=f1.l;
    f2_res(iter)=f2.l;
    x_res(i,j,iter)=x.l(i,j);

    );

display z_res;
display f1_res;
display f2_res;
display w1_vec;
display w2_vec;
display x_res;

file GAMSresults /D:\g_Doctorado\Docencia\monitoria modelado simulación y optimización\presentaciones clase\codes\GAMSresults_SP_Hops.dat/;
put GAMSresults;
loop(iter,
         put iter.tl, @5, f1_res(iter), @18, f2_res(iter) /

         );
