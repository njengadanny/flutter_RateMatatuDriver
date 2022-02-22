import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'models/driver_data.dart';
import 'models/user_data.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double? _ratingValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Driver Rating'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Rate Driver:',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 25),
                // implement the rating bar
                RatingBar(
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.orange),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.orange,
                        ),
                        empty: const Icon(
                          Icons.star_outline,
                          color: Colors.orange,
                        )),
                    onRatingUpdate: (value) {
                      setState(() {
                        _ratingValue = value;
                      });
                    }),
                const SizedBox(height: 25),
                // Display the rate in number
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text(
                    _ratingValue != null ? _ratingValue.toString() : 'Rate it!',
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}