(
  	if ::form != undefined do try(form.close())catch()
  	local maxBC = (colorMan.getColor #background) * 255.0
  	fn maxHW = (dotNetObject "maxCustomControls.win32HandleWrapper" (dotNetObject "System.IntPtr" (windows.getMaxHWND())))	
  	fn defForm dnForm w: h: clr:maxBC = 
  	(
  		
  		dnForm.ShowInTaskbar = false ; dnForm.ClientSize = dotNetObject "System.Drawing.Size" w h
  		dnForm.FormBorderStyle = dnForm.FormBorderStyle.None
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
  				while (s.Tag).Opacity <= 0.7777 do ((s.Tag).Opacity += valUp ; valUp += 0.000000001) 
  			   if (s.Tag).Opacity == 0.8 do (s.Stop() ; s.Tag = undefined ; dotnet.removeAllEventHandlers s ; s.Dispose())
  			)		
  		)
  		dotnet.addEventHandler clock "Tick" clockTick ; clock.Start()
  	)	
  	form = dotNetObject "Form" ; defForm form w:400 h:200
  	lbl = dotNetObject "Label" ; defLabel lbl
  	dotNet.addEventHandler lbl "MouseUp" (fn closeForm s e = if e.Button == e.Button.Right do form.close())
  	form.Controls.Add(lbl) ; form.Show (maxHW()) ; fadeInForm form ; ok
  )