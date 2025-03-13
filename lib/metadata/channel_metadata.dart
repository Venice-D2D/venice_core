/// This payload class holds data needed for a channel's receiving end to
/// connect to sending end; as such, it is sent from sender part to receiver
/// through a bootstrap channel.
class ChannelMetadata {
  /// Identifies in a unique way the channel concerned by this instance.
  /// Must have the same value on both sending and receiving ends.
  final String channelIdentifier;

  /// Physical address of the server socket.
  final String address;

  /// Port of the server socket.
  final int port;

  /// Name of the access point (needed for Wi-Fi, for instance).
  final String apIdentifier;

  /// Password needed to connect to the distant access point.
  final String password;

  ChannelMetadata(
      this.channelIdentifier, this.address, this.apIdentifier, this.password,
      this.port);


  @override
  String toString() {
    return "$channelIdentifier;$address;$apIdentifier;$password;$port";
  }

  @override
  bool operator == (Object other) {
    return other is ChannelMetadata
        && channelIdentifier == other.channelIdentifier
        && address == other.address
        && apIdentifier == other.apIdentifier
        && password == other.password
        && port == other.port;
  }

  @override
  int get hashCode => Object.hash(
      channelIdentifier, address, apIdentifier, password, port);
}