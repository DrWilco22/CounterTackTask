Set wShell = wScript.CreateObject("wScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("Shell.Application")
Set objNetwork = CreateObject("wScript.Network")
cName = objNetwork.UserName

Set Args = wScript.Arguments
ZipFile = Args(0)
Parent = fso.GetParentFolderName(ZipFile)
ExtractTo = Parent & "\files"
set a = fso.OpenTextFile(Parent & "\times.txt", 8)
CopyTo = Parent & "\filesCopy" & Args(1)

'Get reboot time
StartTime = Args(2)
EndTime = Timer()
RebootTime = FormatNumber(Endtime - StartTime, 2)
a.Write(Args(1) & vbTab & RebootTime & vbTab)

'Extracts .zip
StartTime = Timer()
fso.CreateFolder(ExtractTo)
Set FilesInZip = objShell.NameSpace(ZipFile).items
objShell.Namespace(ExtractTo).CopyHere(FilesInZip)
EndTime = Timer()
ExtractTime = FormatNumber(EndTime - StartTime, 4)
a.Write(ExtractTime & vbTab)

'Copies folder
fso.CreateFolder(CopyTo)
StartTime = Timer()
fso.CopyFolder ExtractTo, CopyTo
EndTime = Timer()
CopyTime = FormatNumber(EndTime - StartTime, 4)
a.Write(CopyTime & vbTab)

'Deletes folder
StartTime = Timer()
fso.DeleteFolder(ExtractTo)
EndTime = Timer()
DelTime = FormatNumber(EndTime - StartTime, 4)
a.Write(DelTime & vbNewLine)

'Deletes temporary file
fso.DeleteFile("C:\Users\" & cName & "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\tempfile.vbs")

'Runs 5 times
If Args(1) < 5 Then
	Set b = fso.CreateTextFile("C:\Users\" & cName & "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\tempfile.vbs")
	b.WriteLine("Set wShell = CreateObject(""WScript.Shell"")")
	b.WriteLine("wShell.Run ""cscript " & Parent & "\CTPart2.vbs " & ZipFile & " " & Args(1) + 1 & " " & Timer() & """")
	b.Close
	wShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
End If

a.Close
