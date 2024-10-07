import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/slider_background_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieHorizontalListview extends ConsumerStatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;

  final Function()? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.loadNextPage,
  });

  @override
  MovieHorizontalListviewState createState() => MovieHorizontalListviewState();
}

class MovieHorizontalListviewState
    extends ConsumerState<MovieHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels + 500 >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage?.call();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  double getLuminance(Color color) {
    return 0.299 * color.red + 0.587 * color.green + 0.114 * color.blue;
  }

  bool isNearWhite(Color color) {
    double luminance = getLuminance(color);
    return luminance > 200;
  }

  @override
  Widget build(BuildContext context) {
    final sliderBackgroundColor = ref.watch(sliderBackgroundColorProvider);

    return SizedBox(
      height: 350,
      child: Column(
        children: [
          _HeaderSection(
            title: widget.title,
            subtitle: widget.subtitle,
            isNearWhite: isNearWhite(sliderBackgroundColor.color),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.only(top: 10, left: 10),
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _ListItem(movie: widget.movies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final Movie movie;

  const _ListItem({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              width: 150,
              image: NetworkImage(movie.posterPath),
              loadingBuilder: (context, child, loadingProgress) {
                return Skeletonizer(
                  enabled: loadingProgress != null,
                  child: FadeIn(child: child),
                );
              },
              // height: 150,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              style: titleStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool isNearWhite;

  const _HeaderSection({
    required this.title,
    required this.subtitle,
    this.isNearWhite = false,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          color: isNearWhite ? Colors.black : Colors.white,
          fontWeight: FontWeight.w600,
        );
    // final subtileStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
    //       color: isNearWhite ? Colors.white : Colors.black,
    //       fontWeight: FontWeight.w400,
    //     );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title ?? '',
            style: titleStyle,
          ),
          const Spacer(),
          // Text(
          //   subtitle ?? '',
          //   style: subtileStyle,
          // ),
          subtitle?.isNotEmpty != null
              ? Chip(
                  label: Text(subtitle!),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.hardEdge,
                )
              : const SizedBox(),
          // FilledButton.tonal(
          //   onPressed: () {},
          //   style: const ButtonStyle(visualDensity: VisualDensity.compact),
          //   child: Text(subtitle ?? ''),
          // ),
        ],
      ),
    );
  }
}
