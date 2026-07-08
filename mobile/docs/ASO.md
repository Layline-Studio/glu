# ASO Keywords

App store search optimization reference: current title/subtitle, the iOS
keyword field per locale, Google Play description guidance, and a broader
keyword bank to draw from when either changes.

Update this file whenever `docs/whats-new.md` ships a new tracker or a
gating change (Pro vs. free) — those are exactly the kind of high-intent,
low-competition terms worth adding.

---

## Current listing (don't duplicate these words in the keyword field)

Apple concatenates **title + subtitle + keyword field** for indexing, so
repeating a word from the title/subtitle in the keywords wastes character
budget.

- **iOS title:** Glu - GLP-1 Weight Loss Tracker
- **iOS subtitle:** Medication & Weight Tracker
- **Android title:** Glu — GLP-1 Weight Loss Tracker

Words already covered: `glu`, `glp-1` / `glp1`, `weight`, `loss`, `tracker`,
`medication`. None of these belong in the keyword field below.

---

## iOS keyword field (100-char limit, comma-separated, no spaces)

Apple auto-pluralizes and matches partial words, so keep terms singular
and avoid near-duplicates (`injection` already partially matches
`injections`). Prioritized brand names first — people overwhelmingly
search their own medication's name, not a generic category term.

| Locale | Keyword field | Chars |
|---|---|---|
| en-US | `ozempic,wegovy,mounjaro,zepbound,rybelsus,saxenda,trulicity,semaglutide,tirzepatide,cravings` | 92 |
| es-ES | `ozempic,wegovy,mounjaro,zepbound,rybelsus,saxenda,trulicity,semaglutida,tirzepatida,antojos` | 91 |
| pt-BR | `ozempic,wegovy,mounjaro,zepbound,rybelsus,saxenda,trulicity,semaglutida,tirzepatida,desejos` | 91 |
| fr-FR | `ozempic,wegovy,mounjaro,zepbound,rybelsus,saxenda,trulicity,semaglutide,tirzepatide,envies` | 90 |
| de-DE | `ozempic,wegovy,mounjaro,zepbound,rybelsus,saxenda,trulicity,semaglutid,tirzepatid,heisshunger` | 93 |
| it-IT | `ozempic,wegovy,mounjaro,zepbound,rybelsus,saxenda,trulicity,semaglutide,tirzepatide,voglie` | 90 |

Notes:
- German drops the `ß` in `heisshunger` (ASCII `ss` instead) — matches how
  most people actually type on a non-German keyboard, and avoids any risk
  of Apple's field mangling the special character.
- German generic names drop the trailing `-e` (`Semaglutid`, `Tirzepatid`
  is the correct German pharma spelling, not `-ide`).
- The remaining locales (ar, da, fi, hi, nl, no, ru, sv, zh) aren't filled
  in yet — follow the same pattern: 8 brand/generic names, 1 slot for the
  locale's word for "cravings" (already established in the app's ARB
  files as `homeCravingsTitle` per locale), fit to ≤100 chars.
