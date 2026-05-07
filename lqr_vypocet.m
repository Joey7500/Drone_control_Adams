% 1. Převedení A a B matic do normálního "Senzorového" světa
A_new = ADAMS_c * ADAMS_a * inv(ADAMS_c);
B_new = ADAMS_c * ADAMS_b;

% 2. Kontrola řiditelnosti (musí vyjít zase 12!)
rank(ctrb(A_new, B_new))

% 3. Výpočet té správné matice pro Simulink
Q_diag = [1, 1, 1, 10, 10, 10, 100, 100, 100, 10, 10, 10];
Q = diag(Q_diag);
R = 0.1 * eye(8);

K_new = lqr(A_new, B_new, Q, R);
disp('Matice K_new je hotová a opravená!');