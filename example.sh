#!/usr/bin/env bash

# Copyright (C) 2022 Daddie0
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
# SOFTWARE.



# Load the logging "library"
source ./log4bash.sh # Change this with the path for where you've put Log4Bash

DEBUG "Example Debug Message"
INFO "Wow this must be something that's still of some importance but is not a debug message"
NOTICE "This is almost like info but should only be used with significant conditions"
WARNING "Hey! You might wanna check this out. You run fine if you ignore it"
ERROR "Something messed up. We can still run without exiting you should seriously look into this though"
CRITICAL "Something is seriously messed up. We can still run but beware"
ALERT "Action must be taken immediately, exiting the script to prevent damage"
EMERGENCY "The system is unusable. Exiting the script"
