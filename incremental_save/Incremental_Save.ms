/*
Incremental Save
By: Alexander Hosking
Last Edited: January 4, 2013

--When the user presses the save key, save an incremental copy
to a save folder. If the old file exists, increment the files.
*/
format "Incremental Save, by Alexander Hosking © 2012-2013\nPlease contact Alexander@ahosking.com if you have any problems with this script. \n"

macroScript Incremental_Save category:"AHosking" tooltip:"Incremental Save" --Icon:#("Incremental_Save",2)
(
	if not getSaveRequired() then	--nothing needs to be saved!
	(
		messageBox "You have no changes to save.       "
	)
	else	--The file does need to be saved
	(
		if not doesFileExist(maxfilepath + getFileNameFile(maxfilename) + ".increment\\") then	--check to see if the incremental folder exists, if not, create it!
		(
			makeDir (maxfilepath + getFileNameFile(maxfilename) + ".increment\\")
		)
		else	--The folder exists, so save the file?
		(
			files = getFiles (maxfilepath + getFileNameFile(maxfilename) + ".increment\\" + getFileNameFile(maxfilename) + "_INC*.max")
			filecount = case  of
			(
				(files.count > 0 and files.count < 9): "00" +(files.count + 1) as string
				(files.count > 8 and files.count < 99):  "0" +(files.count + 1) as string
				(files.count > 98):  (files.count + 1) as string
				default: "001"
			)
			if not doesFileExist (maxfilepath + getFileNameFile(maxfilename) + ".increment\\" + getFileNameFile(maxfilename) + "_INC" + filecount + ".max") then
			(
				copyFile (maxfilepath + maxfilename) (maxfilepath + getFileNameFile(maxfilename) + ".increment\\" + getFileNameFile(maxfilename) + "_INC" + filecount + ".max")
				format "Increment saved to: %\n" (maxfilepath + getFileNameFile(maxfilename) + ".increment\\" + getFileNameFile(maxfilename) + "_INC" + filecount + ".max")
				if (saveMaxFile (maxfilepath + maxfilename) clearNeedSaveFlag:true) then
				(
					format "Working File saved to: %\n" (maxfilepath + maxfilename)
					setSaveRequired False
				)
			)
			else
			(
				--increment_saveFile = (maxfilepath + getFileNameFile(maxfilename) + ".increment\\" + uniqueName(getFileNameFile(maxfilename) + "_INC"))
				--copyFile (maxfilepath + maxfilename) uniqueName(increment_saveFile)
				copyFile (maxfilepath + maxfilename)  (maxfilepath + getFileNameFile(maxfilename) + ".increment\\" + getFileNameFile(maxfilename) + "_INC" + filecount + ".max")
				format "Increment saved to: %\n" (maxfilepath + getFileNameFile(maxfilename) + ".increment\\" + getFileNameFile(maxfilename) + "_INC" + filecount + ".max")
				if (saveMaxFile (maxfilepath + maxfilename) clearNeedSaveFlag:true) then
				(
					format "Working File saved to: %\n" (maxfilepath + maxfilename)
					setSaveRequired False
				)
			)
		)
	)
)