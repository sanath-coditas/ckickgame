import 'package:flutter/material.dart';

import '../../constants/text_constants.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
  })  : _formKey = formKey,
        _nameController = nameController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: TextFormField(
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter a name';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: TextConstants.enterNameText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
