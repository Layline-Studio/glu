# UI System

## Purpose

This document converts the brand direction in `docs/BRAND.md` into a practical interface system for the Glu mobile app.

Use this file to guide:

- Product UI implementation
- New screen design
- Component styling
- Design token definitions
- Visual consistency decisions

This system is intentionally:

- Light-only
- Mobile-first
- Premium and friendly
- Close to the reference set in `docs/refs`
- Anchored to the cool aqua/periwinkle palette from the insulin-pen illustration reference

## Reference Priority

Primary reference:

- `docs/refs/dashboard.png`

Secondary references:

- `docs/refs/daily meals history.png`
- `docs/refs/original-c5fbbf97bbbd00dc1036e907ab01a2b8.webp`

Use them this way:

- `dashboard.png` defines overall mood, spacing, softness, and dashboard hierarchy
- `daily meals history.png` defines the app shell and meal-oriented information architecture
- `original...webp` defines the premium finish, atmospheric gradients, and glass-inspired softness

## Design Principles

- Calm over energetic
- Friendly over clinical
- Premium over flashy
- Spacious over dense
- Guided over technical
- Lifestyle wellness over hardcore fitness

Every screen should answer:

- Is the hierarchy immediately clear?
- Does this feel lightweight and reassuring?
- Does the screen breathe?
- Is the data approachable rather than intimidating?

## Core Tokens

### Color Tokens

Base:

- `canvas`: `#EEF8FB`
- `surface`: `#FFFFFF`
- `surface-soft`: `#E7F5FB`
- `surface-elevated`: `#F8FDFF`
- `text-primary`: `#14314C`
- `text-secondary`: `#6A88A3`
- `line-subtle`: `#D6E8F4`

Accent:

- `mint`: `#8DECF1`
- `lilac`: `#9FC0FF`
- `peach`: `#FFD2E1`
- `sky`: `#B7E4FF`
- `butter`: `#DDF8FF`

Functional:

- `protein`: `#6FD8F0`
- `carbs`: `#86A9FF`
- `fat`: `#67D7D1`
- `error-soft`: `#B94C4C`

Usage rules:

- Use neutrals for most of the interface
- Use accents to organize content, not to flood the screen
- Keep high-saturation color use extremely limited
- Do not place strong accent colors behind long text blocks
- Favor cool tonal harmony across the whole app; warm tones should be rare accents only

### Gradient Tokens

Use named gradients rather than inventing new ones screen by screen.

- `hero-dawn`: `#D6F5FB -> #79AEF8`
- `wellness-blush`: `#EDF8FF -> #CFE0FF`
- `fresh-air`: `#F5FDFF -> #D8F3FF`
- `soft-citrus`: `#F4FCFF -> #E5F4FF`

Rules:

- Gradients should stay pale and blurred in feel
- They should support atmosphere, not become illustrations
- Use gradients mainly in hero cards, featured modules, and premium moments
- Do not use loud multi-color gradients in utility-heavy sections

### Typography Tokens

Primary typeface:

- `Plus Jakarta Sans`

Fallback:

- `DM Sans`

Type scale:

- `display-lg`: 40 / 46, weight 800
- `display-md`: 32 / 38, weight 800
- `display-sm`: 28 / 34, weight 800
- `headline-lg`: 24 / 30, weight 700
- `headline-md`: 20 / 26, weight 700
- `title-lg`: 18 / 24, weight 700
- `title-md`: 16 / 22, weight 700
- `body-lg`: 16 / 22, weight 500
- `body-md`: 14 / 20, weight 500
- `body-sm`: 12 / 18, weight 500
- `label-lg`: 14 / 18, weight 600
- `label-md`: 12 / 16, weight 600
- `label-sm`: 11 / 14, weight 600

Usage rules:

- Use display styles sparingly for hero moments and large metrics
- Most screens should rely on `headline`, `title`, and `body`
- Avoid using too many font weights in one card
- Numeric metrics should usually be bold

### Spacing Tokens

Base spacing scale:

