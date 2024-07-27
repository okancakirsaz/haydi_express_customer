import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:haydi_ekspres_dev_tools/widgets/custom_scaffold.dart';
import 'package:haydi_ekspres_dev_tools/widgets/custom_statefull_button.dart';
import 'package:haydi_express_customer/views/chat/viewmodel/chat_viewmodel.dart';
import '../../../../core/base/view/base_view.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

part './components/chat_text.dart';

class ChatView extends StatelessWidget {
  final String targetId;
  final String targetName;
  const ChatView({super.key, required this.targetId, required this.targetName});

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatViewModel>(
      viewModel: ChatViewModel(),
      onPageBuilder: (context, model) {
        return CustomScaffold(
            appBar: AppBar(
              title: Text(
                targetName,
                style: TextConsts.instance.regularBlack20Bold,
              ),
              centerTitle: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
              children: <Widget>[
                Expanded(child: _buildChatList(model)),
                _buildInputs(model),
              ],
            ));
      },
      onModelReady: (model) {
        model.initTargetUserData(
          targetName,
          targetId,
        );
        model.init();
        model.setContext(context);
      },
      onDispose: (model) {},
    );
  }

  Widget _buildChatList(ChatViewModel model) {
    return Observer(builder: (context) {
      return ListView.builder(
        itemCount: model.chatList.length,
        itemBuilder: (context, index) {
          return ChatText(
            isUserTheSender: model.detectIsUserSender(
              model.chatList[index].owner,
            ),
            text: model.chatList[index].content,
          );
        },
      );
    });
  }

  Widget _buildInputs(ChatViewModel model) {
    return Container(
      margin: PaddingConsts.instance.all20,
      height: 100,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: PaddingConsts.instance.right10,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorConsts.instance.primary,
                      width: 2,
                    ),
                  ),
                ),
                child: TextField(
                  style: TextConsts.instance.regularBlack16,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusColor: ColorConsts.instance.primary,
                    hintText: "Mesajınızı buraya yazabilirsiniz.",
                    hintStyle: TextConsts.instance.regularDarkGrey16Bold,
                  ),
                  controller: model.text,
                ),
              ),
            ),
          ),
          CustomStateFullButton(
            onPressed: () async => await model.sendMessage(),
            text: "Gönder",
            style: TextConsts.instance.regularWhite16,
            width: 100,
          )
        ],
      ),
    );
  }
}
