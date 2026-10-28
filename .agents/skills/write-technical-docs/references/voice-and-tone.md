# Voice and tone in documentation

Use this guidance to establish the voice and stance of documentation.

## Tone and stance

Aim for conversational, friendly, and respectful without being frivolous.
Write the way a knowledgeable colleague speaks: clear, direct, and warm.

- Be helpful, not promotional.
  Documentation explains.
  It doesn't sell.
- Skip exclamation points, hype, and forced enthusiasm.
- Don't tell readers a task is "easy", "simple", or "quick".
  Such labels can discourage readers who struggle with the task.
  State what to do instead.
- Avoid "please" in instructions.
  "Click **Save**" is correct, not "Please click **Save**".
- Address the reader as a capable adult.
  Don't over-explain basics that the target audience already knows.

## Second person and first person

- Use **second person** and "you" to address the reader.
  "You can configure the timeout" is direct and clear.
- Use _user_ only for a person who uses software
  that the reader is developing.
  Use third person for actions performed by software or an end user.
- Imperative instructions often imply "you":
  "Configure the timeout" rather than "You should configure the timeout".
- Use **first person plural**, "we",
  only for actions or recommendations from the authoring organization,
  such as "We recommend using a service account".
  Don't use "we" to describe the reader's actions.
  For example, don't write "we then run the command".
  The phrasing is a tutorial-narration habit to avoid.
- Avoid "I" except in frequently asked questions
  written from the reader's point of view.

## Contractions

- Use common contractions,
  such as "it's", "you're", "don't", "can't", and "won't"
  for a natural tone.
- Avoid ambiguous or awkward contractions and stacked ones such as "it'll've".
- Don't form contractions from nouns plus verbs
  in ways that could read as possessives,
  as in "the server's running".
  When a contraction could be ambiguous,
  spell out the words.

## Active voice

- Prefer active voice: the subject performs the action.
  "The service validates the token", not "The token is validated".
- Active voice requires you to name the actor,
  which removes ambiguity about who or what does something.
- When the actor is unknown, irrelevant, or obvious,
  or you deliberately want to focus on the receiver of the action,
  passive voice is acceptable.
  Use it sparingly and on purpose.
- Look for passive constructions in reference documentation:
  "is returned" and "are stored".
  Rewrite to name the method or system that acts.

## Present tense

- Describe behavior in present tense:
  "The function returns null", not "will return".
- Avoid "will" for routine cause and effect.
  Reserve future tense for events
  that are genuinely later than another described event.
- Where "can" or a direct statement works,
  don't use "would", "could", or "should".

## Anthropomorphism

- Don't attribute human cognition or feeling to software.
  Avoid "the script wants", "the model thinks", "the API knows",
  "the system sees", and "the parser is happy".
- Use mechanical verbs:
  _returns_, _sends_, _stores_, _processes_, _produces_, _requires_,
  _accepts_, and _rejects_.
- "The app asks for permission" is fine as a description of a prompt.
  "The app decides it needs permission" implies intent and is not.

## Excessive claims

- Don't overstate capability.
  Avoid "fully", "completely", "always", "never", "guarantees",
  "ensures", and absolute security or performance promises.
  Use them only if they are literally true and verifiable.
- Avoid superlatives such as
  "the fastest", "the most powerful", and "the best",
  and unmeasurable marketing language.
- Don't promise outcomes outside the product's control
  with claims such as "this makes your app secure".
  Describe what the feature does, not what the reader will achieve.

## Jargon

- Avoid unnecessary jargon, internal code names, and insider shorthand.
- When a technical term is necessary,
  define it on first use or link to a definition,
  and then use it consistently.
- Don't use jargon as a heading without explanation.
- Replace vague jargon with precise terms:
  "canary", "drink from the firehose", "throw it over the wall",
  and similar phrases rarely translate and often exclude.

## Prescriptive documentation

- When a recommended default exists,
  lead with it instead of presenting every option as equal.
- Describe alternatives only when they help the reader decide,
  and give the condition for choosing each one.
- Avoid "you can do A, or B, or C, or D" with no guidance.
  A list of unranked options doesn't help the reader decide.

## Stable documentation

- Document released behavior.
  Don't pre-announce products, features, or dates.
- Don't write "coming soon", "in a future release", or "this will be supported".
- For work in development,
  follow your project's disclosure rules.
  By default, omit that work.
- Avoid wording that dates the content:
  "currently", "now", "as of this writing", "recently", "new", "soon".
- Use a specific version or date when the distinction matters.
- Document official deprecations,
  but don't speculate about planned ones.
