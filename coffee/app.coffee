Ti.App.userName = Ti.App.Properties.getString('userName');
Ti.App.channelName = Ti.App.Properties.getString('userName');

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
  dialog.setMessage('message')
  dialog.show()
  connectWindow = Ti.UI.createWindow
    title: 'Sleeping'
    url: 'connect.js'
  tab1.open(connectWindow)

win1.add(setButton)

tabGroup.open()
