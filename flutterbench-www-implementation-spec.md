# Implement FlutterBench results page on flutter.dev (`sites/www`)

## Read this first

Before writing any code, read the repository's own `AGENTS.md` at the repo
root and follow it. It documents the real, current directory layout, build
commands, and conventions for this repo — treat it as higher authority than
anything below if the two ever disagree. As of this writing it establishes:

- The repo is a Dart pub workspace containing multiple sites under `sites/`.
- `sites/www/` is the implementation of **flutter.dev**, written in Dart
  using **Jaspr** and **Jaspr Content**.
  - `sites/www/content/` — Markdown-based marketing pages and structured
    content.
  - `sites/www/lib/` — Dart source code for the site (components, layouts,
    data models, routing).
  - `sites/www/firebase.json` — Firebase Hosting config for flutter.dev.
- Common commands (run from repo root):
  ```
  dart pub get
  dart run dash_site --site=www serve
  dart run dash_site --site=www build
  dart run dash_site --help
  ```

**Before implementing anything, spend time exploring `sites/www/lib` and
`sites/www/content` for an existing page that already does something close
to what we need** — a filterable/sortable grid or table driven by structured
data (candidates to look for: a showcase/case-studies grid, a
release-notes or roadmap listing, a search/index page, anything under an
`/ai/` or `/community/` section). Mirror that page's patterns (routing,
component structure, styling, how it wires interactivity) rather than
inventing new ones. This repo already ships `.agents/` and `AGENTS.md`
tooling for agent contributors — check `.agents/` for any additional
skills or house rules before starting.

Do not guess at exact Jaspr/Jaspr Content API signatures (component base
classes, the `@client` annotation, routing registration, CSS/Sass wiring).
Confirm the exact syntax against:
1. The installed package versions in `sites/www/pubspec.yaml` /
   `pubspec.lock`.
2. Existing components elsewhere in `sites/www/lib`.
3. The upstream Jaspr and Jaspr Content docs if neither of the above
   answers it.

---

## What we're building

A new page (plus supporting sub-pages) on flutter.dev that presents results
from **FlutterBench**, an internal AI-coding-agent benchmark for Dart and
Flutter tasks. This is the MVP slice only — see "Out of scope" below.

The page must let a visitor answer, without reading raw JSON:

1. Which model/agent configuration currently performs best on Dart/Flutter
   tasks.
2. Whether Dart/Flutter-specific AI tooling (the Dart MCP server, bundled
   skills) measurably helps.
3. Which kinds of tasks (CUJs) models handle well vs. poorly.

### Source data shape

FlutterBench produces one **job** per benchmark run. A job is a matrix of
`(agent config) × (task)` **trials**. You will be given (or need to write an
ingestion step for) data shaped like the following — treat this as the
canonical schema to model in Dart, not the final file layout:

- **Job summary** (`result.json` at the job root): `id`, `started_at`,
  `finished_at`, `n_total_trials`, and a `stats` block containing, per
  `evals` key (an eval key looks like `"{agent}__{model}__{variant}"`):
  - `n_trials`, `n_errors`
  - `metrics`: `{ reward: {mean, median, min, max} }`
  - `pass_at_k`: `{ "1": 0.67 }`
  - `reward_stats`: reward value → list of trial names at that reward
  - `exception_stats`: exception type → list of trial names
  - plus job-level `n_input_tokens`, `n_cache_tokens`, `n_output_tokens`,
    `cost_usd`.
- **Per-trial `result.json`**: `trial_name` (format
  `{task-slug}__{shortid}`), `task_name`, `config.agent` (`name`,
  `model_name`, `skills[]`, `mcp_servers[]`), `agent_result`
  (`n_input_tokens`, `n_output_tokens`, `cost_usd`), `verifier_result.rewards.reward`,
  `exception_info` (present only on errored trials — `exception_type`,
  `exception_message`), and phase timestamps (`environment_setup`,
  `agent_setup`, `agent_execution`, `verifier`).
