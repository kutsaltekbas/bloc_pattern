import 'package:bloc_pattern/bloc/cats_cubit.dart';
import 'package:bloc_pattern/bloc/cats_repository.dart';
import 'package:bloc_pattern/bloc/cats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCatsView extends StatefulWidget {
  const BlocCatsView({super.key});

  @override
  State<BlocCatsView> createState() => _BlocCatsViewState();
}

class _BlocCatsViewState extends State<BlocCatsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatsCubit(SampleCatsRepository()),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Hello"),
        ),
        body: BlocConsumer<CatsCubit, CatsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is CatsInitial) {
              return Column(
                children: [
                  const Center(
                    child: Text("init"),
                  ),
                  buildFloatingActionButtonCall(context)
                ],
              );
            } else if (state is CatsLoading) {
              return const Center(
                child: Text("loading"),
              );
            } else if (state is CatsCompleted) {
              return ListView.builder(
                itemCount: state.response.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Image.network(
                        state.response[index].imageUrl.toString()),
                    subtitle:
                        Text(state.response[index].description.toString()),
                  );
                },
              );
            } else {
              final error = state as CatsError;
              return Text(error.message);
            }
          },
        ),
      );

  FloatingActionButton buildFloatingActionButtonCall(BuildContext context) {
    return FloatingActionButton(onPressed: () {
      BlocProvider.of<CatsCubit>(context).getCats();
    });
  }
}
