import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/bloc/locations_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/models/location.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/screens/locations_detail_screen.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/widgets/boxs/rm_order_number_box.dart';
import '../../../core/utils/constants/constants.dart';

class RMLocationsCard extends StatelessWidget {
  final int index;
  final Location location;
  const RMLocationsCard({
    super.key,
    required this.index,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<LocationsBloc>().add(GetLocationDetails(index: index));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LocationsDetailScreen(id: index)));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(RMPaddings.p10),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(RMSizes.s8),
        ),
        child: Row(
          children: [
            RMOrderNumberBox(text: '${location.id}'),
            const SizedBox(width: RMSizes.s20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: RMSizes.s5),
                  Text(
                    location.type,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: RMSizes.s5),
                  Text(
                    location.dimension,
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