- **Per-trial `verifier/reward-details.json`**: a nested scoring tree.
  Top-level `reward` is a weighted aggregator over named criteria (typically
  `outcome`, `quality`, `dx`), each of which is itself an aggregator over
  further named criteria. Some criteria are `"kind": "llm"` and carry a
  `reasoning` string per sub-criterion (LLM-judge output) in addition to a
  numeric `value`. Sibling top-level blocks like `process` and `efficiency`
  are `"diagnostic": true` — **do not** fold these into the reward number
  anywhere in the UI; label them explicitly as diagnostic-only.
- **Per-trial `verifier/test-stdout.txt`**: human-readable verifier log,
  useful as a raw-log fallback.
- **Per-trial `agent/trajectory.json`** (when present): ordered list of
  `{ action, input, duration_ms }` steps.
- **Per-trial `agent/*.txt`**: raw agent tool-call transcript.
- **Per-trial `artifacts/manifest.json`**: list of `{ source, destination,
  type, status }` describing files copied out of the sandboxed workspace
  (e.g. `lib/bloc/counter_bloc.dart`), plus the files themselves under
  `artifacts/workspace/...`.
- Trials that error out (`exception_info` non-null) have **no**
  `verifier_result` and must never be silently averaged in as a `0` —
  they're a distinct status, not a score.

### Data ingestion decision to make explicitly

FlutterBench data will not live in the website repo in raw form. Before
writing any Dart, decide and document (in the PR description) one of:

- **(a) Build-time static import**: a script/tool step that pulls the
  latest job's data (from wherever FlutterBench publishes it — GCS bucket,
  internal API, etc.) and writes it into `sites/www/content/data/flutterbench/`
  as JSON, checked into the content directory like other structured content,
  regenerated periodically by CI.
- **(b) Client-time fetch**: the page fetches a published JSON endpoint at
  runtime.

