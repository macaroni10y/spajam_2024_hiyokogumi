import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';

/// firestoreのサンプルcollectionを表示するだけのページ
class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository.instance;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('userList'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder<List<User>>(
                  stream: userRepository.listenToUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<User> users = snapshot.data!;
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final User user = users[index];
                          return CupertinoListTile(
                            title: Text('name: ${user.name}'),
                            subtitle: Text('age: ${user.age}'),
                            trailing: CupertinoButton(
                              child: const Text('削除'),
                              onPressed: () {
                                userRepository.deleteUser(user.id);
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  final randomValue = Random().nextInt(99);
                  userRepository
                      .addUser(User.create('sample $randomValue', randomValue));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.add),
                    Text('add random user'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
