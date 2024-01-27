# Windows-Utility
Description:
This batch script is designed to provide a convenient way to perform various system maintenance tasks on a Windows computer. The script is intended to be run with administrator privileges and offers several options for cleaning temporary files, activating the Ultimate Performance Power Plan, and managing specific system folders.

Options:

    Clean user's temporary folder: Removes files from the user's temporary folder (C:\Users\%USERNAME%\AppData\Local\Temp).
    Clean Windows Prefetch folder: Clears the Windows Prefetch folder (C:\Windows\Prefetch).
    Clean Windows temporary folder: Cleans the Windows temporary folder (C:\Windows\Temp).
    Flush DNS (Network with name "Ethernet"): Flushes the DNS cache, deletes the ARP cache, and resets Winsock. It also resets IPv4 DNS to DHCP for all Ethernet interfaces.
    Activate Ultimate Performance Power Plan: Activates the "Ultimate Performance" Power Plan using the specified GUID (e9a42b02-d5df-448d-aa00-03f14749eb61).
    Empty Recycle Bin: Permanently deletes all files in the Recycle Bin.
    Empty Download folder: Clears all files in the user's Downloads folder (C:\Users\%USERNAME%\Downloads).
    Exit: Exits the program.

Usage:

    Run the script with administrator privileges.
    Choose an option by entering the corresponding number.

Note:

    Exercise caution when using the "Empty Recycle Bin" option, as it permanently deletes all files in the Recycle Bin.
    Always ensure that you have a backup of important files before using any cleaning option.
