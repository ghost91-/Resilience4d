# Contributing to Resilience4d
First off, thank you for your interest in contributing to Resilience4d—we need
all the help we can get! 

The following is a set of guidelines for contributing to Resilience4d. These are
mostly guidelines, not rules. Use your best judgment, and feel free to propose
changes to this document in a merge request.

## Important resources
- Documentation: [README.md](README.md) (we don’t have anything else at the
  moment)
- Issue tracker: [Issues](https://gitlab.com/ghost91-/resilience4d/issues)


## Building and testing
To find out about how to build and test the project, read the corresponding
sections in [README.md](README.md).

## Ways of contributing

### Reporting bugs

This section guides you through submitting a bug report for Resilience4d.
Following these guidelines helps maintainers and the community understand your
report and reproduce the behavior.

#### Before submitting a bug report
- Make sure you are using the latest version of Resilience4d.
- Check the [README.md](README.md) which covers some common problems.
- Check if the problem has already been reported in our [issue tracker](https://gitlab.com/ghost91-/resilience4d/issues).

#### How to submit a (good) bug report
Bugs are tracked in our [issue tracker](https://gitlab.com/ghost91-/resilience4d/issues).
When creating a bug report,please provide the following information by filling
in the [template](https://gitlab.com/ghost91-/resilience4d/issues/new?issuable_template=Bug%20report).

Explain the problem and include additional details to help maintainers reproduce
the problem:

- **Use a clear and descriptive title** for the issue to identify the problem.
- **Provide a short summary describing the problem.**
- **Describe the exact steps which reproduce the problem** in as many details as
  possible. When listing steps, don’t just say what you did, but explain how you
  did it.
- **Describe the behavior you observed after following the steps** and point out
  what exactly is the problem with that behavior.
- **Explain which behavior you expected to see instead and why.**
- **If the problem was not triggered by a specific action**, describe what you
  were doing before the problem happened and share more information using the
  guidelines below.

Provide more context by answering these questions:

- **Did the problem start happening recently** (e.g. after updating to a new
  version of Resilience4d) or was this always a problem?
- If the problem started happening recently, **can you reproduce the problem in an older version of Resilience4d?**
  What is the most recent version in which the problem does not happen?
- **Can you reliably reproduce the issue?** If not, provide details about how
  often the problem happens and under which conditions it normally happens.

Include details about your configuration and environment:
- **Which version of Resilience4d are you using?**
- **What is the name and version of the OS you are using?**
- **What is the architecture of the system you are using?** (e.g. x86, x86_64 or
  armv7h)

### Suggesting enhancements

This section guides you through submitting an enhancement suggestion for
Resilience4d, including completely new features and minor improvements to
existing functionality. Following these guidelines helps maintainers and the
community understand your suggestions.

#### Before submitting an enhancement suggestion
- Make sure you are using the latest version of Resilience4d. You might discover
that the enhancement is already available.
- Check if the enhancement has already been suggested in our [issue tracker](https://gitlab.com/ghost91-/resilience4d/issues).

#### How to submit a (good) enhancement suggestion

Enhancement Suggestion are tracked in our [issue tracker](https://gitlab.com/ghost91-/resilience4d/issues).
When creating an enhancement suggestion, please provide the following
information by filling in the [template](https://gitlab.com/ghost91-/resilience4d/issues/new?issuable_template=Enhancement%20suggestion).

- **Use a clear and descriptive title** for the issue to identify the
  suggestion.
- **Provide a short summary describing the suggested enhancement.**
- **Provide a user story** in the format "As a ${role} I want to ${enhancement}
  so that ${purpose}".
- **Explain why this enhancement would be useful.**
- **List the acceptance criteria.**

### Your first contribution

If you are unsure where to start, you can look through issues tagged with
`beginner` and `help wanted`:
- [Beginner issues](https://gitlab.com/ghost91-/resilience4d/issues?label_name%5B%5D=beginner):
  issues which should only require a few lines of code and a test or two.
- [Help wanted issues](https://gitlab.com/ghost91-/resilience4d/issues?label_name%5B%5D=help+wanted):
  issues which should be a bit more involved than `beginner` issues.

### Merge requests

#### Branching model
We are using [OneFlow](https://www.endoflineblog.com/oneflow-a-git-branching-model-and-workflow)
as our branching model. Additionally we require that all merges be done as merge
requests and we also have a naming scheme for our feature branches:
```
<scope>-<issue_number>_short-description
```
Scope can be one of the following:
- `feature`: New features and enhancements to existing features
- `bugfix`: Bug fixes (obviously)
- `technical`: Changes of the code that do not modify features (e.g.
  refactoring, adding tests, updating dependencies etc.)
- `chore`: Everything that does not touch the actual code (modifying README
  files, renaming files etc.)

If there is no corresponding issue number, simply omit it.

#### Submitting merge requests
When creating a merge request, please provide the following information by
filling in the [template](.gitlab/merge_request_templates/Merge%20request.md).

- What issue does this merge request correspond to?
- What does this merge request implement?
- What changes are made in this merge request?

## Styleguides

### Git commit messages
Git commit messages must have the following format:
```
<scope>: short description
optionally some more description in the following lines
```
Scope can be one of the following:
- `fix`: Bug fixes
- `feat`: Completed features
- `wip`: Work in progress
- `test`: Everything related to tests
- `refactor`: Refactoring
- `technical`: Everything else that is `technical` and does not belong to
  `test` or `refactor`
- `chore`: Everything not touching the actual code

For the actual text in the commit message, here are some additional guidelines:

- Use the present tense ("add feature" not "added feature").
- Use the imperative mood ("move cursor to…" not "moves cursor to…").
- Limit the first line to 72 characters or less.
- Reference issues and merge requests liberally after the first line.

### D styleguide
All D code must adhere to [The D Style](https://dlang.org/dstyle.html). We
suggest using [dfmt](https://github.com/dlang-community/dfmt) to format the code
accordingly.

### Imports

All imports should be selective, except for module-level imports using more than
three specific imports. These should import the whole corresponding module.
Each symbol should only be imported once, and with a scope as small as possible
(i.e. function/scope level imports are preferred over module-level imports).

## Additional notes

### Issue labels

We use issue labels to categorize issues into groups. This makes finding issues
belonging to a particular group very easy. 
Our tagging system is loosely based on Zach Dunn’s [Styleguide for issue tagging](https://robinpowered.com/blog/best-practice-system-for-organizing-and-tagging-github-issues/). Here is a list
of all labels we currently use:

| Label name | Description |
| --- | --- |
| `bug` | Bugs. |
| `security` | Security related issues. |
| `chore` | Chores that do not require any changes to the code. |
| `test` | Test related issues. |
| `discussion` | More a discussion than an actual issue. |
| `question` | More a question than an actual issue. |
| `enhancement` | Enhancements to existing features. |
| `optimization` | Optimization (e.g. performance). |
| `feature` | New features. |
| `in progress` | Issues that are currently in progress. |
| `watchlist` | Issues that we would like to proceed with, but need some action first (e.g. more clarification). |
| `invalid` | Invalid issues. |
| `wontfix` | Issues we have decided to not fix (for whatever reason). |
| `duplicate` | Issues that are duplicates of other issues. |
| `on hold` | Issues that we decided to not deal with right now, but might come back to later. |
| `beginner` | Issues that are a great start for new beginning contributors. |
| `help wanted` | Issues we would like new contributors to help us with. |

### Project board

We use a [project board](https://gitlab.com/ghost91-/resilience4d/boards/894356)
to manage our current work. It is a great place to see what is currently being
worked on and what is planned next.