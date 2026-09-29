# PA0: Getting Set Up

*How do you hand in an assignment?*

**Due: Friday, October 9, 11:59 pm (Pacific).** Released Monday, September 28. Not graded.

**What to do:** get the starter code with [OneWorld](https://oneworldai.com), open a session with an AI coding assistant in it if you plan to use one, and hand it in.

**Lectures:** The big picture (9/28).

Every assignment in this course follows the same routine: you get the code with OneWorld, work on it on your own computer, with your own tools and, if you like, an AI coding assistant, and hand it in with OneWorld. PA0 goes through it once.

## 1 What you need

- **A computer** running macOS or Linux (Ubuntu 24.04). On Windows, use WSL 2 with Ubuntu 24.04.
- **Claude Code or Codex**, if you plan to use AI: they are the two AI coding assistants whose sessions OneWorld hands in. To install one:

```sh
curl -fsSL https://claude.ai/install.sh | bash        # Claude Code
curl -fsSL https://chatgpt.com/codex/install.sh | sh  # Codex
```

The pages of [Claude Code](https://code.claude.com/docs/en/overview) and [Codex](https://github.com/openai/codex) list other ways to install them.

**If you have no account or token for either,** use [UCSB AI Commons](https://aicommons.ucsb.edu/home), which gives every UCSB student a free monthly budget of tokens, or **ask the TA**, who can also provide tokens.

## 2 Get the starter code

Each assignment has a OneWorld page with three steps. Open PA0's page, which staff send you, and sign in with your email or Google.

**Step 1 installs or updates the command line.** On Windows, run it inside WSL. Run it again for each new assignment.

```sh
curl -fsSL https://downloads.oneworldai.com/oneworld-cli/install.sh | sh
```

If it says to add `~/.local/bin` to `PATH`, add the line it prints to `~/.zshrc` (macOS) or `~/.bashrc` (Linux), and open a new terminal.

**Step 2 joins the assignment.** The first time, it asks you to sign in. It downloads the starter code into a new folder, a git repository, and leaves you in that folder; `Working folder:` shows its path.

```sh
oneworld assessment join <PA0 invite code>
```

**Run every command below in this folder.** First install the tools the course uses:

```sh
sudo build_support/packages.sh   # on Linux
build_support/packages.sh        # on macOS
python3 tools/doctor.py
```

`packages.sh` installs Python, clang and ruff, and `doctor.py` checks them.

> **Exercise 1** (not graded). Get the starter code with OneWorld and install the tools.
>
> **Check:** `python3 tools/doctor.py` ends with `All set.`

## 3 Open a session

Skip this section if you will not use AI. A **session** is one conversation with your AI coding assistant. OneWorld hands in the sessions started in the folder of the starter code, so start the assistant there:

```sh
claude   # or: codex
```

Ask it a question about the starter, such as *What does `tools/doctor.py` check?*, and compare its answer with the code.

> **Exercise 2** (not graded). Open a session in the folder and ask the assistant one question about the starter.
>
> **Check:** in Section 4, `oneworld assessment submit` lists your session.

## 4 Hand it in

**Step 3 hands it in.** Run it in the same folder. It sends what you changed in the starter code (nothing, in PA0), lists the Claude Code and Codex sessions from this folder, and gives you a receipt. At **Include which?**, press Enter to include all of the sessions.

```sh
oneworld assessment status   # shows what submit would send
oneworld assessment submit   # hand it in
```

You can hand in more than once; the last one counts.

> **Exercise 3** (not graded). Hand in PA0, with your session if you opened one.
>
> **Check:** `oneworld assessment submit` ends with a line that starts with `Receipt:`; after Exercise 2, it says that at least one session was shared with the reviewer.

## 5 What comes next

- **Each assignment has its own OneWorld page and invite code;** its handout says how to join it.
- **Each assignment gets a new folder:** its `join` downloads its starter code into a new folder, and from PA2 on, `python3 tools/carry.py` brings in your work from the folder of the assignment before.
- **From PA1 on, 20 of each assignment's 100 points** go to the prompts in your sessions if you use AI, and you must then hand in all of them; if you do not use AI, they go to a design document you write yourself. Each handout says more.
- **Help.** Ask on Slack, or come to section or office hours.
