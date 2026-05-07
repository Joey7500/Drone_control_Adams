# Návrh a řízení nelineárního modelu dronu

**Autor:** Josef Hruška

Tento projekt se zabývá fyzikálním návrhem, kinematickou a dynamickou analýzou a syntézou kaskádního řízení (PID + LQR) pro nelineární, asymetrický model dronu.

## 🛠️ Použité technologie a nástroje
* **Autodesk Inventor:** Tvorba 3D CAD modelu a definice asymetrické distribuce hmotnosti.
* **MSC Adams:** Simulace kinematiky a dynamiky (6 DOF volné těleso) a export stavového modelu.
* **MATLAB / Simulink:** Výpočet stavové zpětné vazby, návrh regulačních smyček a testování vlivu poruch.

## ⚙️ Fyzikální návrh a modelování
Záměrem projektu bylo vytvořit dron s **asymetrickou distribucí hmotnosti** (těžiště není v geometrickém středu) pomocí součástí s různou hustotou a tvarem. Tento přístup simuluje reálné podmínky a klade vyšší nároky na robustnost regulátoru.

V prostředí MSC Adams bylo těleso modelováno s následujícími parametry:
* **12 stavových měření:** Eulerovy úhly (roll, pitch, yaw), úhlové rychlosti a zrychlení, globální souřadnice těžiště.
* **Akční zásahy a poruchy:** 4x tah motorů (Thrust), 4x krouticí moment (Torque) a 3 prostorové síly (Fx, Fy, Fz) reprezentující vítr.

## 🧠 Strategie řízení (Kaskádní regulace)
Pro řízení nelineárního modelu (exportovaného přes `adams_sys`) byla po ověření plné řiditelnosti (`rank = 12`) využita kaskádní struktura:

### Vnější smyčka (Navigace)
* Využívá **PID regulátory** pro sledování trajektorie v osách X a Z.
* Výstupem regulátoru je požadovaný úhel náklonu, který je z důvodu zachování linearity a fyzikální ochrany omezen saturačními bloky (např. na ±15°).

### Vnitřní smyčka (Stabilizace)
* Využívá **LQR regulátor** pracující nad transformovaným modelem (pomocí matice senzorů $C$).
* **Matice Q a R:** Byla zvolena agresivní stabilizace úhlů (váha 100 pro orientaci, 10 pro úhlové rychlosti a zrychlení, 1 pro translační pozice). Matice R byla nastavena na 0.1 pro maximální využití dynamiky motorů.

### Řízení výšky a Hover (Feed-forward)
* Vertikální dynamika je dekaplována (oddělena) mimo hlavní LQR smyčku, jelikož vyžaduje změnu kolektivního tahu všech motorů současně.
* Systém využívá neustálé přičítání statického tahu (cca 5.9 N na motor) pro kompenzaci gravitace v rovnovážném bodě (Hover), takže LQR řeší pouze dynamické odchylky.

## 🌪️ Testování a robustnost
Regulátor byl úspěšně podroben sérii testů:
1. **Stabilizace (Hover):** Udržení fixní výšky a orientace.
2. **Setpoint tracking:** Let na žádané souřadnice (např. testováno na skok [2, 1, 1]).
3. **Dynamická trajektorie:** Sledování složité Lissajousovy křivky (osmičky).
4. **Vliv poruch (Vítr):** Modelováno pomocí bílého šumu (Band-Limited White Noise) a dolní propusti jako zjednodušená aproximace Drydenova modelu turbulencí.

**Výsledky:** Kombinace LQR a PID se ukázala jako vysoce efektivní i pro tento asymetrický systém. Při simulaci nárazového větru o síle 3–5 N činí odchylka od cílové trajektorie pouze 10–15.
