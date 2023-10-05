import 'package:venice_core/channels/abstractions/channel.dart';
import 'package:venice_core/channels/channel_metadata.dart';
import 'package:venice_core/channels/events/bootstrap_channel_event.dart';
import 'package:venice_core/file/file_metadata.dart';

/// A bootstrap channel is a channel that carries information about
/// data channels from sender to receiver.
///
/// Its connection between both ends must be done without having to share
/// credentials over the network.
abstract class BootstrapChannel extends Channel {
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
