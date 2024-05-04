import 'package:flutter/material.dart';
import 'package:rajamarkapp/dashboard/student_answer.dart';

class TopRowWidget extends StatelessWidget {
  const TopRowWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SearchBarWidget(),
        ProfileIconTextButtonWidget(),
      ],
    );
  }
}

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  Color getColor(Set<MaterialState> states) {
    return const Color(0xffF1F3F6);
  }

  Color getColorShadow(Set<MaterialState> states) {
    return const Color(0x00000000);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
          viewConstraints: const BoxConstraints(maxHeight: 250),
          viewBackgroundColor: const Color(0xffF1F3F6),
          dividerColor: const Color(0xff535669),
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              hintText: 'Find tests',
              constraints: const BoxConstraints(maxWidth: 350),
              shadowColor: MaterialStateProperty.resolveWith((getColorShadow)),
              controller: controller,
              backgroundColor: MaterialStateProperty.resolveWith((getColor)),
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              trailing: <Widget>[
                IconButton(
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    controller.openView();
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            );
          },
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(
              20,
              (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              },
            );
          }),
    );
  }
}

class ProfileIconTextButtonWidget extends StatelessWidget {
  const ProfileIconTextButtonWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {},
        style: TextButton.styleFrom(
          iconColor: Colors.black,
          foregroundColor: Colors.black,
        ),
        icon: const Icon(Icons.account_circle_rounded),
        label: const Text('Umi Arifah Basri'));
  }
}
