# Medication Dose Reference

Last updated: 2026-04-06

This file is a product/reference document for the medication names currently listed in Glu.

It is not medical advice. It is a quick reference for common marketed dose strengths and usual dosing cadence, based on official manufacturer or prescribing-information sources where available.

## Notes

- `Tirzepatide` and `Semaglutide` are ambiguous app labels. In practice, users usually mean a branded product with a specific dosing schedule.
- `Victoza ®` is now corrected in the app list. Older notes may still mention the previous typo `Victorza ®`.
- `Retatrutide` is still investigational. There is no standard marketed US dose to show users as an approved regimen.
- Glu now supports medication-specific dose lists instead of one shared global dose list.
- Glu now supports a custom dose path for every medication, including custom typed medication names.

## Summary Table

| App label | Common doses | Usual cadence | Status / notes |
| --- | --- | --- | --- |
| Zepbound ® | 2.5, 5, 7.5, 10, 12.5, 15 mg | Weekly injection | 2.5 mg is the starting dose; common maintenance doses are 5, 10, or 15 mg for weight reduction |
| Mounjaro ® | 2.5, 5, 7.5, 10, 12.5, 15 mg | Weekly injection | Start 2.5 mg for 4 weeks, then 5 mg; max adult dose 15 mg |
| Tirzepatide | Usually same strengths as Zepbound/Mounjaro: 2.5, 5, 7.5, 10, 12.5, 15 mg | Weekly injection | Inference: generic app label; better modeled as Zepbound or Mounjaro |
| Wegovy ® | 0.25, 0.5, 1, 1.7, 2.4 mg injection; 1.5, 4, 9, 25 mg tablets | Weekly injection or daily tablet | Injection maintenance commonly 1.7 or 2.4 mg; tablets escalate to 25 mg daily |
| Semaglutide | Common branded injection strengths: 0.25, 0.5, 1, 1.7, 2, 2.4 mg | Weekly injection | Ambiguous app label; better split into Wegovy or Ozempic |
| Ozempic ® | 0.25, 0.5, 1, 2 mg | Weekly injection | 0.25 mg is a starting dose, not a maintenance dose |
| Retatrutide | Investigational trial targets: 4, 9, 12 mg after step-up from 2 mg | Weekly injection | Not FDA-approved / no standard marketed dose |
| Saxenda ® | 0.6, 1.2, 1.8, 2.4, 3.0 mg | Daily injection | Escalates weekly to 3 mg daily |
| Victoza ® | 0.6, 1.2, 1.8 mg | Daily injection | App label is now corrected to `Victoza ®` |
| Trulicity ® | 0.75, 1.5, 3, 4.5 mg | Weekly injection | Common adult start is 0.75 mg weekly |
| Semaglutide Pill | 3, 7, 14 mg | Daily tablet | Most likely maps to Rybelsus |
| Wegovy ® Pill | 1.5, 4, 9, 25 mg | Daily tablet | As of 2026, official Wegovy tablet strengths are in the PI |
| Rybelsus ® | 3, 7, 14 mg | Daily tablet | 3 mg is the starting dose; 7 mg and 14 mg are the therapeutic tablet strengths |

## Detail

### Zepbound ®

- Doses: 2.5, 5, 7.5, 10, 12.5, 15 mg
- Cadence: once weekly injection
- Common use pattern:
  - start at 2.5 mg
  - increase in 2.5 mg steps after at least 4 weeks on the current dose
  - common maintenance doses for weight reduction: 5, 10, or 15 mg
- Important note:
  - 2.5 mg is a starting dose and is not an approved maintenance dose

Source:
- https://zepbound.lilly.com/weight/how-to-use
- https://zepbound.lilly.com/hcp/dosage

### Mounjaro ®

- Doses: 2.5, 5, 7.5, 10, 12.5, 15 mg
- Cadence: once weekly injection
- Common use pattern:
  - start at 2.5 mg for 4 weeks
  - then move to 5 mg
  - can be increased further depending on treatment goals
  - max adult dose: 15 mg weekly

Source:
- https://mounjaro.lilly.com/how-to-use-mounjaro
- https://mounjaro.lilly.com/faq

### Tirzepatide

- App label is ambiguous
- In the US, users usually mean either:
  - Mounjaro ®
  - Zepbound ®
- Common marketed strengths align with those products:
  - 2.5, 5, 7.5, 10, 12.5, 15 mg weekly

Inference:
- This is an inference from the official branded tirzepatide products above, not a separate branded dose schedule.

### Wegovy ®

- Injection strengths:
  - 0.25, 0.5, 1, 1.7, 2.4 mg
- Injection cadence:
  - once weekly
- Common injection pattern:
  - step up every 4 weeks
  - maintenance usually 1.7 mg or 2.4 mg
- Tablet strengths in the current PI:
  - 1.5, 4, 9, 25 mg
- Tablet cadence:
  - once daily
- Common tablet pattern in the current PI:
  - days 1-30: 1.5 mg
  - days 31-60: 4 mg
  - days 61-90: 9 mg
  - day 91 onward: 25 mg

Source:
- https://www.wegovy.com/obesity/starting-wegovy/starting-wegovy-pen.html
- https://www.novo-pi.com/wegovy.pdf

### Semaglutide

- App label is ambiguous
- In practice this may refer to:
  - Wegovy ® injection
  - Ozempic ® injection
  - oral semaglutide products such as Rybelsus ®
- Common official branded semaglutide dose strengths currently used in the US include:
  - injection: 0.25, 0.5, 1, 1.7, 2, 2.4 mg
  - oral: 3, 7, 14 mg

