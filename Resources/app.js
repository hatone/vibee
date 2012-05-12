var CHANNEL_TOP, NAME_TOP, WIDTH, channelField, nameField, setButton, tab1, tabGroup, win1;

Ti.App.userName = 'demo-user';

Ti.App.channelName = 'demo';

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
  return tab1.open(connectWindow);
});

NAME_TOP = 200;

CHANNEL_TOP = 300;

WIDTH = 400;

nameField = Ti.UI.createTextField({
  top: NAME_TOP,
  width: WIDTH,
  height: 100,
  hintText: 'なまえ',
  borderStyle: Titanium.UI.INPUT_BORDERSTYLE_BEZEL
});

channelField = Ti.UI.createTextField({
  top: CHANNEL_TOP,
  width: WIDTH,
  height: 100,
  hintText: 'あいことば',
  borderStyle: Ti.UI.INPUT_BORDERSTYLE_ROUNDER
});

win1.add(setButton);

win1.add(nameField);

win1.add(channelField);

tabGroup.open();
