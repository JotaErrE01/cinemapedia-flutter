import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/providers/movies/slider_background_color_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_app_bar.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _HomeView(),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  final _scrollController = ScrollController();
  bool isAppBarFloating = false;

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();

    _scrollController.addListener(() {
      if (_scrollController.offset > 50 && !isAppBarFloating) {
        setState(() {
          isAppBarFloating =
              true; // Cambia el estado cuando el scroll pasa 50px
        });
      } else if (_scrollController.offset <= 50 && isAppBarFloating) {
        setState(() {
          isAppBarFloating =
              false; // Restablecer el estado cuando el scroll es menor a 50px
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sliderMovies = ref.watch(moviesSlideshowProvider);
    final sliderBackgroundColor = ref.watch(sliderBackgroundColorProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final darkColor = Theme.of(context).primaryColorDark;

    // if (nowPlayingMovies.isEmpty) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            sliderBackgroundColor.color.withOpacity(0.0),
            sliderBackgroundColor.color.withOpacity(0.8), // El color dominante
            sliderBackgroundColor.color.withOpacity(0.0),
          ],
        ),
      ),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: !isAppBarFloating ? Colors.transparent : darkColor,
            floating: true,
            // stretch: true,
            // pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              title: CustomAppBar(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    MoviesSlideshow(movies: sliderMovies),
                    MovieHorizontalListview(
                      movies: nowPlayingMovies,
                      title: 'In Theater',
                      subtitle: 'Monday 20th',
                      loadNextPage: ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage,
                    ),
                    MovieHorizontalListview(
                      movies: nowPlayingMovies,
                      title: 'Soon to be released',
                      subtitle: '2024 - 2025',
                      loadNextPage: ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage,
                    ),
                    MovieHorizontalListview(
                      movies: nowPlayingMovies,
                      title: 'Top Rated',
                      // subtitle: 'Monday 20th',
                      loadNextPage: ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage,
                    ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     padding: const EdgeInsets.only(top: 20),
                    //     itemCount: nowPlayingMovies.length,
                    //     itemBuilder: (context, index) {
                    //       return ListTile(
                    //         title: Text(nowPlayingMovies[index].title),
                    //       );
                    //     },
                    //   ),
                    // )
                  ],
                );
              },
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
