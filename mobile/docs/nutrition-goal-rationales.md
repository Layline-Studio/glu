# Nutrition Goal Rationales

This document captures reasonable default formulas for the new weekly `Proteins` and `Fibers` goals.

## Current default selected for the app

### Protein
- Formula: `0.8 g/kg/day * current body weight in kg * 7`
- Product use: baseline weekly protein goal for healthy adults
- Why:
  - This is the standard adult protein RDA baseline from the National Academies / NIH DRI materials.
  - It is conservative, familiar, and easy to explain.

### Fiber
- Formula: age/sex-based daily recommendation `* 7`
- Product use: baseline weekly fiber goal
- Daily values currently used:
  - Male 14–50: `38 g/day`
  - Male 51+: `30 g/day`
  - Female 14–18: `26 g/day`
  - Female 19–50: `25 g/day`
  - Female 51+: `21 g/day`
  - Fallback when age/sex is unavailable: `25 g/day`
- Why:
  - These are the National Academies / NIH DRI fiber values and are straightforward to convert into weekly targets.

## Other rationale options worth considering later

### Higher-protein weight-management default
- Possible formula: `1.0–1.2 g/kg/day * body weight * 7`
- Why consider it:
  - This may be more aligned with active weight loss or muscle-preservation goals.
- Why not using it as the initial default:
  - It is more opinionated and less universal than the baseline DRI approach.
  - It is harder to defend as a simple default for all users.

### Ideal-body-weight or adjusted-body-weight protein target
- Possible formula:
  - `0.8 g/kg/day` or `1.0–1.2 g/kg/day` based on ideal or adjusted body weight
- Why consider it:
  - Can avoid over-inflating targets for users with high body weight.
- Why not using it initially:
  - Requires more assumptions and more product explanation.
  - Harder to keep transparent in the UI.

## Source notes

### NIH Office of Dietary Supplements
- NIH explains that DRI values are the standard reference values used to plan and assess nutrient intakes for healthy people.
- Link: https://ods.od.nih.gov/HealthInformation/nutrientrecommendations/

### National Academies DRI summary tables
- Protein for adults is based on `0.8 g/kg body weight/day`.
- Fiber daily values include:
  - men 19–50: `38 g/day`
  - women 19–50: `25 g/day`
  - men 51+: `30 g/day`
  - women 51+: `21 g/day`
- Link: https://www.nationalacademies.org/cdn/materials/9fb9fae6-337c-4b7c-9821-2c81d1f65ad0

### National Academies summary article
- Reinforces:
  - fiber recommendations were set from chronic disease risk evidence
  - adult protein recommendation remains `0.8 g/kg/day`
- Link: https://www.nationalacademies.org/news/report-offers-new-eating-and-physical-activity-targets-to-reduce-chronic-disease-risk

## Product recommendation

Use the DRI-based defaults for v1:
- Protein: `0.8 g/kg/day`
- Fiber: age/sex-based DRI values

Reasons:
- official
- easy to explain
- easy to compute from current profile data
- low-risk default while still allowing manual override
