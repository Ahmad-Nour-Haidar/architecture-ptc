
import 'package:flutter/material.dart';
import '../../../../../core/data/enums/key_parameter_route_enum.dart';
import '../../../../../core/routing/app_router.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/widgets/widgets_Informative/loading_data_view.dart';
import '../../data/datasource/configuration/get_user.dart';
import '../../data/models/users.dart';
import '../widgets/user_widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<UserModel>? users;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      users=await getUsers();
      setState(() {});
    });

   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text(
          'Users',
          style: TextStyle(
              color: ColorManager.primary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body:
      builderItems(context)
    );
  }

  Widget builderItems(BuildContext context){
    return
      users==null?
          const LoadingDataView()
      :ListView.builder(
        itemCount: users?.length??0,
        itemBuilder: (context,index)=>
            UserWidget(
        item: '${users?[index].id??''}',
              onTap: ()=>goRouter.pushNamed(AppRoute.detailsUser.name ,extra:  {KeyParameterRoute.id.name:users?[index].id??-1} ),

            ));
  }
}


