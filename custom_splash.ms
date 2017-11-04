/*
--File Name: Custom_Splash.ms
--Created: August 8, 2014
--Last Updated: August 8, 2014
--Created by: Alexander Hosking

This script will copy all defined splash screens to the local machine (if they do not exist)
It will then alternate the splash screen at random on each startup
*/
try
(
	splashImages = getfiles @"\\SERVER\\Max_Splash\*.bmp"
	if not doesfileexist (scriptsPath + "Custom_Splash") then --directory does not exist
	(
		makedir (scriptsPath + "Custom_Splash")
		for i in splashImages do
		(
			copyfile i (scriptsPath + "Custom_Splash\\" + (filenameFromPath i))
		)
	)
	SplashImage = splashImages[random 1 splashImages.count]
	deleteFile "$Max//splash.bmp"
	copyFile SplashImage "$Max//splash.bmp"
)
catch()
