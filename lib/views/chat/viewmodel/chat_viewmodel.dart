import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haydi_ekspres_dev_tools/models/chat_model.dart';
import 'package:haydi_ekspres_dev_tools/models/chat_room_model.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/core/managers/web_socket_manager.dart';
import 'package:haydi_express_customer/views/chat/service/chat_service.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'chat_viewmodel.g.dart';

class ChatViewModel = _ChatViewModelBase with _$ChatViewModel;

abstract class _ChatViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {
    _roomId = const Uuid().v4();
    initActiveChats();
    _getOlderChatList();
  }

  String targetName = "";
  String targetId = "";
  String _roomId = "";
  bool isChatExist = false;
  bool isRoomIdListening = false;
  String get userName =>
      localeManager.getStringData(LocaleKeysEnums.nameSurname.name);
  final ChatService service = ChatService();
  String get _id => localeManager.getStringData(LocaleKeysEnums.id.name);

  List<ChatRoomModel> activeChats = [];

  @observable
  ObservableList<ChatModel> chatList = ObservableList.of([]);

  TextEditingController text = TextEditingController();

  initActiveChats() => activeChats = ((localeManager
              .getNullableJsonData(LocaleKeysEnums.activeConversations.name) ??
          []) as List)
      .map((e) => ChatRoomModel.fromJson(e))
      .toList();

  _listenRoomId() {
    WebSocketManager.instance.webSocketReceiver(
      "Chat Update:$_roomId",
      (e) async => await _onChatUpdate(e),
    );
    WebSocketManager.instance.webSocketReceiver(
      "Room Closed:$_roomId",
      (e) async => await _onRoomClosed(ChatRoomModel.fromJson(e)),
    );
    debugPrint("$_roomId chat room is listening!");
  }

  @action
  Future<void> _onChatUpdate(dynamic e) async {
    final ChatModel element = ChatModel.fromJson(e);
    if (element.content == text.text) {
      return;
    }
    final int index = activeChats.indexWhere((e) => e.roomId == _roomId);
    chatList.add(element);
    activeChats[index].content.add(element);
    await localeManager.setJsonData(LocaleKeysEnums.activeConversations.name,
        activeChats.map((e) => e.toJson()).toList());
  }

  Future<void> _onRoomClosed(ChatRoomModel room) async {
    final int index =
        activeChats.indexWhere((element) => element.roomId == room.roomId);
    activeChats.removeAt(index);
    await localeManager.setJsonData(
      LocaleKeysEnums.activeConversations.name,
      activeChats.map((e) => e.toJson()).toList(),
    );
    WebSocketManager.instance.closeEvent("Chat Update:${room.roomId}");
    WebSocketManager.instance.closeEvent("Room Closed:${room.roomId}");
    navigatorPop();
  }

  bool _checkIsChatExist() {
    for (int i = 0; i <= activeChats.length - 1; i++) {
      if (activeChats[i].customerId == _id &&
          activeChats[i].helperId == targetId) {
        isChatExist = true;
        _roomId = activeChats[i].roomId;
      }
    }

    return isChatExist;
  }

  @action
  _getOlderChatList() {
    if (_checkIsChatExist()) {
      final int index = activeChats.indexWhere((e) => e.roomId == _roomId);
      chatList = ObservableList.of(activeChats[index].content);
      _listenRoomId();
      isRoomIdListening = true;
    }
  }

  @action
  Future<void> createChatRoom() async {
    final bool? response =
        await service.createRoom(_fetchNewChatRoom, accessToken!);
    if (response == null || !response) {
      showErrorDialog();
      return;
    }
    activeChats.add(_fetchNewChatRoom);
    await localeManager.setJsonData(
      LocaleKeysEnums.activeConversations.name,
      activeChats
          .map(
            (e) => e.toJson(),
          )
          .toList(),
    );
    isChatExist = true;
    chatList.add(_chatElement);
  }

  ChatModel get _chatElement => ChatModel(
        owner: userName,
        roomId: _roomId,
        content: text.text,
        link: null,
      );

  ChatRoomModel get _fetchNewChatRoom => ChatRoomModel(
        roomId: _roomId,
        customerId: _id,
        customerName: userName,
        helperId: targetId,
        helperName: targetName,
        isConversationStarterHelper: false,
        roomCreationDate: DateTime.now().toIso8601String(),
        isRoomClosed: false,
        content: [_chatElement],
      );

  @action
  Future<void> updateChat() async {
    ChatModel chatElement = _chatElement;
    final bool? response = await service.updateRoom(chatElement, accessToken!);
    if (response == null || !response) {
      showErrorDialog();
      return;
    }
    chatList.add(chatElement);
  }

  Future<void> sendMessage() async {
    if (isChatExist) {
      await updateChat();
    } else {
      debugPrint(_roomId);
      await createChatRoom();
    }
    if (!isRoomIdListening) {
      _listenRoomId();
      isRoomIdListening = true;
    }
    text.text = "";
  }

  bool detectIsUserSender(String owner) {
    if (owner != userName) {
      return false;
    }
    return true;
  }
}
