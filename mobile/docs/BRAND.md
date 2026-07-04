# Brand

## Positioning

Glu is a premium, friendly wellness companion.

It should feel:

- Calm, clear, and reassuring
- Modern and polished without feeling clinical
- Lifestyle-driven, not medical or sports-performance driven
- Helpful and intelligent without becoming cold or technical

The product should read as a health and wellness app first, with nutrition and meals as a core part of the experience rather than the entire identity.

## Tone

The brand voice and interface tone should be:

- Warm
- Clear
- Encouraging
- Refined
- Lightweight

Avoid:

- Aggressive fitness language
- Gamified hype
- Medical or sterile presentation
- Dense dashboards that feel like admin software

## Visual Direction

The visual direction should stay close to the references in `docs/refs`.

Color reference:

- The attached insulin-pen illustration is the palette anchor for the app's theme

Primary reference:

- `dashboard.png` for overall mood, softness, and premium mobile composition

Supporting references:

- `daily meals history.png` for information architecture and content structure
- `original-c5fbbf97bbbd00dc1036e907ab01a2b8.webp` for premium finish, ambient gradients, and soft glass treatment

The core concept is:

- Light-only interface
- Premium and friendly
- iOS-native feeling
- Soft, spacious, rounded, and calm
- Wellness-first rather than calorie-tracker-first

## Visual System

### Overall Look

The UI should feel airy and tactile.

Use:

- Soft icy-blue backgrounds instead of harsh pure white everywhere
- Rounded cards as the main layout building block
- Subtle shadows and layered surfaces
- Gentle aqua, sky, and periwinkle accents for health, meals, and status
- Ambient gradients and occasional frosted/glassy moments for premium screens

Avoid:

- Heavy borders
- Dark themes
- Sharp corners
- Overly saturated colors
- High-density tables or analytics-heavy layouts

### Color Palette

Base neutrals:

- Background: pale icy blue
- Surface: soft white
- Elevated surface: white with a cool airy tint
- Primary text: deep blue-navy
- Secondary text: muted blue-gray
- Divider/border: extremely light gray, used sparingly

Recommended palette direction:

- `bg-canvas`: `#EEF8FB`
- `bg-surface`: `#FFFFFF`
- `bg-soft`: `#E7F5FB`
- `text-primary`: `#14314C`
- `text-secondary`: `#6A88A3`
- `line-subtle`: `#D6E8F4`

Accent family:

- Aqua for freshness, wellness, and primary emotional tone
- Periwinkle blue for depth, trust, and secondary emphasis
- Sky blue for light utility surfaces and hydration-adjacent moments
- Blush pink for warmth and friendliness
- Ice cyan for supportive fills and quiet backgrounds

Suggested accent tokens:

- `accent-mint`: `#8DECF1`
- `accent-lilac`: `#9FC0FF`
- `accent-peach`: `#FFD2E1`
- `accent-sky`: `#B7E4FF`
- `accent-butter`: `#DDF8FF`

Functional nutrition accents:

- Protein: bright aqua-blue
- Carbs: cool periwinkle
- Fat: soft teal

These should remain soft and elegant rather than neon.

### Gradients and Atmosphere

Gradients should be blurred, pale, and atmospheric.

Use them:

- In hero areas
- Behind featured wellness content
- Inside premium cards
- Behind glass overlays

Gradient direction should favor:

- Ice blue to aqua
- Sky to periwinkle
- Pale cyan to soft white

They should never overpower the content.

### Typography

Typography should be bold, clean, and premium, with a friendly tone.

Use:

- Large, confident section titles
- Bold numeric metrics
- Clean small labels with generous spacing

Desired traits:

- Rounded or humanist sans feel
- Strong legibility
- Not overly geometric
- Not too corporate

Recommended type system:

- Primary UI font: `Plus Jakarta Sans`
- Fallback option: `DM Sans`

Why `Plus Jakarta Sans`:

- It feels modern and premium without becoming cold
- It stays friendly at small sizes
- It supports strong metric numerals and bold section headings
- It is closer to the soft consumer-product feel of the references than a more neutral system font

Use guidance:

- Headlines: `Plus Jakarta Sans` bold or extra bold
- Section titles: `Plus Jakarta Sans` semi bold or bold
- Body copy: `Plus Jakarta Sans` regular or medium
- Metrics and key numbers: `Plus Jakarta Sans` bold

Do not mix multiple expressive fonts in the product UI unless there is a very deliberate brand reason.

Stylistic guidance:

- Headlines: bold and compact
- Section labels: medium weight
- Secondary descriptions: light visual weight
- Metric numbers: strong, oversized, and visually calm

Typography should support a premium consumer product, not a healthcare portal.

### Layout Principles

The app should be mobile-first and strongly inspired by native iPhone product design.

Use:

- Generous outer padding
- Clear vertical rhythm
- Search and segmented controls near the top
- Bottom tab navigation
- Large card stacks for core content

Hierarchy should feel effortless:

- Search or top controls first
- Primary wellness summary second
- Daily content sections after that
- Actions embedded naturally into cards and tabs

### Card Language

Cards are the core visual container.

Card rules:

- Large radius
- Soft shadow or very subtle lift
- Minimal or no visible border
- Strong padding
- Clear title + supporting data + concise action

Card types to standardize:

- Summary cards
- Metric tiles
- Meal cards
- Wellness insight cards
- Progress cards

Some cards can use pastel fills, but the app should still feel mostly bright and clean rather than candy-colored.

### Component Styling

Buttons:

- Primary buttons should be dark, simple, and calm when used in focused actions
- Secondary actions should use pill shapes, soft fills, or ghost styling

Tabs and segmented controls:

- Rounded pill treatment
- Active state should feel soft and elevated, not harshly outlined

Search:

- Prominent but quiet
- Pale background with subtle iconography

Chips:

- Rounded, compact, lightly tinted
- Used for macros, tags, and lightweight filters

Charts and data visuals:

- Simplified
- Softly colored
- Immediately readable
- Decorative enough to feel premium, but never confusing

### Iconography

Icons should be simple, rounded, and lightweight.

Prefer:

- Soft stroke icons
- Friendly proportions
- Minimal visual noise

Avoid:

- Sharp, technical icon sets
- Aggressive filled icons used everywhere

### Imagery

Imagery should support the wellness identity.

Use:

- Soft food photography
- Clean lifestyle visuals
- Ambient gradient art
- Occasional blurred or frosted image-backed panels

Imagery should feel curated and premium, not stock-heavy or noisy.

### Motion

Motion should be subtle and meaningful.

Use:

- Gentle page reveals
- Soft fade and slide transitions
- Calm emphasis on card appearance
- Smooth state changes for tabs, chips, and progress visuals

Avoid:

- Bouncy, playful app-store style gimmicks
- Over-animated dashboards
- Motion that competes with content

## Screen Composition Guidance

The home and dashboard surfaces should follow this model:

- Search and quick utilities at the top
- Primary wellness snapshot near the top of the screen
- Daily meals or daily plan sections below
- Lightweight metrics in pastel tiles
- Bottom navigation always present and visually calm

The screen should feel like a guided wellness dashboard, not a spreadsheet of health data.

## What To Preserve From The References

- The softness and openness from `dashboard.png`
- The content structure from `daily meals history.png`
- The premium ambient finish from `original-c5fbbf97bbbd00dc1036e907ab01a2b8.webp`

## What To Avoid

- Dark or moody UI
- Clinical hospital aesthetics
- Hardcore fitness visuals
- Generic SaaS dashboard patterns
- Visual clutter
- High-contrast neon accents
