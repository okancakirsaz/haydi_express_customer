// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatViewModel on _ChatViewModelBase, Store {
  late final _$chatListAtom =
      Atom(name: '_ChatViewModelBase.chatList', context: context);

  @override
  ObservableList<ChatModel> get chatList {
    _$chatListAtom.reportRead();
    return super.chatList;
  }

  @override
  set chatList(ObservableList<ChatModel> value) {
    _$chatListAtom.reportWrite(value, super.chatList, () {
      super.chatList = value;
    });
  }

  late final _$_onChatUpdateAsyncAction =
      AsyncAction('_ChatViewModelBase._onChatUpdate', context: context);

  @override
  Future<void> _onChatUpdate(dynamic e) {
    return _$_onChatUpdateAsyncAction.run(() => super._onChatUpdate(e));
  }

  late final _$createChatRoomAsyncAction =
      AsyncAction('_ChatViewModelBase.createChatRoom', context: context);

  @override
  Future<void> createChatRoom() {
    return _$createChatRoomAsyncAction.run(() => super.createChatRoom());
  }

  late final _$updateChatAsyncAction =
      AsyncAction('_ChatViewModelBase.updateChat', context: context);

  @override
  Future<void> updateChat() {
    return _$updateChatAsyncAction.run(() => super.updateChat());
  }

  late final _$_ChatViewModelBaseActionController =
      ActionController(name: '_ChatViewModelBase', context: context);

  @override
  dynamic _getOlderChatList() {
    final _$actionInfo = _$_ChatViewModelBaseActionController.startAction(
        name: '_ChatViewModelBase._getOlderChatList');
    try {
      return super._getOlderChatList();
    } finally {
      _$_ChatViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chatList: ${chatList}
    ''';
  }
}
