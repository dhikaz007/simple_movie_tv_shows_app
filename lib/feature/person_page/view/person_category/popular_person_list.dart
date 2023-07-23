import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constant/app_color.dart';
import '../../view_model/person_view_model.dart';

class PopularPersonList extends StatelessWidget {
  const PopularPersonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PersonViewModel>(
      builder: (context, personValue, child) {
        if (personValue.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.goldenBuddhaBelly,
            ),
          );
        } else {
          return SizedBox(
            height: 260,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: personValue.peopleResult?.length,
              itemBuilder: (context, index) {
                return Container();
                // return MovieItemWidget(
                //   moviePoster: personValue
                //           .peopleResult?[index].knownFor?[index].posterPath ??
                //       '',
                //   movieTitle:
                //       personValue.peopleResult?[index].knownFor?[index].title ??
                //           '',
                //   movieRating: personValue
                //           .peopleResult?[index].knownFor?[index].voteAverage
                //           ?.toDouble() ??
                //       0.0,
                //   onTap: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) {
                //           return DetailMain(
                //             movieBackdrop: personValue.peopleResult?[index]
                //                     .knownFor?[index].backdropPath ??
                //                 '',
                //             movieTitle: personValue.peopleResult?[index]
                //                     .knownFor?[index].title ??
                //                 '',
                //             movieRating: personValue.peopleResult?[index]
                //                     .knownFor?[index].voteAverage
                //                     ?.toDouble() ??
                //                 0.0,
                //             movieReleaseData: DateTime.parse(personValue
                //                     .peopleResult?[index]
                //                     .knownFor?[index]
                //                     .releaseDate ??
                //                 ''),
                //             movieOverview: personValue.peopleResult?[index]
                //                     .knownFor?[index].overview ??
                //                 '',
                //             //result: personValue.peopleResult[index],
                //           );
                //         },
                //       ),
                //     );
                //   },
                // );
              },
            ),
          );
        }
      },
    );
  }
}
