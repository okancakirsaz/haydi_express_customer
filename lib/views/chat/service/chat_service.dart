import 'package:haydi_ekspres_dev_tools/constants/endpoints.dart';
import 'package:haydi_ekspres_dev_tools/models/chat_model.dart';
import 'package:haydi_ekspres_dev_tools/models/chat_room_model.dart';
import 'package:haydi_express_customer/core/managers/network_manager.dart';
import 'package:dio/dio.dart';

final class ChatService extends NetworkManager {
  Future<bool?> createRoom(ChatRoomModel data, String accessToken) async {
    try {
      final response = await network.post(
        Endpoints.instance.createChatRoom,
        data: data.toJson(),
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
      );
      return bool.parse(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<bool?> updateRoom(ChatModel data, String accessToken) async {
    try {
      final response = await network.post(
        Endpoints.instance.updateChatRoom,
        data: data.toJson(),
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
      );
      return bool.parse(response.data);
    } catch (e) {
      return null;
    }
  }
}
