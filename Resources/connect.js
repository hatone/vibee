var readBuffer, readCallback, socket, textarea, win;

win = Titanium.UI.createWindow({
  title: 'connect window',
  backgroundColor: '#fff'
});

textarea = Titanium.UI.createTextArea({
  value: userName
});

win.add(textarea);

win.open();

socket;


readBuffer = Titanium.createBuffer({
  length: 1024
});

readCallback = function(e) {
  var str;
  if (e.bytesProcessed === -1) {
    textarea.value += ">>Recieved socket closed \n";
    socket.close();
    return;
  }
  str = Ti.Codec.decodeString({
    source: readBuffer,
    length: e.bytesProcessed
  });
  textarea.value = e.bytesProcessed + "> " + str + "\n" + textarea.value;
  return Ti.Stream.read(socket, readBuffer, readCallback);
};

socket = Ti.Network.Socket.createTCP({
  host: 'echo.picora.us',
  port: 3535,
  connected: function(e) {
    var bytesWritten, data;
    Ti.Stream.read(socket, readBuffer, readCallback);
    textarea.value += ">> Connected to host" + socket.host + "\n";
    data = Ti.createBuffer({
      value: "GET /index.html HTTP/1.1\r\nHost:example.com\r\n\r\n"
    });
    return bytesWritten = socket.write(data);
  },
  closed: function(e) {
    return textarea.value += ">> Socket closed";
  }
});

socket.connect();
