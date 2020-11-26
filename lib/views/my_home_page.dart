import 'package:corefactors/app_colors.dart';
import 'package:corefactors/models/users_list.dart';
import 'package:corefactors/view_models/my_home_page_vm.dart';
import 'package:corefactors/views/add_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;
  int currentPage;
  double cardHeight;
  Duration duration;
  TextStyle textStyle = TextStyle(color: AppColors.white, fontSize: 20);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardHeight = 120;
    _pageController = PageController(initialPage: 0);
    currentPage = 0;
    duration = Duration(milliseconds: 300);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<MyHomePageVm>(
          builder: (_, vm, child){
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 12,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.deepBlack,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Type something here",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  getTabBar(vm),
                  Expanded(child: getBottomListRepresentation()),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUser()),
          );
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getBottomListRepresentation() {
    return Consumer<MyHomePageVm>(
      builder: (context, vm, child) {
        if (vm.myUsers == null) {
          vm.fetchUser(context);
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          child: PageView.builder(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              if (index == 0) {
                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(vm.activeUsers.length,
                            (index) => cardUI(vm, vm.activeUsers, index)),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(vm.inactiveUsers.length,
                            (index) => cardUI(vm, vm.inactiveUsers, index)),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget cardUI(MyHomePageVm vm ,List<Users> users, int index) {
    return Padding(
      padding: EdgeInsets.only(top: index == 0 ? 8.0 : 0, bottom: 8.0),
      child: Container(
        height: cardHeight,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        color:
            users[index].Gender == "Male" ? AppColors.male : AppColors.female,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  users[index].Name,
                  style: textStyle.copyWith(color: users[index].Gender=="Male"?Colors.black:Colors.white),
                ),
                Text(
                  users[index].Age.toString(),
                  style: textStyle.copyWith(color: users[index].Gender=="Male"?Colors.black:Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  users[index].Place,
                  style: textStyle.copyWith(color: users[index].Gender=="Male"?Colors.black:Colors.white),
                ),
                InkWell(
                  onTap: (){
                    showSimpleNotification(
                      Text("${users[index].Name} is ${users[index].Status?'inactive':'active'}"),
                      background: AppColors.primaryColor,
                    );
                    vm.switchUser(users[index]);
                  },
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.orange,
                    ),
                    child: Center(
                      child: Text(
                          users[index].Status?"Make Inactive":"Make active",
                        style: textStyle.copyWith(color: users[index].Gender=="Male"?Colors.black:Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getTabBar(MyHomePageVm vm) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              print("Active tapped");
              _pageController.animateToPage(0,
                  duration: duration,
                  curve: Curves.easeIn);
              setState(() {
                currentPage = 0;
              });
            },
            child: AnimatedContainer(
              duration: duration,
              width: currentPage == 0?vm.expandedTabWidth:vm.tabWidth,
              color: currentPage==0?AppColors.active:AppColors.inactive,
              child: Center(
                child: Text(
                  "Active",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print("Inactive tapped");
              _pageController.animateToPage(1,
                  duration: duration,
                  curve: Curves.easeIn);
              setState(() {
                currentPage = 1;
              });
            },
            child: AnimatedContainer(
              duration: duration,
              width: currentPage == 1?vm.expandedTabWidth:vm.tabWidth,
              color: currentPage==1?AppColors.active:AppColors.inactive,
              child: Center(
                child: Text(
                  "Inactive",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
