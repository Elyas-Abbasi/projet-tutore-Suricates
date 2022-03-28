import 'package:flutter/material.dart';
import 'package:suricates_app/services/firestore/get_list_ad.dart';
import 'package:suricates_app/strings.dart';
import 'package:suricates_app/view/widgets/filter_button.dart';
import 'package:suricates_app/view/widgets/search_bar.dart';
import 'package:suricates_app/view/widgets/switch_tabbar.dart';

class DealsPage extends StatefulWidget {
  const DealsPage({Key? key}) : super(key: key);

  @override
  _DealsPageState createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  int _currentSelection = 0;

  changeItemSelection(int itemSelection) {
    if (_currentSelection != itemSelection) {
      setState(() {
        _currentSelection = itemSelection;
        _controller.animateToPage(_currentSelection,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      });
    }
  }

  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
              child: Container(
                  padding: const EdgeInsets.only(bottom: 20, top: 8),
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: MySearchBar(
                            getText: (varText) {},
                            textInputType: TextInputType.text,
                            hint: TextsSuricates.iSearch,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SwitchTabBar(
                                  selectItem: (selectItem) {
                                    changeItemSelection(selectItem);
                                  },
                                  title1: TextsSuricates.iSearch,
                                  title2: TextsSuricates.theySearch,
                                  position: _currentSelection,
                                  marginRight: 4,
                                  size: 14,
                                ),
                              ),
                              FilterButton(onPressed: () {}, enabled: true),
                            ]),
                      ),
                    ],
                  )),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (int index) {
                changeItemSelection(index);
              },
              children: const [
                GetListAd(type: "exchange"),
                GetListAd(type: "search"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