**Default to (a)** unless told otherwise — flutter.dev pages are
statically generated, and every other data-driven page in this repo will be
doing the same via `sites/www/content/`. If no such ingestion pipeline
exists yet, build the MVP against a small set of **fixture JSON files**
matching the schema above (you can shape these directly off the FlutterBench
mock data referenced in this project's history) so the UI can be built and
reviewed while the real pipeline is worked out separately. Flag this
explicitly as a known gap in the PR description if you go this route.

---

## Pages and routes

Confirm the exact route prefix with whoever owns flutter.dev's top-level
nav before merging — recent site work has been organizing AI-related
content under an `/ai/` section (see `sites/docs` for the `/ai/` docs
tree), so `/ai/flutterbench` may be the right home; `/flutterbench` at the
top level is the fallback. Whichever you pick, wire it into the existing
top-nav data file used by the site (find it by searching for how the
current nav items are declared — likely a YAML/JSON/Dart data file
referenced by the layout, not hardcoded HTML).

1. **`/ai/flutterbench` — Overview / Leaderboard** (the main deliverable)
2. **`/ai/flutterbench/tasks`** — Task (CUJ) explorer
3. **`/ai/flutterbench/tasks/<task-slug>`** — one task's cross-model results
4. **`/ai/flutterbench/trials/<trial_name>`** — single trial detail
5. **`/ai/flutterbench/methodology`** — static Markdown page (can be a
   plain `.md` file under `sites/www/content/`, no custom component needed)
   explaining the harness, scoring rubric, and reproduction steps.

For (3) and (4): prefer generating one static page per task/trial at build
time (the same way this site already generates one page per blog post) over
a single client-side-routed page, so results are crawlable, linkable, and
don't require a JS data fetch to render. If the existing patterns in
`sites/www/lib` favor a different approach for list-detail content, follow
that instead.

---

## Components to build

Match these to whatever this site's actual component/layout terminology is
(Jaspr components, layouts, partials) — the names below are functional
descriptions, not literal class names to copy verbatim.

### 1. `SummaryStatsBar`
Row of 3–4 stat cards above the fold: top model (by mean reward), overall
average reward for the latest job, trials run, trials errored. Pull straight
from the job-level `stats` block. Reuse this site's existing "stat card" or
metric-card styling if one exists anywhere on flutter.dev (check the
homepage or a stats/about page); don't invent new card chrome if a
convention already exists.

### 2. `LeaderboardTable`
One row per eval key (`agent__model__variant`), columns: rank, agent name,
model, mean reward (show min–max as a small inline range, not just the
mean), pass@1, cost (`cost_usd`), token count, error count. Sort by any
numeric column, client-interactive (mark whichever component handles the
sort/filter state as a Jaspr `@client` component per this site's existing
convention for interactive islands — check an existing interactive widget
on the site, e.g. a search box or theme toggle, for the pattern). Default
sort: mean reward, descending.

Row click routes to `/ai/flutterbench/tasks?agent=<eval-key>` (or opens an
inline expansion — match whatever disclosure pattern this site already uses
for "show more" content).

### 3. `FilterBar`
Chips/segmented controls above the table:
- Provider/lab filter (derive from model name prefix — this is cosmetic
  grouping, no new data field required for MVP).
- CUJ category filter, if tasks have been tagged with a category; otherwise
  omit for MVP rather than inventing a taxonomy.
- **"With Dart tooling" / "Without" toggle.** This only makes sense once
  the ingested trials actually contain matched pairs (same task, same base
  model, `agent.skills` / `agent.mcp_servers` varied). If the current data
  doesn't have such pairs yet, build the toggle as a no-op / disabled state
  with a tooltip explaining why, rather than faking a comparison — do not
  ship a misleading toggle.

All filters operate client-side over data already present in the page
(no server round-trip needed for MVP-scale data).

### 4. `TaskModelHeatmap`
Grid: rows = tasks, columns = eval keys, cell = reward, color-scaled
red→green using this site's existing danger/warning/success role colors
(don't introduce new raw hex values — reuse whatever Sass variables or CSS
custom properties already express status color on this site, matching
Material's semantic color conventions Flutter docs already use elsewhere).
Errored/timed-out cells get a visually distinct (hatched or dashed-border,
gray) treatment — never render an error as if it were a `0` score.
Clicking a cell routes to the corresponding
`/ai/flutterbench/trials/<trial_name>` page.

Below the grid, render a short computed "best CUJs" / "worst CUJs" list per
selected model (top/bottom 3 by reward) as plain text — this is a
derived summary, not a new data source.

### 5. `TrialDetailView`
Renders a single trial. Sub-sections (use this site's existing tab or
section-anchor pattern, whichever is idiomatic here):

- **Summary**: reward, a status badge (pass / partial / fail / **error** —
  error is its own visually distinct state, not a low score), task name,
  agent/model, and a small timeline showing the four phase durations
  (`environment_setup`, `agent_setup`, `agent_execution`, `verifier`).
- **Reward breakdown**: render `reward-details.json` as a nested,
  expandable tree — top-level weighted criteria (`outcome`/`quality`/`dx`)
  expanding into their sub-criteria, each showing its `value`, `weight`,
  and `description`. For `"kind": "llm"` criteria, show the `reasoning`
  text inline under that criterion. Render `process` and `efficiency` in a
  clearly separated "diagnostic (not scored)" section.
- **Trajectory**: if `agent/trajectory.json` exists, render its steps as a
  simple ordered list/timeline (action, duration). If it doesn't exist for
  a given trial, omit the section entirely rather than showing an empty
  state — not every trial will have this.
- **Artifacts**: list files from `artifacts/manifest.json`; render each
  file's contents in a code block (this site already has Markdown/code
  fence syntax highlighting via Jaspr Content — reuse it rather than adding
  a new code viewer).
- **Raw logs**: collapsible section with `verifier/test-stdout.txt` and, if
  present, `exception.txt`/`exception_info`.

### 6. `ErrorStateBadge`
A small reusable component (not just a text label) for anywhere a trial's
`exception_info` is shown — used in the leaderboard, the heatmap, and the
trial detail page, so error styling is consistent everywhere it appears.

---

## Styling

- Do not introduce a new color palette. Use flutter.dev's existing brand
  blue for navigation/accent affordances (active filters, links) and this
  site's existing semantic danger/warning/success tokens for reward
  severity — these must stay visually distinct from each other so users
  never confuse "this is a link" with "this is a bad score."
  Grep `sites/www` for the site's Sass/CSS variable names (or however
  Jaspr styling is wired in this codebase — inline `Styles`, CSS files, or
  Sass) before hardcoding any color, and reuse what's there.
