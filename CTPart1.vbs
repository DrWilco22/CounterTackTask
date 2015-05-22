Set wShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("Shell.Application")
Set objNetwork = CreateObject("wScript.Network")
cName = objNetwork.ComputerName

'Prompts user for .zip
Set oExec=wShell.Exec("mshta.exe ""about:<input type=file id=FILE><script>FILE.click();new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);close();resizeTo(0,0);</script>""")
ZipFile = oExec.StdOut.ReadLine
Parent = fso.GetParentFolderName(ZipFile)

'Creates .txt file for times
If fso.FileExists(Parent & "\times.txt") Then
	fso.DeleteFile(Parent & "\times.txt")
End If
Set a = fso.CreateTextFile(Parent & "\times.txt")
a.WriteLine("ITER" & vbTab & "BOOT" & vbTab & "EXT" & vbTab & "COPY" & vbTab & "DEL")
a.Close

'Creates temporary file to run after reboot
Set b = fso.CreateTextFile("C:\Users\" & cName & "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\tempfile.vbs")
b.WriteLine("Set wShell = CreateObject(""WScript.Shell"")")
b.WriteLine("wShell.Run ""cscript " & Parent & "\CTPart2.vbs " & ZipFile & " 1 " & Timer() & """")
b.Close

'Reboots
wShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
