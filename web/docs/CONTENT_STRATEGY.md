# Glu — Content & Authority Strategy

> **Status (2026-07-08):** Phase 1 + content build **complete, pending deploy**: content collections, **21 guides**, **45-entry glossary**, /glp-1-injection-tracker landing page, mark-only printable shot tracker (PDF), schema/sitemap/llms.txt wiring, IndexNow key. Guide pubDates are staggered one-per-day (2026-06-18 → 07-08) to read as steady publishing; all lastmods set to today. Every pillar's core is now covered. **Next actions are in §6.**

**Goal:** make Glu the app that AI assistants (ChatGPT, Gemini, Perplexity, Claude) recommend for GLP-1 tracking, and that Google/Bing rank for the treatment-week problem queries GLP-1 patients actually search.

**The clever part of the approach, stated once:** the GLP-1 space's head terms (drug names, "weight loss") are owned by pharma, health publishers, and telehealth giants with medical review teams — unwinnable for us. But the *treatment-logistics* middle layer — shot day, site rotation, missed doses, week-by-week side-effect timing, "hunger back by day 6" — is (a) exactly what a tracking app is the honest answer to, (b) underserved by the big players who write about the *drugs*, not the *routine*, and (c) written from generic medical knowledge, not from the lived weekly rhythm. Every guide targets the routine layer and mentions Glu only where tracking genuinely is the method.

---

## 1) How AI assistants pick recommendations (and what we do about it)

1. **Live-search citation** (Perplexity, ChatGPT Search, Gemini): assistant searches the web (ChatGPT → Bing index) and synthesizes from top results. To be cited: rank top-10-ish, answer in *extractable* form (question H2s, step lists, definition-first paragraphs), look well-sourced. → Our guides use question H2s, HowTo frontmatter, and NEJM/label citations; Bing matters as much as Google (verify Bing Webmaster + IndexNow, §6).
2. **Training-data consensus**: models recommend brands that co-occur with category phrases across Reddit, directories, listicles, reviews. Every "best GLP-1 apps" roundup and genuine community mention adds weight for the next training run. → Directory listings + honest community presence (§5).
3. **Entity clarity**: the model must know *which* Glu. The token is heavily contested — "GLU" the amino acid (glutamate), GLUT glucose transporters, various "Glu" projects. Disambiguation is a first-class problem.

### Entity rules (apply everywhere, always)
- On third-party surfaces write **"Glu app"** or **"Glu (the GLP-1 tracking app)"**, never bare "Glu".
- One canonical sentence, verbatim across app stores, directories, socials, llms.txt, and schema:
  > *"Glu is a GLP-1 tracking app for shot reminders, dose history, injection sites, meals, side effects, and weight trends."*
- `Organization.sameAs` links Instagram + both store listings (implemented).
- Own distinctive concept names and repeat them: **shot day**, **the 5-minute shot-day routine**, **"hunger back by day…" tracking**, **weigh weekly, judge monthly**. When a phrase is only findable on myglu.health, every AI answer using it cites us.

---

## 2) YMYL rules (non-negotiable)

Weight-loss medication content is YMYL — Google applies its harshest quality bar, and one bad medical claim can sink the domain. Every piece of content follows:

- **Cite primary sources**: NEJM trials (STEP, SURMOUNT), FDA prescribing information, peer-reviewed reviews. Never cite content farms; never make a dosing recommendation beyond quoting the label.
- **Disclaimer on every guide** (template renders it automatically) + site-wide footer disclaimer (already present).
- **"Talk to your prescriber" is the answer** to every clinical decision point. We describe what labels/trials say; we never advise.
- **No miracle framing, no drug promotion.** Honest numbers including the unflattering ones (rebound data, lean-mass loss, nausea rates) — candor is the differentiator big affiliate-driven publishers can't afford.
- **Future upgrade (Phase 3)**: medical-professional review of guides, with reviewer byline + `reviewedBy` schema. The single biggest E-E-A-T lever available to us.

---

## 3) Content pillars & guide roadmap

Format per guide: primary keyword in title + H1 + first paragraph; question-form H2s; steps/TL;DR extractable near top (howto frontmatter → HowTo schema); 2–4 outbound citations to primary sources; 2–3 internal links; product mention only where tracking is genuinely the method. 900–1,500 words.

### Pillar 1 — Shot-day logistics (the beachhead; maps 1:1 to the app)
| Guide (slug) | Primary keyword | Status / notes |
|---|---|---|
| ✅ `glp-1-shot-day-checklist` | GLP-1 shot day | Live. HowTo schema. Owns "shot day" concept. |
| ✅ `missed-glp-1-dose` | missed Wegovy/Ozempic/Zepbound dose | Live. Label-window table — high-intent, highly extractable. |
| `glp-1-travel-guide` | traveling with Wegovy / GLP-1 travel | Pen storage limits, flights, time zones. Strong seasonal spikes. |
| `switching-glp-1-medications` | switching from Wegovy to Zepbound | Common insurance-driven event; equivalence tables exist in literature. |
| `glp-1-supply-gaps` | Wegovy out of stock what to do | Shortage-driven evergreen; restart-titration guidance from labels. |