- Confirm dark-mode behavior: flutter.dev supports light/dark; every color
  used for reward severity and the heatmap must have a legible dark-mode
  pairing (tinted background + higher-contrast text, not pure fills).
- This page is denser and more tabular than most flutter.dev marketing
  pages — it's fine, and preferable, for it to look closer to a docs/API
  reference page than a landing page. Check whether `sites/docs` has table
  styling that's more appropriate to borrow than anything in `sites/www`
  itself, since this content is closer in spirit to docs than marketing.

---

## Build order (do these as separable PRs if possible)

1. Data models + fixture JSON + ingestion decision documented (see above).
2. `/ai/flutterbench` leaderboard page: `SummaryStatsBar` + `FilterBar` +
   `LeaderboardTable`. This alone should be reviewable and mergeable.
3. `/ai/flutterbench/trials/<trial_name>` detail page with the reward
   breakdown tree. (Ship this before the heatmap — the heatmap is much
   less trustworthy without a way to click through and see *why* a score
   is what it is.)
4. `/ai/flutterbench/tasks` + task detail pages + `TaskModelHeatmap`.
5. The with/without-tooling filter state in `FilterBar` (real, once matched
   pairs exist in the data — otherwise leave disabled per above).
6. `/ai/flutterbench/methodology` static page.

## Out of scope for this MVP (do not build)

- Trajectory action-category stacked bar charts.
- Reward distribution histograms.
- Cost/efficiency scatterplots.
- Any live/streaming updates — this is a static-rebuild-per-job site.
- A generalized job-history view (trends across multiple past jobs); MVP
  shows only the latest job.

## Acceptance checklist

- [ ] `dart run dash_site --site=www serve` runs locally and
      `/ai/flutterbench` renders the leaderboard from fixture data.
- [ ] Leaderboard sorts by reward, cost, and error count.
- [ ] Clicking a leaderboard row and a heatmap cell both reach a working
      trial detail page.
- [ ] A trial with `exception_info` set renders as a distinct error state
      everywhere it appears (leaderboard, heatmap, detail page) — never as
      a `0` blended into an average.
- [ ] `process`/`efficiency` diagnostic scores are visually and textually
      separated from the scored `reward` breakdown.
- [ ] Page passes this repo's existing checks: `dart run dash_site
      format-dart --check`, `dart run dash_site analyze-dart`, and any
      link-check command documented in `AGENTS.md`.
- [ ] Dark mode reviewed for the heatmap and all status colors.
- [ ] New route(s) added to the site's nav data file, not hardcoded into a
      layout template.

## Open questions to resolve with a human before/while implementing

1. Final route prefix (`/ai/flutterbench` vs `/flutterbench`) and nav
   placement.
2. Where FlutterBench's real job data will be published from, and who owns
   the ingestion job that turns it into `sites/www/content/data/...`.
3. Whether task "CUJ category" tags exist anywhere yet, or need to be added
   to FlutterBench's own output before the task filter can be meaningful.
4. Whether any matched with/without-tooling trial pairs currently exist in
   the data (needed before item 5 in the build order can ship as
   functional rather than disabled).
