import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/domain/entities/training_day.dart';
import 'package:flutter/material.dart';

class UpdateDay extends StatefulWidget {
  const UpdateDay({super.key, required this.day});
  final TrainingDay day;
  @override
  State<UpdateDay> createState() => _UpdateDayState();
}

class _UpdateDayState extends State<UpdateDay> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.day.name)),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name', style: FontsManager.lexendBold(size: 25)),
            TextFormField(
              controller: nameController,
              style: FontsManager.lexendRegular(),
            ),
            SizedBox(height: 30),
            Text('Description', style: FontsManager.lexendBold(size: 25)),
            SizedBox(height: 15),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(contentPadding: EdgeInsets.all(8)),
              style: FontsManager.lexendRegular(),
              maxLines: 4,
            ),
            SizedBox(height: 30),
            Text('Exercises', style: FontsManager.lexendBold(size: 25)),
          ],
        ),
      ),
    );
  }
}
