part of '../menu_view.dart';

class Counter extends StatelessWidget {
  final MenuViewModel viewModel;
  const Counter({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildButton(false),
          Observer(
            builder: (context) {
              return Text(
                "${viewModel.counter}",
                style: TextConsts.instance.regularBlack18Bold,
              );
            },
          ),
          _buildButton(true),
        ],
      ),
    );
  }

  Widget _buildButton(bool isIncrement) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () => viewModel.changeCounterState(isIncrement),
      mini: true,
      backgroundColor: ColorConsts.instance.lightThird,
      child: Icon(
        isIncrement ? Icons.add : Icons.remove,
        color: Colors.white,
      ),
    );
  }
}
