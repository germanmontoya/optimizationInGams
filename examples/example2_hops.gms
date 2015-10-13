*************************************************************************
***      Minimizing the number of hops in a directed graph            ***
***                                                                   ***
***      Author: Germán Montoya                                       ***
***      Universidad de Los Andes, Bogotá, Colombia                   ***
*************************************************************************

Sets
  i   network nodes / n1, n2, n3, n4, n5 /

alias(j,i);

Table c(i,j) link cost
                 n1      n2      n3      n4      n5
n1               999     1       1       999     999
n2               999     999     999     999     1
n3               999     999     999     1       999
n4               999     999     999     999     1
n5               999     999     999     999     999;


Variables
  x(i,j)      Indicates if the link i-j is selected or not.
  z           Objective function  ;

Binary Variable x;

Equations
objectiveFunction        objective function
sourceNode(i)            source node
destinationNode(j)       destination node
intermediateNode         intermediate node;

objectiveFunction                                  ..  z =e= sum((i,j), c(i,j) * x(i,j));

sourceNode(i)$(ord(i) = 1)                         ..  sum((j), x(i,j)) =e= 1;

destinationNode(j)$(ord(j) = 5)                    ..  sum((i), x(i,j)) =e= 1;

intermediateNode(i)$(ord(i) <> 1 and ord(i) ne 5)  ..  sum((j), x(i,j)) - sum((j), x(j,i)) =e= 0;

Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip minimizing z;

Display x.l;
Display z.l;
