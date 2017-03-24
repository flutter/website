### Update your path

You can update your PATH variable for the current session only, at the command line,
or update it permanently for all terminal sessions by editing a file. 

1. Add Flutter to your PATH environment variable by running:
   ```
   $ export PATH=`pwd`/flutter/bin:$PATH
   ```
   The above command sets your PATH variable temporarily, for the current terminal window.
   The steps for modifying this variable permanently for all terminal sessions are machine-
   specific. Typically you add a line to a file that is executed whenever you open 
   a new window:

   ```
   export PATH=$HOME/flutter/bin:$PATH
   ```
   and then run the `source <filename>` command to refresh the window. For example, 
   edit (or create) and source `$HOME/.bash_profile`.

1. Verify that the `flutter/bin` directory is now in your PATH by running:
   ```
   $ echo $PATH
   ```
