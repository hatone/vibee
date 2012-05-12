sound = []
for i in [0...9]
  sound.push Ti.Media.createSound
    url: 'sounds/' + i + '.mp3'
 
playSound = (num)->
  sound[num].play()


win = Titanium.UI.createWindow
  title:'connect window'
  backgroundColor: '#ECEAE4'
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
    Ti.UI.currentWindow.title = commands[2]
    if commands[3] == "VIBRATE"
      signs = commands[4].split("|")
      signs.unshift(0)
      Ti.Media.vibrate(signs)
    else
      playSound(commands[4])

  
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


#textarea = Titanium.UI.createTextArea
#  value:Ti.App.userName
#win.add textarea
sendSound = (num)->
#playSound(num)
  data = Ti.createBuffer
    value:"VIBEE " + Ti.App.channelName + " " + Ti.App.userName + " SOUND " + num + " P"
  
  bytesWritten = socket.write data
 

#tap0
tap0 = Ti.UI.createImageView
  top:'0%'
  left:'0%'
  width:'33%'
  height:'33%'
tap0.addEventListener 'click', (e)->
  sendSound(0)
win.add(tap0)

#tap1
tap1 = Ti.UI.createImageView
  top:'0%'
  left:'33%'
  width:'33%'
  height:'33%'
tap1.addEventListener 'click', (e)->
  sendSound(1)
win.add(tap1)

#tap2
tap2 = Ti.UI.createImageView
  top:'0%'
  left:'66%'
  width:'33%'
  height:'33%'
tap2.addEventListener 'click', (e)->
  sendSound(2)
win.add(tap2)

#tap3
tap3 = Ti.UI.createImageView
  top:'33%'
  left:'0%'
  width:'33%'
  height:'33%'
tap3.addEventListener 'click', (e)->
  sendSound(3)
win.add(tap3)

#tap4
tap4 = Ti.UI.createImageView
  top:'33%'
  left:'33%'
  width:'33%'
  height:'33%'
tap4.addEventListener 'click', (e)->
  sendSound(4)
win.add(tap4)

#tap5
tap5 = Ti.UI.createImageView
  top:'33%'
  left:'66%'
  width:'33%'
  height:'33%'
tap5.addEventListener 'click', (e)->
  sendSound(5)
win.add(tap5)

#tap6
tap6 = Ti.UI.createImageView
  top:'66%'
  left:'0%'
  width:'33%'
  height:'33%'
tap6.addEventListener 'click', (e)->
  sendSound(6)
win.add(tap6)

#tap7
tap7 = Ti.UI.createImageView
  top:'66%'
  left:'33%'
  width:'33%'
  height:'33%'
tap7.addEventListener 'click', (e)->
  sendSound(7)
win.add(tap7)

#tap8
tap8 = Ti.UI.createImageView
  top:'66%'
  left:'66%'
  width:'33%'
  height:'33%'
tap8.addEventListener 'click', (e)->
  sendSound(8)
win.add(tap8)


win.open()


