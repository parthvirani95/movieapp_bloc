import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp_bloc/common/constants/translation_constants.dart';
import 'package:movieapp_bloc/common/extension/string_extension.dart';
import 'package:movieapp_bloc/presentation/blocs/movie_videos/movie_videos_bloc.dart';
import 'package:movieapp_bloc/presentation/journeys/watch_video/watch_video_arguments.dart';
import 'package:movieapp_bloc/presentation/journeys/watch_video/watch_video_screen.dart';
import 'package:movieapp_bloc/presentation/widgets/button.dart';

class VideoWidget extends StatelessWidget {
  final MovieVideosBloc movieVideosBloc;

  const VideoWidget({Key? key, required this.movieVideosBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: movieVideosBloc,
      builder: (context, state) {
        if (state is MovieVideosLoaded && state.videoEntity.iterator.moveNext()) {
          final _videos = state.videoEntity;
          return Button(
            text: TranslationConstants.watchTrailers,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WatchVideoScreen(
                    watchVideoArguments: WatchVideoArguments(videos: _videos),
                  ),
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