- `4`
- `8`
- `12`
- `16`
- `20`
- `24`
- `32`
- `40`

Usage:

- Tight internal chip spacing: `8`
- Standard card internal spacing: `16` or `20`
- Page outer padding: `20` or `24`
- Section separation: `24` or `32`
- Large hero separation: `40`

### Radius Tokens

- `radius-sm`: `12`
- `radius-md`: `16`
- `radius-lg`: `20`
- `radius-xl`: `24`
- `radius-2xl`: `28`
- `radius-pill`: `999`

Usage:

- Inputs and chips: `20` or `pill`
- Standard cards: `24`
- Hero cards: `28`
- Floating action controls: `pill`

### Elevation Tokens

Shadows should be very subtle.

- `shadow-none`: no shadow
- `shadow-soft`: `0 10 30 / low alpha`
- `shadow-card`: `0 18 32 / low alpha`
- `shadow-floating`: `0 12 24 / medium-low alpha`

Rules:

- Prefer separation through color and spacing before shadow
- Cards should feel lifted, not hovering dramatically
- Avoid dark, sharp, desktop-style elevation

## App Shell

### Top Bar

The default top area should allow:

- Avatar or profile entry on the left
- Search near the top
- One or two light utility actions on the right

Visual rules:

- Keep the top shell airy
- Do not use heavy app bars by default
- Prefer integrated header layouts over boxed toolbar patterns

### Search

Search is a core recurring component.

Specs:

- Height: `48` to `52`
- Background: `surface-soft`
- Radius: `20`
- Icon left aligned
- Placeholder text in `text-secondary`
- Border optional and very subtle

It should feel quiet, not like a dominant enterprise search field.

### Segmented Controls

Used below the search or section header for switching views like:

- `Today / Weekly / Monthly`
- `Meals / Activity / Water`

Specs:

- Rounded pill track
- Low-contrast background
- Active state feels softly elevated
- Tight horizontal padding
- Labels should be compact and readable

Avoid:

- Hard outlines
- Underlines
- Sharp rectangular tab bars

### Bottom Navigation

The app shell should use a persistent bottom nav.

Specs:

- 4 to 5 tabs max
- Soft white surface
- Rounded feel
- Selected item in dark text
- Unselected items in muted gray

One center action can be highlighted if needed, but it should still feel premium and calm rather than loud.

## Card System

Cards are the primary organizational structure of the app.

### Summary Card

Purpose:

- Top-level daily wellness snapshot
- Main progress view
- Hero metrics

Traits:

- Largest card on screen
- Can include gradient treatment
- Large metric number or ring/progress visualization
- Secondary supporting values below

### Metric Tile

Purpose:

- Steps
- Sleep
- Water
- Mood
- Recovery

Traits:

- Soft pastel fill allowed
- Large number
- Small supporting descriptor
- One icon max

Metric tiles should feel glanceable in under one second.

### Meal Card

Purpose:

- Breakfast
- Lunch
- Dinner
- Snacks

Traits:

- White or softly tinted card
- Meal title and kcal summary
- Compact add action
- Macro chips below

This should borrow structure directly from `daily meals history.png`.

### Progress Card

Purpose:

- Macro progress
- Weekly consistency
- Hydration streak
- Habit completion

Traits:

- Clean progress visuals
- Minimal labels
- Strong emphasis on readability

### Insight Card

Purpose:

- Recommendations
- Wellness guidance
- Featured educational content

Traits:

- More atmospheric
- Can use gradient or image support
- Short copy only

## Component Specs

### Buttons

Primary button:

- Dark fill
- White text
- Pill shape
- Used for committed actions

Secondary button:

- White or soft surface fill
- Subtle border optional
- Dark text

Tertiary action:

- Text or ghost treatment
- Used sparingly

Rules:

- Prefer one clear primary action per screen or card cluster
- Do not mix many competing button styles in a single module

### Chips

Used for:

- Macro tags
- Filters
- Status labels
- Small content categories

Specs:

- Compact
- Rounded
- Lightly tinted
- Medium label weight

