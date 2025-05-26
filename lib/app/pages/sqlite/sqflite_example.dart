import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_code/app/core/extensions/data_types/string_extension.dart';
import 'package:flutter_code/app/core/extensions/build_context/build_context_device.dart';
import 'package:flutter_code/app/core/utils/app_log.dart';
import 'package:flutter_code/app/pages/sqlite/widgets/add_user_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common_widgets/text_widget.dart';
import '../../data/datasources/local/db_helper.dart';
import '../../data/datasources/local/models/user_model.dart';

class SqfliteExample extends StatefulWidget {
  const SqfliteExample({super.key});

  @override
  State<SqfliteExample> createState() => _SqfliteExampleState();
}

class _SqfliteExampleState extends State<SqfliteExample> {
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
            //_formWidget(context),
            Expanded(
              child:
                  _userList.isNotEmpty
                      ? _userListView()
                      : Center(child: TextWidget(text: "No User found")),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUserDialog(
            context,
            addUserCallBack: (user) {
              addUser(user);
            },
          );
        },
        child: Icon(Icons.add),
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
                if (!mounted) return;
                addUserDialog(
                  context,
                  user: user,
                  addUserCallBack: (user) {
                    editUser(user);
                  },
                );
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

  Future<void> addUser(User user) async {
    var isCreated = await dbHelper!.createUser(
      name: user.name,
      mobile: user.mobileNumber,
      email: user.email,
    );
    if (isCreated) {
      debugPrint("User created done");
    } else {
      debugPrint("User not created");
    }
    getAllUser();
  }

  Future<void> editUser(User user) async {
    AppLog.log("edit user ====${jsonEncode(user)}");
    var isCreated = await dbHelper!.editUser(
      id: user.id,
      name: user.name,
      mobile: user.mobileNumber,
      email: user.email,
    );
    if (isCreated) {
      debugPrint("User edited done");
    } else {
      debugPrint("User not edited");
    }
    getAllUser();
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

  addUserDialog(
    BuildContext context, {
    Function(User user)? addUserCallBack,
    User? user,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 22.r),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
          child: AddUserWidget(addUserCallBack: addUserCallBack, user: user),
        );
      },
    );
  }
}
