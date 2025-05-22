import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_code/app/core/extensions/data_types/string_extension.dart';
import 'package:flutter_code/app/core/extensions/build_context/build_context_device.dart';

import '../../common_widgets/text_widget.dart';
import '../../data/datasources/local/db_helper.dart';
import '../../common_widgets/text_button_widget.dart';
import '../../common_widgets/text_form_field_widget.dart';
import '../../data/datasources/local/models/user_model.dart';

class SqfliteExample extends StatefulWidget {
  const SqfliteExample({super.key});

  @override
  State<SqfliteExample> createState() => _SqfliteExampleState();
}

class _SqfliteExampleState extends State<SqfliteExample> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  final List<User> _userList = [];
  DBHelper? dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper.getInstance;
    getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Scaffold(
      appBar: AppBar(title: Text("Sqflite example")),
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20),
            _formWidget(context),
            Expanded(
              child:
                  _userList.isNotEmpty
                      ? _userListView()
                      : Center(child: TextWidget(text: "No User found")),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formWidget(BuildContext context) {
    final width = context.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 10,
              children: [
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
                    onPressed: () {
                      addUser();
                    },
                    buttonText: "Add User",
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userListView() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 8),
      itemBuilder: (_, index) {
        return Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 8, right: 0),
              trailing: _trailingWidget(_userList[index]),
              title: Row(
                spacing: 5,
                children: [
                  TextWidget(text: "User Name :"),
                  TextWidget(
                    text: "${_userList[index].name?.capitalize}",
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              subtitle: Row(
                spacing: 5,
                children: [
                  TextWidget(text: "Email Address :"),
                  TextWidget(
                    text: "${_userList[index].email}",
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 10);
      },
      itemCount: _userList.length,
    );
  }

  Widget _trailingWidget(User user) {
    return Builder(
      builder:
          (iconContext) => IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () async {
              final RenderBox button =
                  iconContext.findRenderObject() as RenderBox;
              final RenderBox overlay =
                  Overlay.of(iconContext).context.findRenderObject()
                      as RenderBox;
              final Offset position = button.localToGlobal(
                Offset.zero,
                ancestor: overlay,
              );
              final Size size = button.size;

              final selected = await showMenu<String>(
                context: iconContext,
                position: RelativeRect.fromLTRB(
                  position.dx,
                  position.dy + size.height,
                  // ⬅️ Show below the button
                  position.dx + size.width,
                  position.dy,
                ),
                items: [
                  PopupMenuItem(value: 'edit', child: Text('Edit Info')),
                  PopupMenuItem(value: 'delete', child: Text('Delete User')),
                ],
              );

              if (selected == 'edit') {
                // Handle edit logic
              } else if (selected == 'delete') {
                if (user.id != null) {
                  deleteUser(user.id!);
                }
              }
            },
          ),
    );
  }

  Future<void> getAllUser() async {
    final userMode = await dbHelper!.getAllUser();

    debugPrint("user model ==== ${jsonEncode(userMode)}");

    final users = userMode.data;
    if (users?.isNotEmpty ?? false) {
      _userList
        ..clear()
        ..addAll(users!);
    }

    setState(() {});
  }

  Future<void> addUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      var name = _nameController.text.trim();
      var email = _emailController.text.trim();
      var mobileNumber = _mobileNumberController.text.formattedWithBDCode;
      var isCreated = await dbHelper!.createUser(
        name: name,
        mobile: mobileNumber,
        email: email,
      );
      if (isCreated) {
        debugPrint("User created done");
        _nameController.clear();
        _emailController.clear();
        _mobileNumberController.clear();
      } else {
        debugPrint("User not created");
      }

      getAllUser();
    }
  }

  Future<void> deleteUser(int id) async {
    bool isDeleted = await dbHelper!.deleteUser(id);
    if (isDeleted) {
      removeUserById(id); // This will update the UI
    }
  }

  void removeUserById(int id) {
    setState(() {
      _userList.removeWhere((user) => user.id == id);
    });
  }
}
