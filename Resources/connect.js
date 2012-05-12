var i, playSound, readBuffer, readCallback, sendSound, socket, sound, tap0, tap1, tap2, tap3, tap4, tap5, tap6, tap7, tap8, win, _i;

sound = [];

for (i = _i = 0; _i < 9; i = ++_i) {
  sound.push(Ti.Media.createSound({
    url: 'sounds/' + i + '.mp3'
  }));
}

playSound = function(num) {
  return sound[num].play();
};

win = Titanium.UI.createWindow({
  title: 'connect window',
  backgroundColor: '#fff'
});

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
    Ti.UI.currentWindow.title = commands[2];
    if (commands[3] === "VIBRATE") {
      signs = commands[4].split("|");
      signs.unshift(0);
      Ti.Media.vibrate(signs);
    } else {
      playSound(commands[4]);
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

sendSound = function(num) {
  var bytesWritten, data;
  data = Ti.createBuffer({
    value: "VIBEE " + Ti.App.channelName + " " + Ti.App.userName + " SOUND " + num + " P"
  });
  return bytesWritten = socket.write(data);
};

tap0 = Ti.UI.createImageView({
  top: '0%',
  left: '0%',
  width: '33%',
  height: '33%'
});

tap0.addEventListener('click', function(e) {
  return sendSound(0);
});

win.add(tap0);

tap1 = Ti.UI.createImageView({
  top: '0%',
  left: '33%',
  width: '33%',
  height: '33%'
});

tap1.addEventListener('click', function(e) {
  return sendSound(1);
});

win.add(tap1);

tap2 = Ti.UI.createImageView({
  top: '0%',
  left: '66%',
  width: '33%',
  height: '33%'
});

tap2.addEventListener('click', function(e) {
  return sendSound(2);
});

win.add(tap2);

tap3 = Ti.UI.createImageView({
  top: '33%',
  left: '0%',
  width: '33%',
  height: '33%'
});

tap3.addEventListener('click', function(e) {
  return sendSound(3);
});

win.add(tap3);

tap4 = Ti.UI.createImageView({
  top: '33%',
  left: '33%',
  width: '33%',
  height: '33%'
});

tap4.addEventListener('click', function(e) {
  return sendSound(4);
});

win.add(tap4);

tap5 = Ti.UI.createImageView({
  top: '33%',
  left: '66%',
  width: '33%',
  height: '33%'
});

tap5.addEventListener('click', function(e) {
  return sendSound(5);
});

win.add(tap5);

tap6 = Ti.UI.createImageView({
  top: '66%',
  left: '0%',
  width: '33%',
  height: '33%'
});

tap6.addEventListener('click', function(e) {
  return sendSound(6);
});

win.add(tap6);

tap7 = Ti.UI.createImageView({
  top: '66%',
  left: '33%',
  width: '33%',
  height: '33%'
});

tap7.addEventListener('click', function(e) {
  return sendSound(7);
});

win.add(tap7);

tap8 = Ti.UI.createImageView({
  top: '66%',
  left: '66%',
  width: '33%',
  height: '33%'
});

tap8.addEventListener('click', function(e) {
  return sendSound(8);
});

win.add(tap8);

win.open();
