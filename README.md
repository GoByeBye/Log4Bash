# Log4Bash
[![stars](https://img.shields.io/github/stars/GoByeBye/Log4Bash?style=for-the-badge)](https://idiots.click)  ![GitHub followers](https://img.shields.io/github/followers/GoByeBye?style=for-the-badge) [![Codacy Badge](https://app.codacy.com/project/badge/Grade/15bb4020866445eea712c0060567fd6b)](https://www.codacy.com/gh/GoByeBye/Log4Bash/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=GoByeBye/Log4Bash&amp;utm_campaign=Badge_Grade)
![Log4Bash](log4bash.png) 


## Usage
```bash

# First off load Log4Bash into your script using 
source ./log4bash.sh # Replace this with the path to log4bash.sh
                     # This one assumes Log4Bash is located in the same directory
                     # As where you are running the script from
                     
                     
 
 
# Log using these functions
DEBUG "Example Debug Message"

INFO "Wow this must be something that's still of some importance but is not a debug message"

NOTICE "This is almost like info but should only be used with significant conditions"

WARNING "Hey! You might wanna check this out. You run fine if you ignore it"

ERROR "Something messed up. We can still run without exiting you should seriously look into this though"

CRITICAL "Something is seriously messed up. We can still run but beware"

ALERT "Action must be taken immediately, exiting the script to prevent damage"

EMERGENCY "The system is unusable. Exiting the script"
```

Example output
[![example](https://i.imgur.com/9togrqJ.png)](https://i.imgur.com/9togrqJ.png)
