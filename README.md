# Robert Cohen
# 05.21.2015
# CounterTackTask
Here are the two scripts I wrote for the CounterTack challenge.
Run CTPart1.vbs to start the program. CT2Part2.vbs will be called on by the first part.

For the scripts to work, they must both be located in the same directory.
Additionally, the .zip file must be located in the same directory as the scripts.
Perhaps the above two lines can be generalized more with additional selection boxes,
however it will make the program clunky.

The first script is basically the introduction. 
It specifies the .zip file and grabs its directory and creates the .txt file with times.
Additionally, it creates a dummy file in the startup directory. This temp file will
run after the computer reboots. It will be updated every iteration.
The temp file is written to relay the .zip directory, iteration number, and time
so the second file can use the information acquired from the first script even after a reboot.

The second script does most of the work.
It first calculates reboot time by using the time passed from the dummy script and the current time.
Then it extracts the .zip file selected during the first script.
Then it copies the directory to filesCopy# where # is the iteration.
Then it deletes the original directory.
During each of these steps it calculates the time it took and updates the times.txt file.
Next it deletes the temp file we created and checks the iteration number.
Lastly, it creates another temp file with the updated iteration number and time and reboots.
On the last iteration, the temp file is deleted and not recreated and the computer does not reboot.
The times.txt file will be in the directory you ran the scripts from.

Overall, the most challenging aspect was carrying information over after a reboot.
The rest of the program felt pretty standard and straight forward.
However, it was not trivial to 
  1) continue a script after the computer reboots and
  2) relay information from before the reboot to after.
The work around I found may not be the most efficient way but it works quite well.
