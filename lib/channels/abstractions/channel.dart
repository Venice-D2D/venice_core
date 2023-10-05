/// A [Channel] carries information between a receiving and a sending ends.
///
/// This abstraction is meant to regroup common code between bootstrap and data
/// channels.
abstract class Channel {
  /// Releases all resources used by this [Channel] instance.
  Future<void> close();
}
