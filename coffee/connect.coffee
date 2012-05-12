
win = Titanium.UI.createWindow
  title:'connect window'
  backgroundColor: '#fff'

textarea = Titanium.UI.createTextArea
  value:Ti.App.userName
win.add textarea
win.open()

socket
readBuffer = Titanium.createBuffer
  length:1024

readCallback = (e) ->
  if e.bytesProcessed == -1
    textarea.value += ">>Recieved socket closed \n"
    socket.close()
    return

  str = Ti.Codec.decodeString
    source:readBuffer
    length:e.bytesProcessed

  textarea.value = e.bytesProcessed + "> " + str + "\n" + textarea.value
  textarea.value = Ti.App.channelName + "-cname\n" + textarea.value
 
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
    textarea.value += ">> Connected to host" + socket.host + "\n"

    data = Ti.createBuffer
      value:"VIBEE " + Ti.App.channelName + " " + Ti.App.userName + " VIBRATE 1000|100|1000|100"
    
    #bytesWritten = socket.write data

  closed: (e) ->
    textarea.value += ">> Socket closed"

socket.connect()

Ti.Gesture.addEventListener "shake", (e) ->
  #textarea.value = parseInt(e.timestamp - (new Date)) + "\n" + textarea.value 
  data = Ti.createBuffer
    value:"VIBEE " + Ti.App.channelName + " " + Ti.App.userName + " VIBRATE 100|10|100|10|100|10|100|10"
    
  bytesWritten = socket.write data
 
