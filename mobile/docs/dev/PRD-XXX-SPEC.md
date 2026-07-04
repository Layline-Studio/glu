# PRD-XXX: <Feature Name>

## Summary
<1-3 sentences describing what this feature is and why it matters.>

## Context
<Background on current behavior, problems, and constraints.>

## Goals
- <Goal 1>
- <Goal 2>

## Non-Goals
- <Out of scope 1>
- <Out of scope 2>

## User Stories
- As a <user>, I want <capability> so that <benefit>.
- As a <user>, I want <capability> so that <benefit>.

## UX Overview
### Entry Points
- <Where feature is accessed>

### Happy Path
1. <Step>
2. <Step>

### Error States
- <Error case> -> <Expected UX>

## Functional Requirements
- <Requirement 1>
- <Requirement 2>

## Non-Functional Requirements
- Performance: <latency targets, timeouts>
- Reliability: <retry, idempotency>
- Security/Privacy: <token handling, PII, logs>
- Offline: <what works offline>

## Data & State
- <State variables, storage, caching rules>
- <State transitions or flags>

## Data Model Changes
- Tables/fields: <schema updates>
- Constraints/indexes: <new indexes, uniqueness>
- Migrations: <migration file name(s)>

## API Contract
### Endpoint(s)
`METHOD /path`
Request:
```json
{
  "field": "value"
}
```
Response:
```json
{
  "field": "value"
}
```
Errors:
- <code>: <message/meaning>

## Backend Requirements
- RLS/policies: <changes>
- Edge Functions: <new/updated functions>
- Rate limits: <if applicable>

## Frontend Requirements
- Screens/components: <locations>
- State management: <providers/services>
- Local persistence: <prefs/DB>

## Analytics
- <event_1>
- <event_2>

## Accessibility
- <screen reader labels, contrast, focus>

## Edge Cases
- <case 1>
- <case 2>

## Dependencies
- <Other PRDs, services, libraries, config>

## Decisions
- <Decision made, rationale>

## Acceptance Criteria
- [ ] <AC 1>
- [ ] <AC 2>

## Implementation Checklist
- [ ] <Task 1>
- [ ] <Task 2>

## Task Breakdown
| Task | Owner | Notes |
|------|-------|-------|
| <Task> | <Owner> | <Notes> |

## Testing Plan
- Unit: <what to test>
- Integration: <what to test>
- Manual QA: <devices/platforms>

## Test Matrix
| Scenario | Expected Result |
|----------|-----------------|
| <Scenario> | <Result> |

## Rollout Plan
- <feature flag, staged rollout, monitoring>

## Risks
- <risk 1>
- <risk 2>

## Open Questions
- <question 1>
- <question 2>
