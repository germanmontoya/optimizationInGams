
Set i   tipos de paquete / p1, p2 /;
Set j   origenes  / o1, o2, o3 /;
Set k   destinos / d1, d2, d3, d4 /;

set iter iteraciones /it1*it11/;

scalar w1 peso 1 / 0 /;
scalar w2 peso 2 / 0 /;

parameter w1_vec(iter) vector de valores de w1
                 /it1 1, it2 0.9, it3 0.8, it4 0.7, it5 0.6, it6 0.5, it7 0.4, it8 0.3, it9 0.2, it10 0.1, it11 0/;

parameter w2_vec(iter)  vector de valores de w2;

Table c(j,k) costo del enlace jk
                  d1       d2      d3       d4
o1               10        9      10       11
o2                9       10      11       10
o3               11        9      10       10;

Table t(j,k) tiempo del enlace jk
                 d1       d2      d3       d4
o1               12       14      10       11
o2               11        8       7       13
o3                6       11       4       15;

Table inv(i,j) inventario
                  o1       o2       o3
p1                60       80       50
p2                20       20       30;

Table dem(i,k) demanda
                 d1      d2      d3       d4
p1               50      90      40       10
p2               10      20      10       30;


Variables
  x(i,j,k)      variable x_ij
  z           minimizacion
  f1          funcion 1
  f2          funcion 2;

Positive Variable x;

Equations
Enlaces_menos_costo       Funcion Objetivo

res1(i,j)         inventario

res2(i,k)         demanda

valor_f1                 resultado f1
valor_f2                 resultado f2;

valor_f1                    ..      f1=e= sum((i,j,k), c(j,k) * x(i,j,k));

valor_f2                    ..      f2=e= sum((i,j,k), t(j,k) * x(i,j,k));

*Enlaces_menos_costo        ..      z =e= w1*sum((i,j,k), c(j,k) * x(i,j,k)) + w2*sum((i,j,k), t(j,k) * x(i,j,k));

Enlaces_menos_costo        ..      z =e= w1*f1 + w2*f2;

res1(i,j)            ..      sum((k), x(i,j,k)) =l= inv(i,j);

res2(i,k)            ..      sum((j), x(i,j,k)) =e= dem(i,k);

*valor_f1                    ..      f1=e= sum((i,j,k), c(j,k) * x(i,j,k));

*valor_f2                    ..      f2=e= sum((i,j,k), t(j,k) * x(i,j,k));


Model transport /all/ ;

parameter z_res(iter) "z results to store";

parameter f1_res(iter) "f1 results to store";

parameter f2_res(iter) "f2 results to store";

parameter x_res(i,j,k,iter) "x results to store";


loop (iter,
    w1=w1_vec(iter);
    w2=1 - w1_vec(iter);
    w2_vec(iter)=w2;

    option lp=CPLEX;
    Solve transport using lp minimizing z;
    z_res(iter)=z.l;
    f1_res(iter)=f1.l;
    f2_res(iter)=f2.l;
    x_res(i,j,k,iter)=x.l(i,j,k);

    );

display z_res;
display f1_res;
display f2_res;
display w1_vec;
display w2_vec;
display x_res;

file GAMSresults /D:\g_Doctorado\Docencia\monitoria modelado simulación y optimización\presentaciones clase\codes\TransPaqGAMSresults_v1.dat/;
put GAMSresults;
loop(iter,
         put iter.tl, @5, f1_res(iter), @18, f2_res(iter) /

         );
