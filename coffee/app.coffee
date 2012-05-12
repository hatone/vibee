Ti.App.userName = 'demo-user'
Ti.App.channelName = 'demo'
Titanium.UI.setBackgroundColor('#fff'); 



tabGroup = Ti.UI.createTabGroup()
win1 = Ti.UI.createWindow
  title: 'vibee'
  backgroundColor:'#fff'

tab1 = Ti.UI.createTab 
  window: win1

tabGroup.addTab tab1 
win1.tabBarHidden = true

#setup Window
setButton = Ti.UI.createButton
  title: 'Start'
  height: 100
  width: 400
setButton.addEventListener 'click',(e)->
  dialog = Titanium.UI.createAlertDialog()
  dialog.setTitle('alett test')
  dialog.setMessage(nameField.value+""+ channelField.value)
  dialog.show()
  connectWindow = Ti.UI.createWindow
    title: 'Sleeping'
    url: 'connect.js'
  connectWindow.name = nameField.value
  connectWindow.channel = channelField.value
  tab1.open(connectWindow)

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


channelField = Ti.UI.createTextField
  top:CHANNEL_TOP
  width:WIDTH
  height:100
  hintText:'あいことば'
  borderStyle:Ti.UI.INPUT_BORDERSTYLE_ROUNDER


win1.add(setButton)
win1.add(nameField)
win1.add(channelField)
tabGroup.open()
