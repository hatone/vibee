var CHANNEL_TOP, NAME_TOP, WIDTH, channelField, logoView, nameField, setButton, tab1, tabGroup, win1;

Titanium.UI.setBackgroundColor('#fff');

tabGroup = Ti.UI.createTabGroup();

win1 = Ti.UI.createWindow({
  title: 'vibee',
  backgroundColor: '#fff'
});

tab1 = Ti.UI.createTab({
  window: win1
});

tabGroup.addTab(tab1);

win1.tabBarHidden = true;

setButton = Ti.UI.createButton({
  title: 'Start',
  height: 100,
  width: 400
});

setButton.addEventListener('click', function(e) {
  var connectWindow;
  connectWindow = Ti.UI.createWindow({
    title: 'Sleeping',
    url: 'connect.js'
  });
  Ti.App.userName = nameField.value;
  Ti.App.channelName = channelField.value;
  Ti.App.Properties.setString('userName', nameField.value);
  Ti.App.Properties.setString('channelName', channelField.value);
  if (nameField.value) {
    return tab1.open(connectWindow);
  }
});

logoView = Ti.UI.createImageView({
  image: "images/logotest.png",
  top: 10
});

NAME_TOP = 200;

CHANNEL_TOP = 300;

WIDTH = 400;

nameField = Ti.UI.createTextField({
  top: NAME_TOP,
  width: WIDTH,
  height: 100,
  hintText: 'なまえ',
  borderStyle: Titanium.UI.INPUT_BORDERSTYLE_BEZEL,
  value: Ti.App.Properties.getString('userName')
});

channelField = Ti.UI.createTextField({
  top: CHANNEL_TOP,
  width: WIDTH,
  height: 100,
  hintText: 'あいことば',
  borderStyle: Ti.UI.INPUT_BORDERSTYLE_ROUNDER,
  value: Ti.App.Properties.getString('channelName')
});

win1.add(logoView);

win1.add(setButton);

win1.add(nameField);

win1.add(channelField);

tabGroup.open();
