### Update your path

You can update your PATH variable for the current session only at the command line,
as shown in [Clone the Flutter repo](./#clone-the-repo). You'll probably want to 
update this variable permanently, so you can run `flutter` commands in any terminal session.

1. Add Flutter to your PATH environment variable by opening 
**Control Panel>System and Security>System>Advanced system settings>Environment Variables...**
1. Modify the `PATH` system variable to add the full path to the `flutter\bin` directory.
   For example, `C:\flutter\bin`.

   If you don't have admin access to your machine, open **Control Panel>User Accounts>User Accounts>Change my environment variables**
   and add a `PATH` user variable with the path to `flutter\bin` as its value. 

1. Open a new PowerShell or Cmd command prompt window and verify that the `flutter\bin` 
directory is now in your PATH by running the following at the Cmd prompt:
```
> echo %PATH%
```
or in PowerShell:
```
> echo $Env:PATH
```

