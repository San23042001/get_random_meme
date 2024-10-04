import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_random_memes/presentation/cubit/meme_cubit/meme_cubit_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MemeCubitCubit, MemeCubitState>(
        builder: (context, state) {
          if (state is MemeCubitLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          }
          if (state is MemeCubitSuccess) {
            return Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Category ${state.meme.category}",
                        style: const TextStyle(fontSize: 36),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Image.network(
                          state.meme.image,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                                Icons.error); // Or any placeholder image
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text("Caption: ${state.meme.caption}"),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is MemeCubitError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.error.errorMessage),
                TextButton(
                  onPressed: () {
                    // Use the existing cubit instance to fetch a new meme
                    context.read<MemeCubitCubit>().getMeme();
                  },
                  child: const Text("Retry"),
                )
              ],
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.skip_next),
        onPressed: () {
          // Use the existing cubit instance to fetch a new meme
          context.read<MemeCubitCubit>().getMeme();
        },
      ),
    );
  }
}
