# Design Tokens — Joblinfo

This document captures every design decision codified as tokens in `lib/theme/app_theme.dart`.

## Colour palette

| Token | Hex | Usage |
|---|---|---|
| `kColorPrimary` | `#2E7D5B` | CTAs, match %, streak banner, badges |
| `kColorAccent` | `#FFB020` | Highlights, weekly recap border, saved icon |
| `kColorTextPrimary` | `#1A1A1A` | Body copy, headings |
| `kColorTextSecondary` | `#6B6B6B` | Meta text (company, location, salary) |
| `kColorRejectionNeutral` | `#8A8A8A` | Rejection status only — never red |
| `kColorSurface` | `#F7F9F8` | Scaffold background |
| `kColorCardBg` | `#FFFFFF` | Card backgrounds |

### Colour rationale
- **Green primary** signals progress and growth — not financial (blue) or urgency (red).
- **Rejection neutral** is deliberately mid-gray, not red, to remove the emotional sting of rejection states.
- **Accent amber** celebrates effort milestones without alarming the user.

## Spacing scale

| Token | Value | Usage |
|---|---|---|
| `kSpace4` | 4 px | Tight gaps (icon–label, chip padding) |
| `kSpace8` | 8 px | Element separation within a card |
| `kSpace12` | 12 px | Internal card padding, list gap |
| `kSpace16` | 16 px | Standard horizontal screen padding |
| `kSpace24` | 24 px | Section separation |
| `kSpace32` | 32 px | Large top/bottom padding |

## Corner radius

| Token | Value | Usage |
|---|---|---|
| `kRadiusCard` | 12 px | Cards, containers |
| `kRadiusButton` | 8 px | Buttons |

## Type scale

| Token | Size | Usage |
|---|---|---|
| `kFontCaption` | 12 sp | Labels, chips, meta |
| `kFontBody` | 14 sp | Default body text |
| `kFontSubtitle` | 16 sp | Card titles, section sub-headers |
| `kFontTitle` | 20 sp | Screen titles, section headings |
| `kFontHeading` | 24 sp | Page headings, match % hero |

## Component guidelines

### JobCard
- Match % badge: `kColorPrimary` background at 10 % opacity, `kColorPrimary` text — hero element, always first
- Salary fallback: display "Salary not listed" (never blank)
- Apply button: full-width, `ElevatedButton` with `kColorPrimary`

### Rejection states
- Status label: `kColorRejectionNeutral` — no red anywhere
- Recovery screen: warm gray `EmpathyMessage` container, never a dead end

### Celebration screen
- Background: solid `kColorPrimary`; text: white — high contrast, joyful moment
- Resilience variant: 🔥 emoji; standard variant: 🎉 emoji
