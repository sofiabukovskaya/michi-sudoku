# Zásady ochrany soukromí

**Návrh ke kontrole.** Správcem údajů MICHI je {{CONTROLLER}} se sídlem v {{COUNTRY}}. Žádosti o ochranu soukromí: [{{EMAIL}}](mailto:{{EMAIL}}).

## Co zůstává v zařízení

- Místní databáze uchovává rozehrané a dokončené hry, pokrok v technikách, dokončené denní úlohy a importované mřížky.
- Místní nastavení uchovává úroveň a dokončení úvodu, jazyk, připomínku série, osobní rekordy, vyřešené dny Spot it, zobrazená razítka v zápisníku a volbu sdílení pádů.
- S tvým svolením skener přečte snímek z fotoaparátu nebo vybranou fotku. Model TensorFlow Lite ji zpracuje v zařízení. MICHI fotky nenahrává. Po načtení se pokusí dočasný snímek smazat. Originál v galerii zůstane. Interní diagnostická sestavení mohou ponechat místní soubory skenu.
- Připomínka série se po zapnutí plánuje v zařízení podle místních časů dokončení. Vypneš ji v nastavení aplikace nebo odebráním oprávnění k oznámením.

## Účet a synchronizace

Při hraní bez účtu zůstává pokrok místní. Při registraci e-mailem Firebase Authentication zpracovává jméno, e-mail, heslo a identifikátor účtu. Pokud sestavení umožňuje přihlášení přes Google nebo Apple a zvolíš ho, poskytovatel ověří přihlášení a Firebase dostane přihlašovací údaje a dostupné profilové údaje, například jméno a e-mail.

Po přihlášení Cloud Firestore synchronizuje dokončené hry, denní úlohy a pokrok v technikách včetně příspěvků jednotlivých instalací. U dokončené importované hry se mohou synchronizovat počáteční i vyřešená číselná mřížka, časy, chyby a použití nápověd. Rozehrané hry se nesynchronizují. Starší záznamy připomínky v 8:00 mohou obsahovat ID instalace, platformu, jazyk, časové pásmo, push token a nastavení rozvrhu.

## Služby pro všechny

- Firebase Remote Config poskytuje nastavení funkcí a obsahu. Firestore poskytuje vydané úlohy a denní sudoku. Služby dostávají běžné technické údaje požadavku, například IP adresu a případné údaje o SDK nebo instalaci.
- Sada Firebase Messaging je stále součástí aplikace. Může vytvořit identifikátory instalace a registrace push, i když používáš jen místní připomínku.
- Firebase App Check ověřuje aplikaci a zařízení pomocí Play Integrity nebo App Attest s náhradou DeviceCheck a pomáhá bránit zneužití.
- Firebase Crashlytics pomáhá odhalovat pády. Zprávy mohou obsahovat trasu zásobníku, model zařízení, systém, verzi aplikace a údaje o instalaci. Sdílení je ve vydaných sestaveních ve výchozím stavu zapnuté. Volbu změníš v Nastavení → O MICHI. Vypnutí zastaví nové hlášení chyb v Dartu. Změna v nativním SDK může nastat při příštím spuštění. Už odeslané zprávy zůstanou a SDK může pády ukládat místně i při vypnutém sdílení.

Shromažďování ve Firebase Analytics je vypnuté. MICHI nezobrazuje reklamy, nesleduje tě napříč aplikacemi a neprodává údaje. Platební údaje teď neshromažďuje. Pokud přibudou nákupy MICHI Plus, zpracuje je Apple nebo Google podle vlastních podmínek.

## Poskytovatelé, uchování a práva

Google poskytuje [služby Firebase](https://firebase.google.com/support/privacy). Apple může zpracovávat ověření zařízení a volitelné údaje přihlášení. Firebase může údaje zpracovávat mimo tvoji zemi. Funkce mazání účtu běží v europe-west1, což neurčuje umístění všech služeb. Firebase Authentication zpracovává údaje účtu ve Spojených státech. Když nám napíšeš, použijeme tvůj e-mail a obsah zprávy k odpovědi.

Místní data zůstanou do smazání v aplikaci, vymazání úložiště nebo odinstalování, s ohledem na zálohy systému. Synchronizovaná data uchováváme do smazání účtu. Doba uchování ve Firebase se liší podle služby. {{RETENTION}} {{LEGAL_BASIS_TRANSFERS}}

Podle platného práva můžeš požádat o přístup, opravu, výmaz, omezení nebo přenos údajů, vznést námitku či podat stížnost u dozorového úřadu. Napiš na [{{EMAIL}}](mailto:{{EMAIL}}). Oprávnění k fotoaparátu, fotkám a oznámením změníš v nastavení zařízení.

## Zpětná vazba

Při odeslání uložíme kategorii, zprávu, nepovinný e-mail pro odpověď a podle tvé volby verzi a sestavení aplikace, platformu, verzi systému, model zařízení, jazyk a stav přihlášení. E-mail použijeme jen k odpovědi. ID instalace a po přihlášení i ID účtu slouží k omezení zneužití. Při přihlášení ukládáme ID účtu také se zprávou. Provozovatel MICHI může zprávu dostat e-mailem. Po zapnutí pravidla uchování se mají záznamy ve Firestore mazat po 24 měsících. Uchování e-mailových kopií upravuje {{RETENTION}}. Neodeslané zprávy zůstávají v zařízení do odeslání nebo vymazání úložiště. Fotky ze skeneru se nepřikládají.

## Jak smazat účet

Přihlas se a otevři **Profil → Nastavení → Účet → Smazat účet**. Firebase smaže účet a spustí odstranění her, pokroku a připomínek z cloudu. MICHI odstraní místní profil účtu z tohoto zařízení. Údaje hosta a kopie v jiných zařízeních mohou zůstat. Pokud aplikaci nemůžeš použít, napiš na [{{EMAIL}}](mailto:{{EMAIL}}) z adresy svého účtu a požádej o odstranění účtu MICHI a souvisejících údajů. Heslo neposílej. Můžeme ověřit, že ti účet patří.
