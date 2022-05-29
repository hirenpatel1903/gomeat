import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vendor/Locale/locales.dart';
//import 'package:shopcart/Locale/locales.dart';

class Reviews extends StatefulWidget {
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(locale.freshLadiesFinger),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        locale.avgRatings,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontSize: 14),
                      ),
                      buildBigRatingCard(context),
                      Text(
                        '124 ' + locale.ratings,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  VerticalDivider(
                    width: 20,
                    thickness: 0.6,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.grey[200],
                  ),
                  Column(
                    children: [
                      buildReviewIndicator(context, '5', 0.8, '78'),
                      buildReviewIndicator(context, '4', 0.6, '24'),
                      buildReviewIndicator(context, '3', 0.1, ' 8 '),
                      buildReviewIndicator(context, '2', 0.2, '11'),
                      buildReviewIndicator(context, '1', 0.1, ' 3 '),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    locale.recentReviews,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.w500),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return buildReviewCard();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card buildReviewCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      color: Colors.white,
      shadowColor: Colors.grey[200],
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent)),
      elevation: 0,
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Heena Taylor',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            subtitle: Row(
              children: [
                Text(
                  '20 Mar 2020, 10:00 AM',
                  style: TextStyle(fontSize: 12),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Color(0xffffb910),
                      size: 18,
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffb910),
                      size: 18,
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffb910),
                      size: 18,
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffb910),
                      size: 18,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.grey[400],
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et doloretiop nmagna aliqua.',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.1,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Row buildReviewIndicator(
      context, String number, double percent, String reviews) {
    return Row(
      children: [
        Text(
          number,
          style: TextStyle(color: Colors.grey[600]),
        ),
        SizedBox(
          width: 5,
        ),
        Icon(
          Icons.star,
          color: Color(0xffffb910),
          size: 20,
        ),
        SizedBox(
          width: 10,
        ),
        LinearPercentIndicator(
          backgroundColor: Colors.grey[300],
          width: 105.0,
          lineHeight: 6.0,
          percent: percent,
          progressColor: Colors.green,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          reviews,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Container buildBigRatingCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 10),
      //width: 30,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "4.2",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.button.copyWith(fontSize: 16),
          ),
          SizedBox(
            width: 4,
          ),
          Icon(
            Icons.star,
            size: 14,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ],
      ),
    );
  }
}
