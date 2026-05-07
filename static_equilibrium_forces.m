syms F1 F2 F3 F4

eq1 = (0.212132+0.000955)*(-F1) + (0.212132-0.000955)*F2 + (0.212132-0.000955)*F3 - (0.212132+0.000955)*F4 == 0;
eq2 = F1 - F4 == 0;
eq3 = F1 + F2 + F3 + F4 == 2.409*9.81;
eq4 = -0.212132*F1 - 0.212132*F2 + 0.212132*F3 + 0.212132*F4 == 0;

sol = solve([eq1, eq2, eq3, eq4], [F1, F2, F3, F4]);

F1_sol = double(sol.F1)
F2_sol = double(sol.F2)
F3_sol = double(sol.F3)
F4_sol = double(sol.F4)