Macro chip mapping:

- Protein -> orange
- Carbs -> violet
- Fat -> green

### Inputs

All text inputs should feel soft and integrated.

Specs:

- Soft filled background
- Large radius
- Minimal border
- Generous left and right padding

Avoid:

- Harsh outlined Material defaults
- Dense compact forms as a default interaction pattern

### Progress Bars

Progress bars should be:

- Rounded
- Thick enough to feel premium
- Light track with a soft accent fill

Text labels should remain simple and close to the bar.

### Charts

Allowed chart styles:

- Ring/gauge summary
- Segmented mini bars
- Simplified weekly stack charts
- Lightweight trend strips

Avoid:

- Dense axis-heavy charts
- Multi-series analytical dashboards
- Technical finance-style chart language

## States

### Default

- Calm
- Bright
- Low contrast except for key text

### Selected

- Slight fill shift or soft elevation
- Not a harsh saturated color flip

### Pressed

- Slight darkening or opacity change
- Optional tiny scale-down on touchable cards

### Disabled

- Lower contrast
- Reduced text emphasis
- Never fully invisible

### Loading

- Skeleton blocks should use soft neutral shimmer
- Loading indicators should be minimal and quiet

### Error

- Use error color sparingly
- Prefer clear text + soft tinted support, not aggressive red panels

### Success

- Prefer mint or gentle green over bright success green

## Motion

Motion should be subtle and deliberate.

Recommended timings:

- Quick tap response: `120ms`
- Micro transition: `180ms`
- Standard content transition: `240ms`
- Hero reveal: `300ms`

Recommended easing:

- Ease-out for entrances
- Soft ease-in-out for state changes

Recommended motion patterns:

- Fade + slight upward movement for cards entering
- Soft crossfade for segmented content changes
- Smooth progress fill animation
- Light scale feedback on primary tap targets

Avoid:

- Springy cartoon motion
- Bouncy tab animations
- Large movement distances

## Iconography

Use one consistent icon family across the app.

Preferred characteristics:

- Rounded stroke icons
- Minimal detail
- Calm visual weight

Rules:

- Most icons should be 18 to 22 px
- Use filled icons only for special emphasis
- Avoid mixing multiple icon styles in one screen

## Imagery

Imagery should be used intentionally, not constantly.

Use food and wellness imagery for:

- Hero moments
- Featured cards
- Meal detail context
- Premium onboarding or empty states

Do not:

- Put large photos in every list
- Use noisy stock photos
- Use imagery that competes with important data

When using image-backed cards:

- Add soft overlays or blur support where needed
- Preserve text readability
- Keep text blocks short

## Canonical Screens

### Home Dashboard

Recommended order:

1. Top utility row
2. Search
3. Segmented control or time scope
4. Primary wellness summary card
5. Metric tile row
6. Daily meals section
7. Additional insights or recommendations

### Daily Meals Screen

Recommended order:

1. Search
2. Segment switch: meals / activity / water
3. Meal list
4. Macro chips per meal
5. Add entry affordances integrated into meal cards

### Analytics Screen

Recommended order:

1. Time-range segment
2. Hero summary visualization
3. Simplified trend modules
4. Supporting wellness metrics

Keep analytics beautiful and lightweight.

## Empty States

Empty states should feel encouraging, not broken.

Use:

- One calm illustration or soft gradient block
- Short supportive copy
- One clear action

Avoid:

- Verbose instructional copy
- Debug-feeling placeholders

## Implementation Guidance

In code, the system should be represented by:

- Theme tokens for color, typography, spacing, and elevation
- Reusable card primitives
- Shared components for search, chips, buttons, tabs, and metric tiles
- Very limited one-off styling in screens

If a new screen needs a new visual pattern, add it to the system rather than improvising it locally.

## Non-Negotiables

- Light-only
- Rounded and spacious
- Calm and premium
- Mobile-native
- Minimal hard borders
- No clinical health-tech styling
- No generic SaaS dashboard feel
- No loud dark accents or neon color behavior
