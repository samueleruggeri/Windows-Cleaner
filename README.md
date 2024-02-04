# Windows-Utility
This is a Windows batch script designed to perform various cleaning tasks on a Windows system. It provides a simple menu interface to choose from different cleaning options.

## Features

1. **Clean user's temporary folder**: Deletes all files and subfolders in the user's temporary folder (%temp%).
2. **Clean Windows Prefetch folder**: Deletes all files and subfolders in the Windows Prefetch folder (C:\Windows\Prefetch).
3. **Clean Windows temporary folder**: Deletes all files and subfolders in the Windows temporary folder (C:\Windows\Temp).
4. **Empty Recycle Bin**: Permanently deletes all files in the Recycle Bin.
5. **Empty Download folder**: Deletes all files and subfolders in the user's Downloads folder.
6. **Flush DNS Cache**: Flushes the DNS resolver cache.
7. **Activate Ultimate Performance Power Plan**: Activates the Ultimate Performance power plan if available.
8. **Restore Power Plan**: Restores the default power plan settings.
9. **Clear Microsoft Store Cache**: Clears the cache for the Microsoft Store.
10. **Clear Windows Update Cache**: Stops the Windows Update service, clears the Windows Update cache, and restarts the service.

## Usage

- Run the script with administrator privileges. If not run as administrator, it will attempt to elevate privileges.
- Select an option from the menu by entering the corresponding number.
- Follow the on-screen prompts to complete the selected action.
- After each action, there is a 5-second delay before returning to the main menu.

## Notes

- This script requires administrative privileges to perform some actions.
- Use caution when running scripts that delete files, as they cannot be recovered once deleted.
- Some options may require additional confirmation before execution.

## Notification

After exiting the program, a notification will be shown to confirm the program's completion.

## Compatibility

This script is designed to work on Windows systems.
