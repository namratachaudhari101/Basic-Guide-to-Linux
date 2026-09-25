#!/bin/bash
# ^ "Shebang" line — tells the computer to run this file using Bash,
#   no matter what shell you happen to be typing in right now.

# 'set -e' means: if ANY command below fails, stop the whole script
# immediately instead of carrying on and possibly making a mess.
set -e

mkdir -p demo_sandbox
# 'mkdir' = Make Directory. '-p' means "don't error if it already exists".
cd demo_sandbox
# 'cd' = Change Directory. Everything below happens inside this folder.
pwd
# 'pwd' = Print Working Directory — confirms exactly where we are.

echo
echo "== 1. Navigation & Directory Operations =="

ls -a
# 'ls' lists files. '-a' also shows hidden files (ones starting with a dot,
# like .bashrc) that a plain 'ls' would normally skip.

mkdir -p nested/a/b/c
# '-p' here does something extra useful: it creates ALL the missing parent
# folders in one go — "nested", then "a" inside it, then "b", then "c" —
# instead of you having to mkdir each one by hand.

touch nested/a/hello.txt
# Creates an empty file two levels down, so we have something to copy
# around later in this demo.

cd nested/a/b/c
pwd
# Confirms we're now four folders deep inside demo_sandbox.

cd -
# 'cd -' jumps back to the PREVIOUS directory you were in — like a
# browser's "back" button. It also prints the path it jumped to.
pwd
# Confirms we're back in demo_sandbox.

cd ~
pwd
# 'cd ~' (or just 'cd' with nothing after it) always takes you straight
# to your home directory, no matter where you were.

cd -
pwd
# 'cd -' again: since our "previous" directory is now demo_sandbox
# (where we were right before jumping to ~), this toggles us back there.

rmdir nested/a/b/c
echo "removed the empty nested/a/b/c folder with rmdir"
# 'rmdir' removes a directory, but ONLY if it's completely empty.
# It's a safer, more deliberate alternative to 'rm -r' for that case —
# if the folder had anything inside it, rmdir would simply refuse.

echo
echo "== 2. File Creation, Copying & Deletion =="

touch notes.txt
# 'touch' creates a new, empty file.
echo "Hello from Day 3" > notes.txt
# Prints text, and '>' REDIRECTS it INTO notes.txt (overwriting the file).
cat notes.txt
# 'cat' prints a file's entire contents to the screen.

cp notes.txt notes_backup.txt
# 'cp' = Copy. Makes a duplicate; the original notes.txt still exists.

cp -r nested nested_copy
# Plain 'cp' can't copy folders. '-r' means "recursive" — copy this
# folder AND everything inside it (subfolders and files included).
ls -la nested_copy/a
# Shows that hello.txt made it into the copy too.

mv notes_backup.txt notes_old.txt
# 'mv' = Move (also used to rename). No folder changed, so this just
# renames notes_backup.txt to notes_old.txt.

rm notes_old.txt
# 'rm' = ReMove (delete) a single file. There's no recycle bin — it's gone.

rm -f does_not_exist.txt
echo "rm -f on a missing file didn't cause an error — that's the whole point of -f"
# '-f' = "force". Normally 'rm' complains if the file doesn't exist;
# '-f' silently does nothing instead, which is handy inside scripts.

rm -r nested_copy
echo "recursively removed nested_copy and everything inside it"
# '-r' on rm means "recursive" — delete a folder and its entire contents.
# (Combined with -f, 'rm -rf', it also skips any confirmation prompts —
# that combo is powerful and permanent, so always double-check the path.)

ln -s notes.txt notes_link.txt
# 'ln -s' creates a SYMBOLIC (soft) LINK — a lightweight pointer file
# that just refers to notes.txt, rather than a real copy of it.
ls -l notes_link.txt
# Notice the "->" arrow in the listing, showing what the link points to.
cat notes_link.txt
# Reading the link actually reads through to notes.txt's real content.

echo
echo "== 3. File Viewing & Text Processing =="

# 'less' is an interactive, scrollable file viewer — nicer than 'cat' for
# long files since it shows one screen at a time. We check it's installed
# first, since not every minimal system has it by default.
if command -v less >/dev/null 2>&1; then
  less notes.txt < /dev/null
  echo "(less just printed the file and exited immediately here, because" \
       "this script has no real keyboard attached — normally you'd scroll" \
       "with the arrow keys and press 'q' to quit)"
else
  echo "(less isn't installed in this environment — on your own machine," \
       "'less notes.txt' opens an interactive scrollable view; press 'q'" \
       "to quit)"
fi

printf "line one\nline two\nline three\nline four\nline five\n" > lines.txt
# 'printf' writes formatted text; '\n' means "new line". This builds a
# small 5-line file to demo head/tail on.

head -n 2 lines.txt
# 'head' shows the FIRST N lines of a file. '-n 2' means "just 2 lines".

tail -n 2 lines.txt
# 'tail' shows the LAST N lines of a file.

timeout 2 tail -f lines.txt || true
echo "(tail -f normally watches a file forever for new lines — e.g. a live" \
     "log file — so we used 'timeout 2' to force it to stop after 2 seconds" \
     "just for this demo)"
