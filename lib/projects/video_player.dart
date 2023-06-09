import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  final double videoHeight;
  final String videoLink;

  final String? gitHubUrl;

  const VideoApp({
    super.key,
    required this.videoHeight,
    this.gitHubUrl,
    this.videoLink =
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  });

  @override
  State<VideoApp> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoLink)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((value) => setState(() {
            _controller.play();
          }));
  }

  @override
  Widget build(BuildContext context) {
    // if(_controller.value.isInitialized) _controller.play;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        height: widget.videoHeight,
        child: Align(
          alignment: Alignment.center,
          child: _controller.value.isInitialized
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(16),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: VideoPlayer(_controller)),
                      ),
                    ),
                    widget.gitHubUrl != null
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio < 1
                                ? 1
                                : _controller.value.aspectRatio,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FloatingActionButton(
                                  backgroundColor: Colors.black,
                                  onPressed: () =>
                                      _launchURL(widget.gitHubUrl!),
                                  child: const FaIcon(
                                    FontAwesomeIcons.github,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        backgroundColor: Colors.blueGrey.withOpacity(0.5),
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                      ),
                    ),
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
