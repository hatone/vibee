var readBuffer, readCallback, socket, tap1, tap2, tap3, win;

win = Titanium.UI.createWindow({
  title: 'connect window',
  backgroundColor: '#fff'
});

tap1 = Ti.UI.createImageView({
  top: '0%',
  left: '0%',
  width: '33%',
  height: '33%'
});

tap1.addEventListener('click', function(e) {
  var dialog;
  dialog = Titanium.UI.createAlertDialog();
  dialog.setTitle('Tap1');
  dialog.setMessage('Tap1');
  return dialog.show();
});

win.add(tap1);

tap2 = Ti.UI.createImageView({
  top: '0%',
  left: '33%',
  width: '33%',
  height: '33%'
});

tap2.addEventListener('click', function(e) {
  var dialog;
  dialog = Titanium.UI.createAlertDialog();
  dialog.setTitle('Tap2');
  dialog.setMessage('Tap2');
  return dialog.show();
});

win.add(tap2);

tap3 = Ti.UI.createImageView({
  top: '0%',
  left: '66%',
  width: '33%',
  height: '33%'
});

tap3.addEventListener('click', function(e) {
  var dialog;
  dialog = Titanium.UI.createAlertDialog();
  dialog.setTitle('Tap3');
  dialog.setMessage('Tap3');
  return dialog.show();
});

win.add(tap3);

win.open();

socket;


readBuffer = Titanium.createBuffer({
  length: 1024
});

readCallback = function(e) {
  var commands, signs, str;
  if (e.bytesProcessed === -1) {
    socket.close();
    return;
  }
  str = Ti.Codec.decodeString({
    source: readBuffer,
    length: e.bytesProcessed
  });
  str.replace("\n", "");
  commands = str.split(" ");
  if (commands.length > 4 && commands[0] === 'VIBEE' && commands[1] === Ti.App.channelName) {
    if (commands[3] === "VIBRATE") {
      signs = commands[4].split("|");
      signs.unshift(0);
      Ti.Media.vibrate(signs);
    }
  }
  return Ti.Stream.read(socket, readBuffer, readCallback);
};

socket = Ti.Network.Socket.createTCP({
  host: 'echo.picora.us',
  port: 3535,
  connected: function(e) {
    var data;
    Ti.Stream.read(socket, readBuffer, readCallback);
    return data = Ti.createBuffer({
      value: "VIBEE " + Ti.App.channelName + " " + Ti.App.userName + " VIBRATE 1000|100|1000|100"
    });
  },
  closed: function(e) {}
});

socket.connect();

Ti.Gesture.addEventListener("shake", function(e) {
  var bytesWritten, data;
  data = Ti.createBuffer({
    value: "VIBEE " + Ti.App.channelName + " " + Ti.App.userName + " VIBRATE 100|10|100|10|100|10|100|10"
  });
  return bytesWritten = socket.write(data);
});