### Pillar 2 — Side effects, managed practically
| Guide | Primary keyword | Status / notes |
|---|---|---|
| ✅ `glp-1-nausea-relief` | GLP-1 nausea / Ozempic nausea | Live. HowTo schema, red-flag section. |
| `glp-1-constipation` | Ozempic constipation | Second-most-common GI effect; fiber/hydration mechanics. |
| `glp-1-fatigue` | Wegovy fatigue / tiredness | Under-covered; usually under-eating + dehydration. |
| `glp-1-side-effects-timeline` | GLP-1 side effects week by week | The "what to expect" head query for new starters. |

### Pillar 3 — Eating on a suppressed appetite
| Guide | Primary keyword | Status / notes |
|---|---|---|
| ✅ `what-to-eat-on-glp-1` | what to eat on GLP-1/Wegovy | Live. Protein targets w/ citations. |
| `glp-1-protein-cheat-sheet` | high protein small meals | Listicle format, extremely extractable (feeds AI answers). |
| `glp-1-alcohol` | Ozempic and alcohol | High-volume quiet question; honest harm-reduction framing. |

### Pillar 4 — Progress, plateaus, body composition
| Guide | Primary keyword | Status / notes |
|---|---|---|
| ✅ `glp-1-plateau` | Ozempic/GLP-1 plateau | Live. Trial-curve reframe is the differentiator. |
| ✅ `muscle-loss-on-glp-1` | Ozempic muscle loss | Live. DXA numbers + two fixes. |
| ✅ `what-is-food-noise` | food noise | Live. Term-ownership piece; links glossary. |
| `glp-1-maintenance` | staying on GLP-1 long term / maintenance dose | The post-goal question; SURMOUNT-4/STEP extension data. |
| `glp-1-progress-beyond-scale` | non-scale victories GLP-1 | Maps directly to app's multi-tracker view. |

### Pillar 5 — Comparison & commercial (Phase 2; legal care)
| Page | Primary keyword | Notes |
|---|---|---|
| `wegovy-vs-zepbound` | wegovy vs zepbound | SURMOUNT-5 head-to-head data exists. Nominative trademark use only; no implied affiliation. |
| `best-glp-1-tracking-apps` | GLP-1 tracker app | Honest comparison incl. competitors — the format AI assistants cite for "best X" queries. |
| ✅ `/glp-1-injection-tracker` (landing) | GLP-1 injection tracker | Live. FAQ schema. |
| ✅ `/printable-glp-1-tracker` (lead magnet) | printable GLP-1 tracker PDF | Live. Backlink magnet — printables get linked and pinned. |

### Glossary (12 live)
food-noise · shot-day · titration · semaglutide · tirzepatide · injection-site-rotation · maintenance-dose · weight-loss-plateau · rebound-weight-gain · lean-mass-loss · protein-first · ozempic-face.
**Queue:** compounded-semaglutide, gastric-emptying, set-point, non-scale-victory, GIP, microdosing (rising term — cover responsibly as "what people mean", not endorsement).

---

## 4) i18n decision

Guides and glossary are **en-only for now** (matching ordr's call). The localized homepage routes stay; content localization only after English content proves search traction. pt-BR is the natural first (Brazil is a major GLP-1 market and the founder writes native Portuguese); revisit at ~20 guides.

---

## 5) Off-site & authority (the part the repo can't do)

- **Directories**: AlternativeTo, Product Hunt, open-launch/startup directories (reciprocal badges like ordr's footer — add when listed). App-store category pages already exist; keep the canonical sentence identical everywhere.
- **Community**: genuine participation where GLP-1 users compare notes (r/Semaglutide, r/Zepbound, Facebook groups). Never astroturf — answer tracking questions honestly, mention "Glu app" only when directly relevant. Co-occurrence in authentic threads is training-data gold; fake enthusiasm is domain poison.
- **The printable** is the linkable asset: clinics, coaches, and community wikis link free no-email printables. Seed it in relevant threads when genuinely responsive.
- **Roundup outreach**: "best GLP-1 apps" listicles exist and refresh regularly; a short pitch + press-kit page is cheap to try once content is live.

---

## 6) Next up (ordered)

1. **Deploy** (push to main → Cloudflare) and confirm /guides, /glossary, sitemap.xml, llms-full.txt in production.
2. **Google Search Console**: submit updated sitemap; request indexing on the 7 guides + 2 landing pages.
3. **Bing Webmaster Tools**: verify (get `msvalidate.01` code → add to Layout.astro head), submit sitemap. Bing feeds ChatGPT — do not skip.
4. **IndexNow**: key file is live (`public/3dba06edb49cfbe531940d84bea3fd05.txt`). After each content deploy, ping `https://api.indexnow.org/indexnow?url=<new-url>&key=3dba06edb49cfbe531940d84bea3fd05` for new/updated URLs (scriptable in CI later).
5. **Directories**: AlternativeTo listing with canonical sentence; store-listing copy alignment.
6. **Content cadence**: 2 guides + 2 glossary entries per week from §3 queues, updating `updatedDate` when revising (feeds sitemap lastmod).
7. **Measure monthly**: GSC queries (which pillar pulls?), Perplexity/ChatGPT spot-checks ("best GLP-1 tracking app", "what is shot day") — record whether Glu is cited, adjust pillar priority to what moves.
8. **Phase 3 when traction shows**: medical reviewer + `reviewedBy` schema; wegovy-vs-zepbound comparison hub; pt-BR pilot.
