import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/constants/constants.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/widgets/appbar/rm_appbar.dart';

class RMLoading extends StatelessWidget {
  final String? title;
  const RMLoading({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: title != null ? RMAppBar(title: title!) : const SizedBox(),
      ),
      body: Center(
        child: Lottie.asset(
          RMPaths.loadingAnimation,
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height / 2,
        ),
      ),
    );
  }
}
