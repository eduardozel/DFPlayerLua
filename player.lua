 local wx = require("wx")
 require("COMPORT")


stx = string.char( 0x7E)
ver = string.char( 0xFF)
etx = string.char( 0xEF)

send = { stx, ver, '', '', '', '', '', '', '', etx };
recv = { '1', '2', '3', '4', '5', '6', '7', '8', '8', '10'};

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

function getRply(
)
	local rd_len = 1
	local timeout = 400

	for i = 1, #recv, 1 do
		err, rply,  size = pHOST:read( rd_len, timeout )
		recv[i] = rply
	end -- while
end -- getRply

function DEC_HEX(IN)
--	local hx ="0123456789ABCDEF"
--	local t0 = t % 16
--	local t1 = math.floor( t / 16 )
--string.sub( hx,D,D)
	return string.format("%x", IN )
end -- DEC_HEX

function get_checksum (
)
	local sum = 0
	for i = 2, 6, 1 do
		sum = sum + send[i]
	end
end


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

	getRply()
	closeCOM_HOST()
	local t = string.byte( recv[4] )
	local t3 = DEC_HEX( t )
	t = string.byte( recv[7] )
	local t6 = DEC_HEX( t )
	print( t3 )
	print( t6 )
end -- On1Track(event)
