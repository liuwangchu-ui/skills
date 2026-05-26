# Third-Party Codex Skills Stack

This repository is a management repository for collecting, organizing, and syncing third-party Codex Skills. It does not invent new skills from scratch. Skills here are copied from the specified upstream sources, or marked as pending when no matching real skill was found.

## Skill Stack

| Directory | Installed skill name | Status | Source | Purpose |
|---|---|---|---|---|
| `agent-reach` | `agent-reach` | available | https://github.com/Panniantong/Agent-Reach | Routes web, social, GitHub, RSS, video, and other search/read tasks to Agent Reach tools. |
| `find-skills` | `skill-installer` | available, closest replacement | https://github.com/openai/skills/tree/main/skills/.system/skill-installer | Closest real implementation for finding/listing/installing Codex skills from OpenAI or GitHub sources. A standalone `find-skills` skill was not found in the specified sources. |
| `superpower` | `using-superpowers` | available | https://github.com/smallocean43658/codex-superpowers | Entry skill for using the Superpowers workflow and its skill-selection discipline in Codex. |
| `humanizer` | `humanizer` | available | https://github.com/blader/humanizer | Removes signs of AI-generated writing from English text and makes drafts sound more natural and human-written. |
| `humanizer-zh` | `humanizer-zh` | available | https://github.com/op7418/Humanizer-zh | Removes signs of AI-generated writing from Chinese text and makes drafts sound more natural and human-written. |
| `planning-with-files` | `writing-plans` | available, closest replacement | https://github.com/obra/superpowers/tree/main/skills/writing-plans | Closest real implementation for file-aware implementation planning. A standalone `PlanningWithFiles` skill was not found in the specified sources. |
| `context-engineering-skills` | `long-context` | available, closest replacement | https://github.com/Orchestra-Research/AI-research-SKILLs/tree/main/19-emerging-techniques/long-context | Closest real implementation related to long-context engineering. A standalone `ContextEngineeringSkills` skill was not found in the specified sources. |

## Missing / Pending

- `find-skills`: no standalone skill found. Installed the official OpenAI `skill-installer` skill as the nearest real replacement.
- `planning-with-files`: no standalone skill found. Installed Superpowers `writing-plans` as the nearest real replacement.
- `context-engineering-skills`: no standalone skill found. Installed AI Research Skills `long-context` as the nearest real replacement.

## Install

Run from the repository root:

```bash
./setup.sh
```

The installer:

- creates `~/.codex/skills`
- prefers symlinks from this repository into `~/.codex/skills`
- skips any skill that already exists at the destination
- skips pending directories without `SKILL.md`
- prints the result for every directory

## Update

Pull this repository and run setup again:

```bash
git pull
./setup.sh
```

Because setup uses symlinks by default, updates in this repository are immediately reflected for linked skills. Restart Codex after updating skills so discovery refreshes cleanly.

## Use In VS Code Codex

After running `./setup.sh`, restart VS Code Codex. Open `/skills` to inspect discovered skills.

You can explicitly request a skill with:

```text
$agent-reach search this topic
$skill-installer list available skills
$using-superpowers start with the Superpowers workflow
$humanizer make this English draft sound natural
$humanizer-zh 润色这段中文，去掉 AI 味
$writing-plans create an implementation plan
$long-context help with long-context model work
```

Note that Codex uses the `name:` field inside each `SKILL.md`, so the callable skill name may differ from this repository's directory name when a closest replacement is used.

