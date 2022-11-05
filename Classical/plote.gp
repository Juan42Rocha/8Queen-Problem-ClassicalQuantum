set term wxt persist



file(n) = word("N10-T0.0-Mts1000-Rel3000.dat  N10-T0.15-Mts1000-Rel3000.dat N10-T0.3-Mts1000-Rel3000.dat  N10-T0.44999999999999996-Mts1000-Rel3000.dat N10-T0.6-Mts1000-Rel3000.dat N10-T0.75-Mts1000-Rel3000.dat N10-T0.8999999999999999-Mts1000-Rel3000.dat N10-T1.05-Mts1000-Rel3000.dat N10-T1.2-Mts1000-Rel3000.dat N10-T1.3499999999999999-Mts1000-Rel3000.dat N10-T1.5-Mts1000-Rel3000.dat",n)

set key l 


pl for [k=1:11] file(k) u (10/$0):2 w l  t gprintf("T = %G",0.015*(k-1))
