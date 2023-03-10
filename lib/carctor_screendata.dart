import 'package:flutter/material.dart';
import 'package:practic_app/app_model.dart';

class CaractorScreenData extends StatelessWidget {
  final Results? results;
  final Info? info;
  const CaractorScreenData({Key? key, this.results, this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("${info!.count!}"),
          Image.network("${results!.image}"),
          Text("result id: ${results!.id}",
              style: const TextStyle(fontSize: 18)),
          Text("location : ${results!.location!.name}",
              style: const TextStyle(fontSize: 18)),
          Text("origin : ${results!.origin!.name}",
              style: const TextStyle(fontSize: 18)),
          Text("species: ${results!.species}",
              style: const TextStyle(fontSize: 18)),
          Text("status: ${results!.status}"),
          Text("type: ${results!.type}"),
          const SizedBox(height: 16),
          Text("info count: ${info!.count}",
              style: const TextStyle(fontSize: 18)),
          Text("info pages: ${info!.pages}"),
        ],
      ),
    );
  }
}