Product recommendation:
- Better to avoid `Semaglutide` as a standalone medication option and instead route users to the branded product/formulation that matches what they actually take.

Source:
- https://www.wegovy.com/obesity/starting-wegovy/starting-wegovy-pen.html
- https://www.novomedlink.com/diabetes/products/treatments/ozempic/dosing-administration/dosing-and-prescribing.html
- https://www.novomedlink.com/diabetes/products/treatments/rybelsus/dosing-administration/dosing-and-prescribing.html

### Ozempic ®

- Doses: 0.25, 0.5, 1, 2 mg
- Cadence: once weekly injection
- Common use pattern:
  - start at 0.25 mg weekly
  - then move to 0.5 mg
  - may increase to 1 mg or 2 mg based on treatment needs
- Important note:
  - 0.25 mg is a starting dose and not a therapeutic maintenance dose

Source:
- https://www.ozempic.com/how-to-take/ozempic-dosing.html
- https://www.novomedlink.com/diabetes/products/treatments/ozempic/dosing-administration/dosing-and-prescribing.html

### Retatrutide

- Status: investigational, not FDA-approved
- Current official Lilly Phase 3 press release describes a step-up approach:
  - initiate at 2 mg weekly
  - step up toward target doses of 4 mg, 9 mg, or 12 mg
- There is no standard marketed dose schedule to present as an approved regimen

Source:
- https://investor.lilly.com/news-releases/news-release-details/lillys-triple-agonist-retatrutide-demonstrated-significant

### Saxenda ®

- Doses: 0.6, 1.2, 1.8, 2.4, 3.0 mg
- Cadence: once daily injection
- Common use pattern:
  - increase weekly from 0.6 mg to 3 mg
  - target maintenance is usually 3 mg daily

Source:
- https://www.saxenda.com/about-saxenda/dosing-schedule.html

### Victoza ®

- Doses: 0.6, 1.2, 1.8 mg
- Cadence: once daily injection
- Important note:
  - the app label is now corrected to `Victoza ®`

Source:
- https://www.victoza.com/faq/Using-the-Victoza-Pen.html
- https://www.novomedlink.com/diabetes/products/treatments/victoza/dosing-administration.html

### Trulicity ®

- Doses: 0.75, 1.5, 3, 4.5 mg
- Cadence: once weekly injection
- Common use pattern:
  - common adult start is 0.75 mg weekly
  - step-up data and higher strengths are available in official Lilly materials

Source:
- https://trulicity.lilly.com/how-to-use
- https://trulicity.lilly.com/hcp/efficacy-weight/weight-loss-dosing

### Semaglutide Pill

- Most likely this should map to Rybelsus ®
- Doses: 3, 7, 14 mg
- Cadence: once daily tablet
- Common use pattern:
  - start at 3 mg daily for 30 days
  - then 7 mg daily
  - may increase to 14 mg daily

Source:
- https://www.rybelsus.com/taking-rybelsus/what-to-expect-with-rybelsus.html
- https://www.novomedlink.com/diabetes/products/treatments/rybelsus/dosing-administration/dosing-and-prescribing.html

### Wegovy ® Pill

- As of 2026-04-06, official Wegovy tablet information is live on the manufacturer site and current PI
- Tablet strengths in the PI:
  - 1.5, 4, 9, 25 mg
- Cadence: once daily tablet
- Common use pattern in the current PI:
  - days 1-30: 1.5 mg
  - days 31-60: 4 mg
  - days 61-90: 9 mg
  - day 91 onward: 25 mg

Source:
- https://www.wegovy.com/obesity/starting-wegovy/starting-wegovy-pill.html
- https://www.wegovy.com/obesity/starting-wegovy/faq.html
- https://www.novo-pi.com/wegovy.pdf

### Rybelsus ®

- Doses: 3, 7, 14 mg
- Cadence: once daily tablet
- Common use pattern:
  - 3 mg daily for 30 days to start
  - then 7 mg daily
  - may increase to 14 mg daily
- Important note:
  - 3 mg is the starting dose and is not intended for glycemic control

Source:
- https://www.rybelsus.com/taking-rybelsus/what-to-expect-with-rybelsus.html
- https://www.novomedlink.com/diabetes/products/treatments/rybelsus/dosing-administration/dosing-and-prescribing.html

## Product Implications For Glu

Based on the current list in `lib/models/medication_catalog.dart`, the biggest original dosing-model gaps have already been patched.

## Already patched in Glu

1. Medication-specific dose options replaced the old shared dose list
   - This now covers:
   - Wegovy injection doses
   - Ozempic doses
   - Saxenda / Victoza doses
   - Rybelsus doses
   - Wegovy tablet doses
   - Tirzepatide-family doses
2. `Victoza ®` has been corrected in the app catalog
3. Custom dose entry is now supported across onboarding and reminder/logging flows
   - This is implemented as a controlled custom-dose path, not free-form mg text
4. Custom medication names are supported through the inline `Other` option

## Still not patched

1. `Semaglutide` and `Tirzepatide` remain ambiguous user-facing labels
   - They still map to inferred branded dose ranges rather than a specific product/formulation selection
2. `Retatrutide` remains user-facing even though it is investigational
   - The app currently includes inferred trial-style dose values
   - It is not specially flagged in the user experience as investigational
3. The app still models dose as `mg` only
   - This is consistent internally, but still a simplification of real prescribing context

Recommended next product direction:

- Keep route-aware medication lists:
  - injection
  - pill
- Replace ambiguous generics with specific marketed products where possible
- Decide whether investigational products should appear at all in user-facing onboarding
- Decide whether `Retatrutide` should be:
  - removed
  - hidden behind internal/testing flags
  - or explicitly labeled as investigational
