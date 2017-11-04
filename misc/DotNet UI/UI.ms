--This UI will create a transparent form that will display the AHOSKING.com logo in the bottom right corner of the viewport.

--create the form
form = dotNetObject "maxCustomControls.maxForm"

--Display the form!
form.show()

form.text = "Ahosking.com"
form.opacity = 0.5
logo = dotNetClass "system.Drawing.Image"

--Close
--form.close()






--Help function
fn formatProps dn=
(
	if classOf dn == dotNetObject or classof dn == dotNetClass then
	(
		clearListener()
		format "Properties:\n"
		showProperties dn
		format "\nMethods:\n"
		showMethods dn
		format "\nEvents:\n"
		showEvents dn
	)
	else
	(
		format "% is not a dotNetObject or a dotNetClass\n" dn
	)
)
--format the props to the listener
--formatProps form