 require("player")


 local wx = require("wx")


    frame = wx.wxFrame( wx.NULL, wx.wxID_ANY, "Test DF MP3 player"
                                 , wx.wxDefaultPosition, wx.wxSize( 500, 470)
                                 , wx.wxDEFAULT_FRAME_STYLE)

    frame:Show(true)
    frame:CreateStatusBar(1)
    notebook = wx.wxNotebook(frame, wx.wxID_ANY,
                                   wx.wxDefaultPosition, wx.wxDefaultSize)
                                   --wx.wxNB_BOTTOM)

    panelPlayer()


wx.wxGetApp():MainLoop()
