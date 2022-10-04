# Venice core

This project aims at providing a unified abstract interface to exchange data between devices using
different technologies.

Data exchanges do work as follow:
* File exchange is done between a sender and a receiver;
* Multiple (one or several) channels link sender and receiver;
* Sender-side, a scheduler sends file chunks on channels as it sees fit;
* Receiver-side, an aggregator reconstructs file from received file chunks.

## General architecture

#### Channels

**A channel is charged with transmitting data from sender end to receiver end. That's it!**

This package provides a arbitrary-abstract `Channel` interface for other packages to implement, the
idea being that you can implement a channel with whatever you want: Wi-Fi, Bluetooth...

Any technology able to carry data can be implemented into a channel!
Yeah, [even sound](https://developers.google.com/android/reference/com/google/android/gms/nearby/messages/audio/AudioBytes)!
(don't try this at home)

There are two types of channel:
* **DataChannel**: they are used to transfer file chunks between devices;
* **BootstrapChannel**: they are used to communicate about *DataChannel* credentials.

## Implementation

### Channel implementation

#### Bootstrap channel

```dart
abstract class BootstrapChannel {
  /// Provides information to sending and receiving ends about what's happening
  /// in the current channel.
  late Function(BootstrapChannelEvent event, dynamic data) on;

  /// Initializes current channel, and returns when it is ready to send data.
  Future<void> initSender();

  /// Initializes current channel, and returns when it is ready to receive data.
  Future<void> initReceiver();

  /// Sends file metadata to receiving end.
  Future<void> sendFileMetadata(FileMetadata data);

  /// Sends channel metadata to receiving end, for it to initialize data
  /// channels before starting file exchange.
  Future<void> sendChannelMetadata(ChannelMetadata data);
}
```

Your custom bootstrap channel must implement those four methods:
* `initSender` will be called by the scheduler: you should include in there all code relative to
  socket opening;
* `initReceiver` will be called by the receiver: it should establish connection with
  connection-opening code contained in `initSender`;
* `sendFileMetadata` and `sendChannelMetadata` will be called by the sending end to transmit
  information to receiving end.

#### Data channel

```dart
abstract class DataChannel {
  /// Provides information to sending and receiving ends about what's happening
  /// in the current channel.
  late Function(DataChannelEvent event, dynamic data) on;

  /// Initializes current channel, and returns when it is ready to send data.
  /// Once sockets are ready, this must send information about them through
  /// provided bootstrap channel.
  Future<void> initSender(BootstrapChannel channel);

  /// Initializes current channel from provided channel metadata, and returns
  /// when it is ready to receive data.
  Future<void> initReceiver(ChannelMetadata data);

  /// Sends a file piece through current channel, and returns after successful
  /// sending; this doesn't check if chunk was received.
  Future<void> sendChunk(FileChunk chunk);
}
```

Your custom data channel must implement those three methods:
* `initSender` will be called by the scheduler: you should include in there all code relative to
  socket opening;
* `initReceiver` will be called by the receiver: it should establish connection with
  connection-opening code contained in `initSender`;
* `sendChunk` will be called by scheduler sender-side; it should send chunk's data over
  previously-opened socket.

### Implementation strategy

As said previously, the `Channel` interface provided by this package is as abstract as possible to
let people implement it the way they want.

It is written in Dart, and thus can be used on a variety of platforms: Android, iOS, Linux, Windows
and macOS.

There are two ways to implement a channel: you must create either [a package or a plugin](https://docs.flutter.dev/development/packages-and-plugins/developing-packages).

#### Package implementation

If you can use Dart or Flutter packages to create your implementation, then *package* is the way to
go. It only requires you to implement `Channel` interface using third-party packages.

<p align="center">
  <img src="assets/img/Channel%20implementation%20(package).drawio.png"/>
</p>

#### Plugin implementation

However, if you need to write channel implementation for each platforms, you'll have to create a
*Flutter plugin*, which invokes native code through a [method channel](https://docs.flutter.dev/development/platform-integration/platform-channels).

<p align="center">
  <img src="assets/img/Channel%20implementation%20(plugin).drawio.png"/>
</p>