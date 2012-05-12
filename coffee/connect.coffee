
win = Titanium.UI.createWindow
  title:'connect window'
  backgroundColor: '#fff'

#textarea = Titanium.UI.createTextArea
#  value:Ti.App.userName
#win.add textarea

#tap1
tap1 = Ti.UI.createImageView
  top:'0%'
  left:'0%'
  width:'33%'
  height:'33%'
tap1.addEventListener 'click', (e)->
  dialog = Titanium.UI.createAlertDialog()
  dialog.setTitle('Tap1')
  dialog.setMessage('Tap1')
  dialog.show()
win.add(tap1)
#tap2
tap2 = Ti.UI.createImageView
  top:'0%'
  left:'33%'
  width:'33%'
  height:'33%'
tap2.addEventListener 'click', (e)->
  dialog = Titanium.UI.createAlertDialog()
  dialog.setTitle('Tap2')
  dialog.setMessage('Tap2');
  dialog.show();
win.add(tap2)

#tap3
tap3 = Ti.UI.createImageView
  top:'0%'
  left:'66%'
  width:'33%'
  height:'33%'
tap3.addEventListener 'click', (e)->
  dialog = Titanium.UI.createAlertDialog();
  dialog.setTitle('Tap3');
  dialog.setMessage('Tap3'); 
  dialog.show();
win.add(tap3)


win.open()

socket
readBuffer = Titanium.createBuffer
  length:1024

readCallback = (e) ->
  if e.bytesProcessed == -1
#    textarea.value += ">>Recieved socket closed \n"
    socket.close()
    return

  str = Ti.Codec.decodeString
    source:readBuffer
    length:e.bytesProcessed

#  textarea.value = e.bytesProcessed + "> " + str + "\n" + textarea.value
#  textarea.value = Ti.App.channelName + "-cname\n" + textarea.value
 
  #----
  str.replace("\n","")
  commands = str.split(" ")
  if commands.length > 4 && commands[0] == 'VIBEE' && commands[1] == Ti.App.channelName
    if commands[3] == "VIBRATE"
      signs = commands[4].split("|")
      signs.unshift(0)
      Ti.Media.vibrate(signs)
  
  Ti.Stream.read socket,readBuffer,readCallback

socket = Ti.Network.Socket.createTCP
  host:'echo.picora.us'
  port:3535
  connected: (e) ->
    Ti.Stream.read socket,readBuffer,readCallback
#    textarea.value += ">> Connected to host" + socket.host + "\n"

    data = Ti.createBuffer
      value:"VIBEE " + Ti.App.channelName + " " + Ti.App.userName + " VIBRATE 1000|100|1000|100"
    
    #bytesWritten = socket.write data

  closed: (e) ->
#    textarea.value += ">> Socket closed"

socket.connect()

Ti.Gesture.addEventListener "shake", (e) ->
  #textarea.value = parseInt(e.timestamp - (new Date)) + "\n" + textarea.value 
  data = Ti.createBuffer
    value:"VIBEE " + Ti.App.channelName + " " + Ti.App.userName + " VIBRATE 100|10|100|10|100|10|100|10"
    
  bytesWritten = socket.write data
 
