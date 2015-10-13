*************************************************************************
***      Minimizing the selection of goods                            ***
***                                                                   ***
***      Author: Germán Montoya                                       ***
***      Universidad de Los Andes, Bogotá, Colombia                   ***
*************************************************************************

*Model1

Set i   articles / a1, a2, a3, a4, a5 /;

Scalar BUDGET budget /10/;

Parameter  value(i)   value of each article
                    /  a1 12, a2 5, a3 9, a4 6, a5 4  /;

Variables
  x(i)        Inidicates if the article is bought or not
  z           objective function;

Binary Variable x;

Equations
objectiveFunction               objective function

budgetConstraint                budget constraint;


objectiveFunction       ..      z =e= sum(i, value(i) * x(i));

budgetConstraint        ..      sum(i, value(i) * x(i)) =e= BUDGET;

Model Model1 /all/ ;

option mip=CPLEX
Solve Model1 using mip minimizing z

Display x.l;
Display z.l;


