# Návrh a řízení nelineárního modelu dronu

**Autor:** Josef Hruška [cite: 2]

Tento projekt se zabývá fyzikálním návrhem, kinematickou a dynamickou analýzou a syntézou kaskádního řízení (PID + LQR) pro nelineární, asymetrický model dronu[cite: 1, 4, 27].

## 🛠️ Použité technologie a nástroje
* **Autodesk Inventor:** Tvorba 3D CAD modelu a definice asymetrické distribuce hmotnosti[cite: 3, 4].
* **MSC Adams:** Simulace kinematiky a dynamiky (6 DOF volné těleso) a export stavového modelu[cite: 8, 10, 19].
* **MATLAB / Simulink:** Výpočet stavové zpětné vazby, návrh regulačních smyček a testování vlivu poruch[cite: 21].

## ⚙️ Fyzikální návrh a modelování
Záměrem projektu bylo vytvořit dron s **asymetrickou distribucí hmotnosti** (těžiště není v geometrickém středu) pomocí součástí s různou hustotou a tvarem[cite: 4, 5, 6]. Tento přístup simuluje reálné podmínky a klade vyšší nároky na robustnost regulátoru[cite: 5].

V prostředí MSC Adams bylo těleso modelováno s následujícími parametry:
* **12 stavových měření:** Eulerovy úhly (roll, pitch, yaw), úhlové rychlosti a zrychlení, globální souřadnice těžiště[cite: 11, 12, 13, 14].
* **Akční zásahy a poruchy:** 4x tah motorů (Thrust), 4x krouticí moment (Torque) a 3 prostorové síly (Fx, Fy, Fz) reprezentující vítr[cite: 15, 16, 17].

## 🧠 Strategie řízení (Kaskádní regulace)
Pro řízení nelineárního modelu (exportovaného přes `adams_sys`) byla po ověření plné řiditelnosti (`rank = 12`) využita kaskádní struktura[cite: 21, 25, 27]:

### Vnější smyčka (Navigace)
* Využívá **PID regulátory** pro sledování trajektorie v osách X a Z[cite: 28, 29].
* Výstupem regulátoru je požadovaný úhel náklonu, který je z důvodu zachování linearity a fyzikální ochrany omezen saturačními bloky (např. na ±15°)[cite: 30, 32, 33, 34, 35].

### Vnitřní smyčka (Stabilizace)
* Využívá **LQR regulátor** pracující nad transformovaným modelem (pomocí matice senzorů $C$)[cite: 22, 36, 37].
* **Matice Q a R:** Byla zvolena agresivní stabilizace úhlů (váha 100 pro orientaci, 10 pro úhlové rychlosti a zrychlení, 1 pro translační pozice). Matice R byla nastavena na 0.1 pro maximální využití dynamiky motorů[cite: 23, 24].

### Řízení výšky a Hover (Feed-forward)
* Vertikální dynamika je dekaplována (oddělena) mimo hlavní LQR smyčku, jelikož vyžaduje změnu kolektivního tahu všech motorů současně[cite: 39, 40, 41, 42].
* Systém využívá neustálé přičítání statického tahu (cca 5.9 N na motor) pro kompenzaci gravitace v rovnovážném bodě (Hover), takže LQR řeší pouze dynamické odchylky[cite: 43, 45, 46, 47].

## 🌪️ Testování a robustnost
Regulátor byl úspěšně podroben sérii testů:
1. **Stabilizace (Hover):** Udržení fixní výšky a orientace[cite: 54].
2. **Setpoint tracking:** Let na žádané souřadnice (např. testováno na skok [2, 1, 1])[cite: 55, 62].
3. **Dynamická trajektorie:** Sledování složité Lissajousovy křivky (osmičky)[cite: 56].
4. **Vliv poruch (Vítr):** Modelováno pomocí bílého šumu (Band-Limited White Noise) a dolní propusti jako zjednodušená aproximace Drydenova modelu turbulencí[cite: 49, 50, 51].

**Výsledky:** Kombinace LQR a PID se ukázala jako vysoce efektivní i pro tento asymetrický systém[cite: 59]. Při simulaci nárazového větru o síle 3–5 N činí odchylka od cílové trajektorie pouze 10–15 %[cite: 61].
