---
title: Mode of interaction
description: >
  Learn to balance LLM capabilities with traditional code and implement 
  guardrails to manage nondeterministic AI behavior.
prev:
  title: Tool calls (aka function calls)
  path: /ai/best-practices/tool-calls
next:
  title: Developer experience
  path: /ai/best-practices/developer-experience
---


It's a mistake to think of a request to an LLM in the same way as calling a
function. Given the same set of inputs in the same order, a function acts
predictably. We can write tests and inject faults and harden a function for a
wide variety of inputs.

An LLM is not like that. A better way to think about it is as if the LLM were a
user and to treat the data we get from them as such. Like a user, an LLM is
nondeterministic, often wrong (partially or wholly) and sometimes plain random.
To guard our apps under these conditions, we need to build the same guardrails
around LLM input as we do around user input.

If we can do that successfully, then we can bring extraordinary abilities to
apps in the form of problem solving and creativity that can rival that of a
human.

### Separation of concerns

LLMs are good at some things and bad at others; the key is to bring them into
your apps for the good while mitigating the bad. As an example, let's consider
the task list in the Crossword Companion:

<img
src="/assets/images/docs/ai-best-practices/crossword-task-list-showing-solved-clues.png"
alt="Crossword task list showing solved clues in green with confidence
percentages and unsolved clues in red">

The task list is the set of clues that need solving. The goal is to use colors
and solutions in the task list to show progress during the solving process. The
initial implementation provided the model with a tool for managing the task
list, asking it to provide updates on progress as it went. Flash could not solve
the puzzle this way, but Pro could. Unfortunately, it solved it in big chunks,
only remembering to update the task list once or twice with a big delay in
between. No amount of prompting could convince it to update the tasks as it
went. You'll see the same behavior with modern AI agents managing their own task
lists; that's just where we are in the evolution of LLMs at the moment.

So how do we get consistent, deterministic updates of the task list? Take task
management out of the LLM's hands and handle it in the code.

To generalize, before applying an LLM solution to a problem you're facing, ask yourself whether an LLM is the best tool for the job. Is human-like problem solving and creativity worth the tradeoff in unpredictability?

The answer to that question comes with experimentation. Here are some examples
from the sample:

| Task                                              | LLM Suitability                                              | Code Suitability                                                                  |
| ------------------------------------------------- | ------------------------------------------------------------ | --------------------------------------------------------------------------------- |
| **Parsing the grid for size, contents and clues** | Great for an LLM by using  vision and language understanding | Difficult to write the code to do this                                            |
| **Validating grid contents**                      | Possible to do with another LLM checking the work            | Easier for a human to glance at and adjust                                        |
| **Handling the task list**                        | An LLM is unlikely to do this consistently                   | Easy to write the code to loop through a task list, updating as it goes           |
| **Solving each clue**                             | Great for an LLM using language understanding and generation | Difficult to do given real world clues that depend on word play, names, and slang |
| **Resolving conflicts**                           | An LLM is inconsistent on this kind of looping               | Easy for a human to glance at and adjust                                          |

It's a judgement call for sure, but if you can reasonably write the code to do
it, your results will be predictable. However, if writing the code would be
unreasonably difficult, then consider an LLM, knowing you'll have to build the
guardrails like we did in the sample.

### Ask vs agent

There's more than just one pivot to consider besides code vs. LLM. Models
operate in roughly two modes: "ask" and "agent".

A LLM is in "ask" mode when we prompt it without giving it tools to affect
change in the world, for example, no tools at all or tools just for looking up
data. Both the crossword interference model and clue solver models run in ask
mode, using tools only for additional data.

On the other hand, when we give an LLM a set of tools that allow it to operate
on our behalf in the world – like reading and writing files, executing bash
commands, loading web pages, calling web APIs, and so on – that LLM is in
"agent" mode.

### Guardrails

The difference between ask and agent mode is not the model you choose or the
prompts you give it, but the tools you supply. The combination of the tools and
the agentic loop described in the Tool calls section allow an LLM to call any
number of those tools as often as it decides. Giving it that power puts the
responsibility on you to make sure you treat it as unpredictable; more like a
person than a program.

You do that the same way that you validate user input, by building up a suite of
tests to see how your app works against LLM responses. Give real LLMs a wide
variety of prompts and mock the tools to evaluate how the LLM is using them.
Like your first user testing experience, your first LLM testing results might
surprise you. Use that data to build the guardrails you need to harden your app.

In the sample, we didn't have to guard against harm, but we did have to guard
against imperfect results. It was extensive testing against real-world data that
led to the institution of human-in-the-loop guards against attempting to solve
an invalid puzzle or conflicting solutions. In this way, Flutter and Firebase AI
Logic make the perfect combination to harness the power of an LLM and bring
unique capabilities to your apps.