# 'tail -f' = "follow". It keeps the file open and prints new lines as
# they're added, live. Very common for watching log files in real time.

grep "three" lines.txt
# 'grep' searches a file for a word or pattern and prints matching lines.

wc lines.txt
# 'wc' = Word Count. Prints three numbers: line count, word count, and
# character count for the file.

printf "banana\napple\ncherry\napple\n" > fruits.txt
sort fruits.txt
# 'sort' prints a file's lines back out in alphabetical (or numeric) order.
# It doesn't change the original file unless you redirect the output.

printf "a\na\nb\nb\nb\nc\n" > dupes.txt
uniq dupes.txt
# 'uniq' collapses consecutive DUPLICATE lines into one. It only catches
# duplicates that are next to each other — which is why it's so often
# used right after 'sort'.

sort fruits.txt > fruits_sorted.txt
diff fruits.txt fruits_sorted.txt || true
echo "(diff exits with a 'not equal' status when files differ — that's" \
     "expected here, not a real error, so we ignore it with '|| true')"
# 'diff' compares two files line by line and prints exactly what's
# different between them (lines with '<' are only in the first file,
# lines with '>' are only in the second).

echo
echo "== 4. System Info, Processes & Monitoring =="

uname -a
# Shows kernel name, version, and architecture — general system info.
whoami
# Prints the username you're currently logged in as.

ps aux | head -n 5
echo "(showing just the first 5 lines — the real process list is usually" \
     "much longer)"
# 'ps aux' = a snapshot of every process currently running on the system.

top -b -n 1 | head -n 10
echo "(top normally redraws live, forever — '-b -n 1' takes a single" \
     "snapshot so this demo doesn't hang; the live version is what you'd" \
     "normally run, and htop is a friendlier interactive alternative if" \
     "it's installed)"
# 'top' is an interactive, live-updating view of CPU/memory usage per process.

sleep 100 &
BG_PID=$!
echo "started a background 'sleep' process with PID $BG_PID"
# '&' runs the command in the BACKGROUND so the script can keep going.
# '$!' captures the Process ID (PID) of that background command.
kill "$BG_PID"
echo "sent a normal kill signal to PID $BG_PID, asking it to stop"
# 'kill <PID>' asks a process to shut down (politely, by default).

sleep 100 &
BG_PID2=$!
kill -9 "$BG_PID2"
echo "force-killed PID $BG_PID2 with kill -9"
# 'kill -9' is a forceful, unconditional kill — used when a process
# ignores a normal 'kill' and won't respond.

df -h
# 'df -h' = Disk Free, human-readable — shows space used/available on
# every mounted drive (in MB/GB instead of raw bytes).
du -sh .
# 'du -sh .' = Disk Usage, summarized, human-readable, for THIS folder.
free -h 2>/dev/null || echo "(free -h isn't available on every system — e.g. macOS doesn't have it)"
# 'free -h' shows total/used/available RAM.

echo
echo "== 5. Permissions, Ownership & Users =="

chmod +x notes.txt
ls -l notes.txt
# 'chmod +x' adds execute permission. The permissions column in 'ls -l'
# (e.g. "-rwxr--r--") shows the change.

touch demo_script.sh
chmod 755 demo_script.sh
ls -l demo_script.sh
echo "(755 is permissions written as numbers: the owner gets 7 = read+write+execute," \
     "everyone else gets 5 = read+execute)"
# 'chmod' also accepts numeric "modes" like 755, instead of +x/-w symbols.

chown "$(whoami)":"$(id -gn)" notes.txt
ls -l notes.txt
echo "(this just reassigns the file to your own current user and group," \
     "which always works — changing a file to a DIFFERENT user normally" \
     "needs sudo)"
# 'chown user:group file' changes who owns a file and which group it
# belongs to (shown as the 3rd and 4th columns in 'ls -l').

echo "(sudo and 'su' are intentionally not run here — sudo needs admin" \
     "rights and a password, and su switches your whole login session to" \
     "another user. For reference, the syntax looks like:)"
echo "    sudo apt update        # run one command with admin privileges"
echo "    su - anotherusername   # switch to another user's login session"

echo
echo "== 6. Search, Help & Redirection =="

find . -name "*.txt"
# 'find' searches for files. '.' = start here, '-name "*.txt"' = only
# files ending in .txt (the '*' is a wildcard for "anything").

which bash
which python3 || echo "(python3 not found on this system)"
# 'which' prints the full path to the program that a command name refers to.

if command -v man >/dev/null 2>&1; then
  man ls | head -n 5
else
  echo "(man isn't installed in this environment — on your own machine," \
       "'man ls' opens the full manual page for the ls command)"
fi
# 'man <command>' opens that command's official manual/reference page.

echo "Appended line" >> notes.txt
# '>>' appends to a file (adds to the end) instead of overwriting it.
cat notes.txt

ls | grep notes
# '|' is a PIPE: it feeds the OUTPUT of 'ls' as INPUT into 'grep notes',
# so only filenames containing "notes" are shown.

echo
echo "== Cleanup =="
cd ..
rm -rf demo_sandbox
echo "Demo complete."
