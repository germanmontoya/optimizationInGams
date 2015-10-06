*Modelo1



$ontext
set c countries
/ jamaica
haiti
guyana
brazil / ;

set p ports
/ kingston
s-domingo
georgetown
belem / ;

set ptoc(p, c) port to country relationship
/ kingston .jamaica
s-domingo .haiti
georgetown .guyana
belem .brazil /;

Display c;
Display p;
Display ptoc;

$offtext

$ontext
set i / a, b /
j / c, d, e /
ij1(i,j) /a.c, a.d/
ij2(i,j) /a.c, b.c/
ij3(i,j) /a.c, b.c, a.d, b.d/ ;
$offtext

$ontext
set i / a, b /
j / c, d, e /
ij1(i,j) /a.(c,d)/
ij2(i,j) /(a,b).c/
ij3(I,j) /(a,b).(c,d)/ ;

Display i,j,ij1,ij2,ij3;
$offtext

set t / 1985*1990 /
parameter pop(t) / 1985 3456 /
growth(t) / 1985 25.3, 1986 27.3, 1987 26.2
            1988 27.1, 1989 26.6, 1990 26.6 /;
loop(t,
         pop(t+1) = pop(t) + growth(t) ) ;

Display pop;

loop(i$(curacc > reltol),
         value(i+1) = 0.5*(value(i) + target/value(i));
         sqrtval = value(i+1);
         curacc = abs (value(i+1)-value(i))/(1+abs(value(i+1)))
) ;

if (f <= 0,
    p(i) = -1 ;
    q(j) = -1 ;
elseif ((f > 0) and (f < 1)),
    p(i) = p(i)**2 ;
    q(j) = q(j)**2 ;
else
    p(i) = p(i)**3 ;
    q(j) = q(j)**3 ;
    ) ;

scalar i ;
scalar globmin ; globmin = inf ;
for (i = 1 to 1000,
    a(j) = uniform(0,1) ;
    solve ml using nlp minimizing obj ;
    if (obj.l le globmin,
       globmin = obj.l ;
       ) ;
    count = count+1 ;
    ) ;


