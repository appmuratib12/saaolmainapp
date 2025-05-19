import 'package:flutter/material.dart';
import 'package:saaolapp/common/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;
  final String title;
  const VideoPlayerScreen({required this.videoId, required this.title, super.key});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
            appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
        ),

        centerTitle: true,
            ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize:16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily:'FontPoppins',
                  ),
                ),
                const SizedBox(height: 16),
                 ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
                child: player,
              ),
                const SizedBox(height: 20),
             Text(
              'We are India’s leading preventive and rehabilitative Heart Care Organization. '
                  'Our vision is to provide the best quality healthcare to heart and '
                  'lifestyle disease patients at the most affordable costs and in '
                  'the most sustainable manner. Across 135+ centers in India, '
                  'our Doctors help patients receive non-invasive treatments, '
                  'reverse heart disease, and help sustain a healthy, stress-free life.'.trim(),
              style: const TextStyle(
                fontSize:12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: 'FontPoppins',
                letterSpacing:0.1
              ),
              softWrap: true,
            ),
            ],
            ),
          ),
        );
      },
    );
  }
}
