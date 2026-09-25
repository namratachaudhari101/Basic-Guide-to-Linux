#!/bin/bash
# "Shebang" line — tells the computer to run this file using Bash.

set -e
# Stop the script right away if any command below fails, instead of
# continuing on and possibly making a mess.

mkdir -p python-demo
# Create a new folder called "python-demo" to hold this mini project.
# '-p' means "it's fine if this folder already exists".

cd python-demo
# Move into that folder — everything below happens inside python-demo/.

python3 -m venv .venv
# Creates a "virtual environment": an isolated, self-contained copy of
# Python just for this one project, stored in a hidden folder ".venv".
# This keeps this project's packages separate from every other project
# on your computer, so they can't clash with each other.

source .venv/bin/activate
# "Activates" the virtual environment we just created. After this line,
# every 'python' or 'pip' command in this script uses THIS project's
# own isolated Python, instead of the one installed system-wide.

pip install --quiet pytest
# 'pip' installs Python packages (libraries). This installs "pytest",
# a popular tool for writing and running tests.
# '--quiet' just hides pip's normal step-by-step progress messages.

cat > test_example.py << 'EOF'
def test_addition():
    assert 1 + 1 == 2

def test_string_upper():
    assert "wsl".upper() == "WSL"
EOF
# The block above creates a new file, test_example.py, and writes Python
# code into it. The '<< 'EOF' ... EOF' pattern is called a "heredoc" —
# everything between the two EOF markers becomes the file's contents.
# The file defines two tiny tests:
#   - test_addition checks that 1 + 1 really equals 2
#   - test_string_upper checks that making "wsl" uppercase gives "WSL"
# ('assert' means "this must be true, or the test fails".)

pytest -q
# Runs pytest, which automatically finds and runs every function in
# test_example.py that starts with "test_". '-q' = "quiet", meaning a
# short summary instead of a long report — if both tests pass you'll
# see something like "2 passed".

deactivate
# Exits the virtual environment, switching back to your normal,
# system-wide Python.

echo "Workflow complete: see python-demo/ for the generated project."
# Prints a friendly confirmation message so you know it finished.