- Re-verify char counts with a script before submitting — Apple rejects
  (doesn't truncate) fields over the limit:
  `python3 -c "print(len('...'))"`.

---

## Google Play

Play has no dedicated keyword field — indexing comes from the title,
short description (80 chars), and full description. Keywords need to
appear naturally in that copy instead of a packed list.

**Short description (74/80 chars):**
`GLP-1 tracker for doses, weight, symptoms, cravings & doctor-ready reports`

**Full description guidance:**
- Open with 2-3 branded medication names in the first paragraph (indexed
  more heavily than later text): *"Track Ozempic, Wegovy, Mounjaro,
  Zepbound, or Rybelsus doses alongside weight, symptoms, and mood."*
- Use one paragraph per major feature (dose reminders, symptom log,
  cravings tracker, doctor report) so each feature's terms appear near
  its own explanation rather than stacked in a keyword dump.
- Repeat the highest-intent terms (drug names, "GLP-1", "weight loss")
  2-3 times across the description — Play's algorithm weighs frequency,
  unlike Apple's exact-match keyword field.

---

## Keyword research table

Broader than what fits in the 100-char field — the working list for
deciding what actually goes in each locale's keyword field / description
copy. `Popularity` and `Difficulty` are blank on purpose (fill in from
App Store Connect's keyword research, Apple Search Ads suggested bids, or
a third-party tool like AppTweak/Sensor Tower/data.ai) — everything below
is the candidate list, not the final decision.

Scoring convention once filled in: 1-100 for both, higher popularity =
more search volume, higher difficulty = harder to rank for (more
competition). The sweet spot for a smaller app is high popularity + low
difficulty; anything high/high is aspirational (paid Search Ads
territory, not organic).

### Medication brand names
*(highest intent — people search their own drug; used as-is across
locales, brand names don't translate)*

| Keyword | Popularity | Difficulty | Notes |
|---|---|---|---|
| ozempic | | | already in en/es/pt/fr/de/it keyword fields |
| wegovy | | | already in en/es/pt/fr/de/it keyword fields |
| mounjaro | | | already in en/es/pt/fr/de/it keyword fields |
| zepbound | | | already in en/es/pt/fr/de/it keyword fields |
| rybelsus | | | already in en/es/pt/fr/de/it keyword fields |
| saxenda | | | already in en/es/pt/fr/de/it keyword fields |
| victoza | | | not yet in any keyword field |
| trulicity | | | already in en/es/pt/fr/de/it keyword fields |
| byetta | | | not yet in any keyword field |
| bydureon | | | not yet in any keyword field |

### Generic / clinical names

| Keyword | Popularity | Difficulty | Notes |
|---|---|---|---|
| semaglutide | | | |
| tirzepatide | | | |
| liraglutide | | | |
| dulaglutide | | | |
| exenatide | | | |
| compounded semaglutide | | | lower competition, real search volume per web glossary |
| retatrutide | | | early/emerging drug, low competition |

### Generic intent terms, by locale
*(the category the current keyword bank was missing — "weight loss" and
its equivalents, translated per app locale, not just brand names)*

| Keyword | Locale | Popularity | Difficulty | Notes |
|---|---|---|---|---|
| weight loss | en-US | | | very high competition, generic |
| weight loss app | en-US | | | |
| diet app | en-US | | | |
| appetite suppressant | en-US | | | |
| pérdida de peso | es-ES | | | |
| app para bajar de peso | es-ES | | | |
| control de apetito | es-ES | | | |
| perda de peso | pt-BR | | | |
| app para emagrecer | pt-BR | | | |
| controle de apetite | pt-BR | | | |
| perte de poids | fr-FR | | | |
| application minceur | fr-FR | | | |
| coupe-faim | fr-FR | | | |
| Gewichtsverlust | de-DE | | | |
| Abnehmen App | de-DE | | | |
| Appetitzügler | de-DE | | | |
| perdita di peso | it-IT | | | |
| app dimagrimento | it-IT | | | |
| controllo appetito | it-IT | | | |
| gewichtsverlies | nl-NL | | | |
| afvallen app | nl-NL | | | |
| eetlustremmer | nl-NL | | | |
| vægttab | da-DK | | | |
| slankeapp | da-DK | | | |
| appetitdæmper | da-DK | | | |
| painonpudotus | fi-FI | | | |
| laihdutussovellus | fi-FI | | | |
| ruokahalun hallinta | fi-FI | | | |
| vektnedgang | no-NO | | | |
| slankeapp | no-NO | | | |
| appetittkontroll | no-NO | | | |
| viktnedgång | sv-SE | | | |
| bantningsapp | sv-SE | | | |
| aptitkontroll | sv-SE | | | |
| похудение | ru-RU | | | |
| приложение для похудения | ru-RU | | | |
| снижение аппетита | ru-RU | | | |
| 减肥 | zh-CN | | | |
| 减重应用 | zh-CN | | | |
| 食欲控制 | zh-CN | | | |
| वजन घटाना | hi-IN | | | |
| वजन घटाने का ऐप | hi-IN | | | |
| भूख नियंत्रण | hi-IN | | | |
| فقدان الوزن | ar | | | |
| تطبيق إنقاص الوزن | ar | | | |
| كبح الشهية | ar | | | |

### Feature terms
*(mirror exact in-app naming from `PRODUCT.md`)*

| Keyword | Popularity | Difficulty | Notes |
|---|---|---|---|
| dose reminder | | | |
| injection tracker | | | |
| injection log | | | |
| symptom tracker | | | |
| side effects | | | |
| cravings tracker | | | new in 1.6.0 |
| food noise | | | new in 1.6.0; also a web glossary/guide term |
| mood tracker | | | |
| water tracker | | | |
| portion check | | | Pro feature |
| glow up | | | |
| progress photos | | | |
| doctor report | | | Pro feature |
| injection site rotation | | | |
| dose adherence | | | |

### Competitor apps (conquesting)
*(using a competitor's brand name as a keyword/in Search Ads is standard
ASO practice — factual comparison only, see caution below)*

| Keyword | Popularity | Difficulty | Notes |
|---|---|---|---|
| Shotsy | | | GLP-1/weight-shot tracker, closest direct competitor |
| DreamMe | | | confirm exact positioning before targeting |
| Glapp | | | confirm exact positioning before targeting |
| MyFitnessPal | | | generic fitness tracker, no GLP-1/medication context |
| Noom | | | behavioral coaching, subscription model |
| Lose It | | | generic food/exercise logger |
| Found | | | GLP-1 prescription service, not a daily-use app |
| Sequence | | | GLP-1 prescription service, not a daily-use app |

### Symptom / side-effect long-tail
*(from the web glossary — already-researched SEO terms, low competition,
high relevance)*

| Keyword | Popularity | Difficulty | Notes |
|---|---|---|---|
| ozempic face | | | |
| GLP-1 hair loss | | | |
| sarcopenia | | | |
| lean mass loss | | | |
| gastroparesis | | | |
| hypoglycemia | | | |
| metabolic adaptation | | | |
| nausea relief | | | |
| constipation relief | | | |

---

## Trademark note

Ozempic, Wegovy, Mounjaro, Zepbound, Rybelsus, Saxenda, Victoza, and
Trulicity are registered trademarks of Novo Nordisk and Eli Lilly. Using
them factually (to describe compatibility — "track your Ozempic doses")
is standard practice across the GLP-1 tracker category and is what the
web copy already does (see Hero compatibility line). Don't imply
sponsorship, endorsement, or affiliation with the manufacturers in any
listing copy.

**Competitor names** (Shotsy, DreamMe, Glapp, MyFitnessPal, Noom, etc.)
are a different situation — those are competitors' own product
trademarks, not a compatibility claim:
- Fine for **paid Apple Search Ads / Google App Campaigns** conquesting
  (bidding on a competitor's app name is explicitly supported by both ad
  platforms).
- Riskier for the **organic iOS keyword field or app description** —
  Apple's App Store Review Guidelines (§4.1) prohibit copying another
  app's name/trademark in ways that could confuse or mislead, and some
  submissions using competitor names in metadata get rejected even
  though the keyword field itself isn't publicly visible. If adding any
  of these to the organic keyword field, treat it as a "try it, watch
  for a rejection" experiment, not a guaranteed-safe tactic like the
  medication brand names above.
- Never use a competitor name in a way that implies comparison,
  endorsement, or "better than X" — factual-only, same bar as the
  medication trademarks.
