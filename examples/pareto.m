clc, clear all, close all

[iter, f1, f2] = textread('GAMSresults_SP_Hops.dat', '%s %f %f', 20);

figure
plot(f1,f2,'-o')