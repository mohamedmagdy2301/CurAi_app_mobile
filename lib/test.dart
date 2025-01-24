import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/responsive_helper/size_provider.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          'My Widget',
          style: context.textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: context.padding(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const NewWidget(),
            const SizedBox(height: 20),
            SizedBox(
              height: 420,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: SizedBox(
                      width: 420,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.network(
                            'https://picsum.photos/200/300',
                            height: 420 / 2.4,
                            width: 420,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: context.padding(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Image',
                                  style: context.textTheme.titleMedium,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  //any text here
                                  'Lorem ipsum dolor sit amet, ultricies. Nulla facilisi.',
                                  style: context.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 180,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Click Me',
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: const Size(250, 250),
      height: context.setR(250),
      width: context.setR(250),
      child: Builder(
        builder: (context) {
          return SizedBox(
            height: context.sizeProvider.height,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Card(
                  margin: context.padding(horizontal: 10, vertical: 5),
                  child: SizedBox(
                    width: context.sizeProvider.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.network(
                          'https://picsum.photos/200/300',
                          height: context.sizeProvider.height / 2.4,
                          width: context.sizeProvider.width,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: context.padding(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Image',
                                style: TextStyle(
                                  fontSize: context.setSp(20),
                                ),
                              ),
                              context.spaceHeight(10),
                              Text(
                                //any text here
                                'Lorem ipsum dolor sit amet, ultricies. Nulla facilisi.',
                                style: TextStyle(
                                  fontSize: context.setSp(14),
                                ),
                              ),
                              context.spaceHeight(10),
                              SizedBox(
                                height: context.setH(30),
                                width: context.setW(100),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Click Me',
                                    style: TextStyle(
                                      fontSize: context.setSp(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
