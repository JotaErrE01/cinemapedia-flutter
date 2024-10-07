import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/slider_background_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MoviesSlideshow extends ConsumerWidget {
  final List<Movie> movies;

  const MoviesSlideshow({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    // final sliderBackgroundColor = ref.watch(sliderBackgroundColorProvider);
    // final swipperController = SwiperController();

    // print('index ${swipperController.addListener()}');

    Future<void> updatePalette(Movie movie) async {
      final PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(
        NetworkImage(movie.backdropPath),
      );

      Color dominantColor =
          paletteGenerator.dominantColor?.color ?? Colors.transparent;

      ref.read(sliderBackgroundColorProvider.notifier).update(dominantColor);
    }

    return SizedBox(
      width: double.infinity,
      height: 230,
      child: Swiper(
        itemCount: movies.length,
        viewportFraction: 0.8,
        scale: 0.9,
        duration: 1000,
        autoplayDelay: 7000,
        loop: true,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(bottom: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary,
          ),
        ),
        itemBuilder: (context, index) {
          return Slide(movie: movies[index]);
        },
        onIndexChanged: (index) {
          if (movies.isEmpty) return;
          updatePalette(movies[index]);
        },
      ),
    );
  }
}

class Slide extends StatelessWidget {
  final Movie movie;

  const Slide({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.only(bottom: 30),
    //   child: Card(
    //     elevation: 10,
    //     clipBehavior: Clip.hardEdge,
    //     shadowColor: dominantColor,
    //     margin: const EdgeInsets.symmetric(horizontal: 0),
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //     child: Image.network(
    //       widget.movie.backdropPath,
    //       alignment: Alignment.center,
    //       fit: BoxFit.fill,
    //     ),
    //   ),
    // );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 20),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black45,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            movie.backdropPath,
            alignment: Alignment.center,
            fit: BoxFit.fill,
            loadingBuilder: (context, child, loadingProgress) {
              return Skeletonizer(
                enabled: loadingProgress != null,
                child: FadeIn(child: child),
              );
            },
            // child: Placeholder(),
          ),
        ),
      ),
    );
    // return const Placeholder();
  }
}
