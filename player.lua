 local wx = require("wx")
 require("COMPORT")


stx = string.char( 0x7E)
ver = string.char( 0xFF)
etx = string.char( 0xEF)
siz = string.char( 0x06)
nll = string.char( 0x00)

send = { stx, ver, siz, nll, nll, nll, nll, nll, nll, etx };
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

function DEC_HEX(IN)
--	local hx ="0123456789ABCDEF"
--	local t0 = t % 16
--	local t1 = math.floor( t / 16 )
--string.sub( hx,D,D)
	return string.format("%x", IN )
end -- DEC_HEX


function getRply(
)
	local rd_len = 1
	local timeout = 4000
	local rply

	for i = 1, #recv, 1 do
		err, rply,  size = pHOST:read( rd_len, timeout )
		recv[i] = rply
	end -- while
end -- getRply

function get_checksum (
)
	local sum = 0
	for i = 2, 7, 1 do
		sum = sum + string.byte( send[i] )
	end -- for
print(-sum )
print( string.format("%x", -sum ) )
end -- get_checksum 

function mp3_next (
)
--	mp3_send_cmd (0x01);
end

function mp3_prev (
)
--	mp3_send_cmd (0x02);
end


--mp3_play_physical (uint16_t num) {
--	mp3_send_cmd (0x03, num);
--}


function SendCommand(
)
	get_checksum()
	for i = 1, 10, 1 do
		sendCOM_HOST( send[i])
	end
end -- SendCommand

-- Handle the button event

function On1Track(event)
	print ("first track ")
	openCOM_HOST()
	send[4] = string.char( 0x03) -- cmd

	send[5] = string.char( 0x00) -- feedback

	send[6] = string.char( 0x00) -- para1
	send[7] = string.char( 0x01) -- para2

	send[8] = string.char( 0xFE) -- chSm1
	send[9] = string.char( 0xF7) -- chSm0

	SendCommand()

	getRply()

	closeCOM_HOST()
	local t = string.byte( recv[4] )
	local t3 = DEC_HEX( t )
	t = string.byte( recv[7] )
	local t6 = DEC_HEX( t )
	print( t3 )
	print( t6 )
end -- On1Track(event)
