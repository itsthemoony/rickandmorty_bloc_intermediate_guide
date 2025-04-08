import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/bloc/episodes_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/screens/episodes_detail_screen.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/widgets/boxs/rm_order_number_box.dart';

class EpisodesCard extends StatelessWidget {
  final int index;
  const EpisodesCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final episodes = context.read<EpisodesBloc>().state.episodes;
    return GestureDetector(
      onTap: () {
        context.read<EpisodesBloc>().add(GetEpisodeDetail(index: index));
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EpisodesDetailScreen(id: index);
        }));
      },
      child: Container(
        height: RMSizes.s80,
        width: double.infinity,
        padding: const EdgeInsets.all(RMPaddings.p10),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(RMSizes.s8),
        ),
        child: Row(
          children: [
            RMOrderNumberBox(text: '${episodes[index].id}'),
            const SizedBox(width: RMSizes.s20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    episodes[index].name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: RMSizes.s10),
                  Text(
                    episodes[index].episode,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
