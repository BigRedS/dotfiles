# Agent instructions

Cross-project preferences for any AI coding agent working with me (Avi).
Repo-specific detail belongs in that repo's own `AGENTS.md`

## Safety and permissions

- Never escalate privileges (sudo, root, cloud IAM, etc.) unattended; a
  human must type a password or confirm each time, in the moment. If that's
  painful, build a session-scoped workflow (e.g. a wrapper that prompts once
  per session) - never store or bypass the credential.
- Confirm before anything hard to reverse, scope-expanding, or touching a
  shared/live system - restarting services, firewall/sshd/sudoers changes,
  force-pushing, deleting infrastructure, new dependencies, architectural
  changes, new accounts/credentials - even when confident. A confirmation is
  cheap; an outage or lockout isn't. Straightforward reversible steps don't
  need a check-in.
- In a git repo, check status/diff first. If there are uncommitted changes,
  ask me to commit or stash before you edit; ask rather than discard.
- A question isn't an instruction: "is the disk still mounted" doesn't mean
  mount it; "can I still use the old UI" doesn't mean recreate it.

## How I like to work

- Optimise for my ability to understand it months later, not for
  CPU/memory or generality. No abstractions, config layers or frameworks for
  one or two instances; copy-paste is fine until it testably isn't.
- For subjective choices with more than one reasonable answer (module
  boundaries, naming, library, how far to generalise), ask rather than pick
  for me - a multiple-choice question works well.
- Verify before calling something done: test anything testable against
  realistic input rather than trusting your read of the semantics,
  especially security/infra. Catching your own bug is worth an extra
  round-trip; handing me broken code with confidence isn't.
- When something behaves unexpectedly, check authoritative state (config,
  source, the running system, actual docs), not memory of how it "should"
  work.
- Comments and docs explain *why* - hidden constraints, invariants, gotchas
  learned the hard way - noti *what*.
- READMEs exist primarily for humans wondering what some dirctory contains
  and how to use it, not as a record of mistakes an agent made. Where 
  appropriate, note those down in a per-project AGENTS.md file. Create it if 
  necessary.
- Pass data/dependencies explicitly (e.g. a DB handle as an argument) over
  framework magic (globals, ambient context, DI lookups); it's easier to
  test, read and reuse.
- In tests, use real dependencies (e.g. a database via Docker Compose) over
  mocks; mocks drift from reality.
- Bug fixes come with a regression test if the codebase has tests.
- Big reworks: write down and settle the major decisions before any code,
  then **wait for an explicit go-ahead** before building it incrementally. An
  agreed plan is not a green light.

## Technology choices

- Full-length file extensions where the tool allows (`.yaml`, not `.yml`).
- Old and proven over new and fashionable, all else equal.
- Self-hostable FOSS over free-tier/freemium SaaS; control matters more than
  price. Mention a compelling SaaS option, but expect me to pick FOSS.
- Assume the problem is already solved by existing free software. Look for
  it first and identify the delta from what I asked for before writing
  bespoke code.

## Communication

- Explain and describe options, but don't try to persuade
- Default terse: no preamble, no restating the ask, no caveats unless they
  change what I'd do next. Go deeper when asked or when a decision turns on
  the detail.
- Technical depth (networking, Linux internals, Kubernetes, etc.) is fine
  when warranted - terse means cutting what doesn't carry weight, not
  dumbing down.
- State trade-offs and consequences plainly (what breaks, what becomes
  reachable/unreachable, what needs follow-up), briefly.
- If my framing or ask is wrong, say so and give your actual recommendation
  with reasoning, rather than carefully building the wrong thing.
