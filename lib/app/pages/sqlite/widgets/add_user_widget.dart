import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_code/app/common_widgets/text_widget.dart';
import 'package:flutter_code/app/core/extensions/build_context/build_context_device.dart';
import 'package:flutter_code/app/core/extensions/data_types/string_extension.dart';
import 'package:flutter_code/app/core/routes/library/routes_library.dart';
import 'package:flutter_code/app/data/datasources/local/models/user_model.dart';

import '../../../common_widgets/text_button_widget.dart';
import '../../../common_widgets/text_form_field_widget.dart';

class AddUserWidget extends StatefulWidget {
  final Function(User user)? addUserCallBack;
  final User? user;

  const AddUserWidget({super.key, this.addUserCallBack, this.user});

  @override
  State<AddUserWidget> createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user?.name ?? "";
      _emailController.text = widget.user?.email ?? "";
      _mobileNumberController.text = widget.user?.mobileNumber ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            TextWidget(
              text: widget.user == null ? "Add User" : "Edit User",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            TextFormFieldWidget(
              controller: _nameController,
              hintText: "Enter your name",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),

            TextFormFieldWidget(
              controller: _emailController,
              hintText: "Enter your email",
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter your email";
                }
                if (!value.trim().isValidEmail) {
                  return "Please enter a valid email";
                }
                return null;
              },
            ),
            TextFormFieldWidget(
              controller: _mobileNumberController,
              hintText: "Enter your mobile number",
              textInputType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter your mobile number";
                }
                if (!value.trim().isValidBDPhone) {
                  return "Please enter a valid Bangladeshi mobile number";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            SizedBox(
              width: min(width / 2, width / 1.5),
              child: TextButtonWidget(
                onPressed: () => addUser(),
                buttonText: widget.user == null ? "Add" : "Edit",
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  addUser() {
    if (_formKey.currentState!.validate()) {
      var name = _nameController.text.trim();
      var email = _emailController.text.trim();
      var mobileNumber = _mobileNumberController.text.formattedWithBDCode;
      var user = User(
        id: widget.user?.id,
        name: name,
        email: email,
        mobileNumber: mobileNumber,
      );
      widget.addUserCallBack?.call(user);
      Pages.goBack(context);
    }
  }
}
