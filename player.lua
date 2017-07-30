 local wx = require("wx")
 require("COMPORT")


function panelPlayer()

    panelMP3 = wx.wxPanel(notebook, wx.wxID_ANY)
    sizerBC = wx.wxBoxSizer(wx.wxVERTICAL)

	btnSize = wx.wxSize( 60, 30)

    ID_PN_BUSY			= 4001
    ID_BUTTON_BUSY		= 4034

-- ----
	pnBUSY = wx.wxStaticBox(panelMP3, ID_PN_BUSY, "???", wx.wxPoint( 10, 10), wx.wxSize( 320, 50) )	

    btnBUSY = wx.wxButton( pnBUSY, ID_BUTTON_BUSY, "first track",  wx.wxPoint( 15, 10), btnSize )
    frame:Connect( ID_BUTTON_BUSY, wx.wxEVT_COMMAND_BUTTON_CLICKED, On1Track)	
	
    notebook:AddPage(panelMP3, "player")

end -- panelPHONE

-- Handle the button event

function On1Track(event)
	print ("first track ")
	openCOM_HOST()
	sendCOM_HOST( string.char( 0x7E))
	sendCOM_HOST( string.char( 0xFF))
	sendCOM_HOST( string.char( 0x06))
	sendCOM_HOST( string.char( 0x03))
	sendCOM_HOST( string.char( 0x00))
	sendCOM_HOST( string.char( 0x00))
	sendCOM_HOST( string.char( 0x01))
	sendCOM_HOST( string.char( 0xFF))
	sendCOM_HOST( string.char( 0xE6))
	sendCOM_HOST( string.char( 0xEF))

--	local rpl = getRply()
--	print ("?"..rpl)
--	local rpl = getRply()
--	print ("?"..rpl)
	closeCOM_HOST()
end -- OnBUSY(event)
