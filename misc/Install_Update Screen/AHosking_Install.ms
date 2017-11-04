/*------------------------------------------------------------
--------------------------------------------------------------
--Ahosking.com--
--Created on: September 27, 2013
--Created By: Alexander Hosking
--Created For: Alexander Hosking
--Version: 0.0.1
--------------------------------------------------------------
Goal:
A fade-in window
-Block for logo image
-Author information
-Install Button
-Check for updates
*/------------------------------------------------------------
(
  	if ::form != undefined do try(form.close())catch()
  	local maxBC = (colorMan.getColor #background) * 255.0
  	fn maxHW = (dotNetObject "maxCustomControls.win32HandleWrapper" (dotNetObject "System.IntPtr" (windows.getMaxHWND())))	
  	fn defForm dnForm w: h: clr:maxBC = 
  	(
  		
  		dnForm.ShowInTaskbar = false ; dnForm.ClientSize = dotNetObject "System.Drawing.Size" w h
		dnForm.text = "AHosking Installer"
  		dnForm.FormBorderStyle = dnForm.FormBorderStyle.FixedToolWindow
  		dnForm.StartPosition =  dnForm.StartPosition.CenterScreen
  		dnForm.BackColor = (dotNetClass "System.Drawing.Color").FromArgb clr.x clr.y clr.z
  		dnForm.AllowTransparency = true ; dnForm.Opacity = 0.0
  	)
  	fn defLabel dnLabel clr:maxBC =
  	(
  		local maxFC = (colorMan.getColor #Text) * 255.0			
  		dnLabel.BackColor = (dotNetClass "System.Drawing.Color").FromArgb clr.x clr.y clr.z
  		dnLabel.ForeColor = (dotNetClass "System.Drawing.Color").FromArgb maxFC.x maxFC.y maxFC.z
  		dnLabel.Font = (dotNetObject "System.Drawing.Font" "Tahoma" 20 ((dotNetClass "System.Drawing.FontStyle").bold)) 
  		dnLabel.TextAlign = dnLabel.TextAlign.MiddleCenter ; dnLabel.Text = "3ds max 2015\nBy Alexander Hosking" ; dnLabel.Dock = dnLabel.Dock.Fill
  	)
  	fn fadeInForm form =
  	(
  		local clock = dotNetObject "Timer" ; clock.Interval = 50 ; clock.Tag = form
  		fn clockTick s e =
  		(
  			local valUp = 0.0001
  			if (s.Tag).Opacity != 1.0 do
  			(
  				while (s.Tag).Opacity <= 0.999 do ((s.Tag).Opacity += valUp ; valUp += 0.000000001) 
  			   if (s.Tag).Opacity == 1.0 do (s.Stop() ; s.Tag = undefined ; dotnet.removeAllEventHandlers s ; s.Dispose())
  			)		
  		)
  		dotnet.addEventHandler clock "Tick" clockTick ; clock.Start()
  	)	
  	form = dotNetObject "Form"
	defForm form w:400 h:200
  	lbl = dotNetObject "Label"
	defLabel lbl
  	dotNet.addEventHandler lbl "MouseUp" (fn closeForm s e = if e.Button == e.Button.Right do form.close())
  	form.Controls.Add(lbl) ; form.Show (maxHW()) ; fadeInForm form ; ok
  )