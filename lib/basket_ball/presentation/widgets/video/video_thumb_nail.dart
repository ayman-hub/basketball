import 'package:flutter/material.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:video_player/video_player.dart';

class VideoImage extends StatefulWidget {
  VideoImage(this.url,{Key key}) : super(key: key);
String url;
  @override
  _VideoImageState createState() {
    return _VideoImageState();
  }
}

class _VideoImageState extends State<VideoImage> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        print('initialized');
        setState(() {});  //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.initialized
        ? Container(
      alignment: Alignment.center,
      height: 300,
      width: MediaQuery.of(context).size.width,
      //decoration: BoxDecoration(border:Border.all(color:Colors.black)),
      child: VideoPlayer(_controller),
    )
        : getLoadingContainer(context);
  }
}