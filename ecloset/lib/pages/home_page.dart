import 'package:ecloset/values/app_colors.dart';
import 'package:ecloset/values/app_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu))),
        actions: [
          Builder(
              builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: const CircleAvatar(
                      backgroundImage:
                          NetworkImage("https://picsum.photos/id/237/200/300"),
                    ),
                  )),
        ],
      ),
      drawer: Drawer(),
      endDrawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        child: const Icon(Icons.camera_alt),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primaryColor,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 50,
          child: Row(
            //children inside bottom appbar
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[
              IconButton(
                padding: const EdgeInsets.only(left: 28.0),
                icon: const Icon(
                  Icons.home,
                  color: AppColors.secondaryColor,
                ),
                onPressed: () {},
              ),
              IconButton(
                padding: const EdgeInsets.only(right: 28.0),
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              IconButton(
                padding: const EdgeInsets.only(left: 28.0),
                icon: const Icon(
                  Icons.list_alt,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              IconButton(
                padding: const EdgeInsets.only(right: 28.0),
                icon: const Icon(
                  Icons.people,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(children: const [
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: _Trending(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24),
            child: _MyCloset(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24),
            child: _Recommend(),
          ),
        ]),
      ),
    );
  }
}

class _Recommend extends StatelessWidget {
  const _Recommend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Recommend",
          style: AppStyles.h2.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 30,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 24),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // radius of 10
                  color: AppColors.brown,
                  // green as background color
                ),
                child: Text('Casual',
                    style: AppStyles.h4.copyWith(
                      color: AppColors.black,
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MyCloset extends StatelessWidget {
  const _MyCloset({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "My Closet",
          style: AppStyles.h2.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                  // image: DecorationImage(
                  //   image: NetworkImage(''),
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            Expanded(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                  // image: DecorationImage(
                  //   image: NetworkImage(''),
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _Trending extends StatelessWidget {
  const _Trending({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Trending",
          style: AppStyles.h2.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 128,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
            // image: DecorationImage(
            //   image: NetworkImage(''),
            //   fit: BoxFit.cover,
            // ),
          ),
        )
      ],
    );
  }
}
