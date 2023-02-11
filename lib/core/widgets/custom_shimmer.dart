part of 'widgets.dart';

class CustomShimmer extends StatelessWidget {

  const CustomShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.theme.scaffoldBackgroundColor,
      highlightColor: const Color(0xFFF3F3F3),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[200]
        ),
      ),
    );
  }
}