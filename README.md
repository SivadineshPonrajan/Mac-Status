# Mac Status

"Mac Status" is a simple SwiftUI-based macOS app, that runs a TCP server to receive status updates. It allows you to change the status displayed in the macOS menu bar via TCP connection or the network commands. 

### Features
- Start and stop a TCP server listening on port `12345`.
- Change the status icon dynamically through network commands.
- Uses SwiftUI for a modern macOS application experience.

### Usage
- When you click Start from the menu bar, the status icon will change to an "up arrow" to indicate the server is running.
- To stop the server, click the menu bar icon again and select Stop. The status icon will change to a "down arrow".
- You can send status updates to the TCP server using the nc (netcat) command in the terminal:

```
echo "1" | nc -w 0 localhost 12345
```

Replace `"1"` with any other string to change the status. The menu bar icon will change based on the status received.

### Quitting the App
To quit the app, click on the menu bar icon and select Quit.

### Status Icons

The following swift code snippet was used in the application.
``` 
label: {Image(systemName: "\(message).circle").padding()}
```

This app is developed for a personal use for a specific purpose. So the icons that supports 'message.circle' are the only possible messages that can be sent. Or this can be further modified in the source code.