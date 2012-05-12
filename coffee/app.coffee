Titanium.UI.setBackgroundColor('#ECEAE4'); 

tabGroup = Ti.UI.createTabGroup()
win1 = Ti.UI.createWindow
  title: 'vibee'
  backgroundColor:'#ECEAE4'

win1.orientationModes =[
  Titanium.UI.PORTRAIT
  ]

tab1 = Ti.UI.createTab 
  window: win1

tabGroup.addTab tab1 
win1.tabBarHidden = true

#setup Window
setButton = Ti.UI.createButton
  title: 'Start'
  top:500
  height: 100
  width: 400
setButton.addEventListener 'click',(e)->
  connectWindow = Ti.UI.createWindow
    title: 'Sleeping'
    url: 'connect.js'
  connectWindow.orientationModes =[
    Titanium.UI.PORTRAIT
  ]
  Ti.App.userName = nameField.value
  Ti.App.channelName = channelField.value
  Ti.App.Properties.setString('userName', nameField.value);
  Ti.App.Properties.setString('channelName', channelField.value);
  if nameField.value
    tab1.open(connectWindow)

#image
logoView = Ti.UI.createImageView
  image:"images/logo.png"
  top:30
  height:150
  width:450

#sound
s = Ti.Media.createSound
  url: "sounds/0.wav"
s.play()
  
#setup imput
NAME_TOP = 200 
CHANNEL_TOP = 300 
WIDTH = 400 

nameField = Ti.UI.createTextField
  top:NAME_TOP
  width:WIDTH
  height:100
  hintText:'なまえ'
  borderStyle:Titanium.UI.INPUT_BORDERSTYLE_BEZEL
  value:Ti.App.Properties.getString('userName');

channelField = Ti.UI.createTextField
  top:CHANNEL_TOP
  width:WIDTH
  height:100
  hintText:'あいことば'
  borderStyle:Ti.UI.INPUT_BORDERSTYLE_ROUNDER
  value:Ti.App.Properties.getString('channelName');

win1.add(logoView)
win1.add(setButton)
win1.add(nameField)
win1.add(channelField)
tabGroup.open()
