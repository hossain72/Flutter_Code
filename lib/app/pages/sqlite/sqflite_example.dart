import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_code/app/core/extensions/data_types/string_extension.dart';
import 'package:flutter_code/app/core/extensions/build_context/build_context_device.dart';
import 'package:flutter_code/app/core/utils/app_log.dart';
import 'package:flutter_code/app/pages/sqlite/widgets/add_user_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common_widgets/sliver_separated_list.dart';
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
    final height = context.height; // Magenta
    return Scaffold(
      appBar: AppBar(title: Text("Sqflite example")),
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            _userList.isNotEmpty
                ? _userSliverList()
                : SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: TextWidget(text: "No User found")),
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

  Widget _userSliverList() {
    return SliverSeparatedList(
      itemCount: _userList.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemBuilder: (context, index) {
        final user = _userList[index];

        return Dismissible(
          key: ValueKey(user.id),
          direction: DismissDirection.horizontal,
          background: _editBackground(),
          // Swipe Right (startToEnd)
          secondaryBackground: _deleteBackground(),
          // Swipe Left (endToStart)
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              // Delete
              final confirmDelete = await showDialog<bool>(
                context: context,
                builder:
                    (ctx) => AlertDialog(
                      title: Text('Delete User'),
                      content: Text(
                        'Are you sure you want to delete ${user.name}?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: Text('Delete'),
                        ),
                      ],
                    ),
              );
              return confirmDelete == true;
            } else if (direction == DismissDirection.startToEnd) {
              // Edit
              addUserDialog(
                context,
                user: user,
                addUserCallBack: (updatedUser) {
                  editUser(updatedUser);
                },
              );
              return false; // Prevent item from being dismissed
            }
            return false;
          },
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart && user.id != null) {
              deleteUser(user.id!);
            }
          },
          child: Card(
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 8, right: 0),
              trailing: _trailingWidget(user),
              title: Row(
                children: [
                  TextWidget(text: "User Name :"),
                  SizedBox(width: 5),
                  TextWidget(
                    text: "${user.name?.capitalize}",
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  TextWidget(text: "Email Address :"),
                  SizedBox(width: 5),
                  TextWidget(
                    text: "${user.email}",
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => SizedBox(height: 10),
    );
  }

  Widget _deleteBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(Icons.delete, color: Colors.white),
    );
  }

  Widget _editBackground() {
    return Container(
      color: Colors.blue,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(Icons.edit, color: Colors.white),
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

    AppLog.debug("user model ==== ${jsonEncode(userMode)}");

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
      AppLog.debug("User created done");
    } else {
      AppLog.debug("User not created");
    }
    getAllUser();
  }

  Future<void> editUser(User user) async {
    AppLog.debug("edit user ====${jsonEncode(user)}");
    var isCreated = await dbHelper!.editUser(
      id: user.id,
      name: user.name,
      mobile: user.mobileNumber,
      email: user.email,
    );
    if (isCreated) {
      AppLog.debug("User edited done");
    } else {
      AppLog.debug("User not edited");
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
