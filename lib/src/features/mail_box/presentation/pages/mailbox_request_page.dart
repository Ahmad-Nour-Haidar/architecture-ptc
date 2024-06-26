import 'dart:async';

import 'package:architecture_ptc/core/widgets/widgets_Informative/empty_data_view.dart';
import 'package:architecture_ptc/core/widgets/widgets_Informative/loading_data_view.dart';
import 'package:architecture_ptc/src/features/mail_box/data/datasource/dummy/dummy_request_box_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/image/profile_image.dart';
import '../../../../../core/widgets/refresh/refresh_base.dart';
import '../../../../../core/widgets/shimmer/load_List.dart';
import '../../data/models/info_box_model.dart';
import '../../data/models/request_box_model.dart';
import '../cubits/request_box_cubit/request_box_cubit.dart';
import 'create_mail_box_page.dart';
import 'mailbox_details.dart';

class MailBoxRequestPage extends StatefulWidget {
  const MailBoxRequestPage({super.key});

  @override
  State<MailBoxRequestPage> createState() => _MailBoxRequestPageState();
}

class _MailBoxRequestPageState extends State<MailBoxRequestPage> {
  InfoBox? infoBox;
  List<RequestBox>? sendRequestBoxes;
  List<RequestBox>? recRequestBoxes;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<RequestBox> tempSendRequestBoxes =
          DummyRequestBoxGenerator().generateDummyListData(count: 10)!;
      List<RequestBox> tempRecRequestBoxes =
          DummyRequestBoxGenerator().generateDummyListData(count: 0)!;
      await Future.delayed(const Duration(seconds: 2), () {
        infoBox = InfoBox(
          countNewRecivedBoxes: tempRecRequestBoxes.length,
          countNewSendBoxes: tempSendRequestBoxes.length,
          countRecivedBoxes: tempRecRequestBoxes.length,
          countSendBoxes: tempSendRequestBoxes.length,
        );
      });
      setState(() {});
      await Future.delayed(const Duration(seconds: 2), () {
        sendRequestBoxes = tempSendRequestBoxes;
        recRequestBoxes = tempRecRequestBoxes;
      });
      setState(() {});
    });

    // context.read<RequestBoxCubit>().getInfoBox(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (infoBox == null) {
      return const LoadingDataView();
    } else {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CreateMailBoxPage()));
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Request')),
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: ColorManager.primary,
              unselectedLabelColor: ColorManager.grey,
              labelColor: ColorManager.secondary,
              tabs: [
                Tab(
                  icon: Badge(
                    label: Text('${infoBox?.countNewSendBoxes ?? 0}'),
                    child: const Icon(
                      Icons.upload_file_outlined,
                    ),
                  ),
                  text: 'Outgoing orders (${infoBox?.countSendBoxes ?? 0})',
                ),
                Tab(
                  icon: Badge(
                    label: Text('${infoBox?.countNewRecivedBoxes ?? 0}'),
                    child: const Icon(
                      Icons.archive_outlined,
                    ),
                  ),
                  text:
                      'Requests received (${infoBox?.countRecivedBoxes ?? 0})',
                ),
              ],
            ),
            toolbarHeight: 0.0,
          ),
          body: Container(
            padding: const EdgeInsets.all(AppPadding.p12),
            margin: const EdgeInsets.all(AppMargin.m12),
            decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withOpacity(.15),
                    blurRadius: 8,
                  )
                ]),
            child: RefreshBase(
              onRefresh: () async {},
              child: TabBarView(
                children: [
                  RefreshBase(
                      onRefresh: () async {
                        // context.read<RequestBoxCubit>().onRefresh(context);
                      },
                      child: BuildListSendBoxes(
                        list: sendRequestBoxes,
                      )),
                  RefreshBase(
                      onRefresh: () async {
                        // context.read<RequestBoxCubit>().onRefresh(context);
                      },
                      child: BuildListRecBoxes(
                        list: recRequestBoxes,
                      )),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

class BuildListSendBoxes extends StatelessWidget {
  const BuildListSendBoxes({super.key, this.list});

  final List<RequestBox>? list;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestBoxCubit, RequestBoxState>(
      buildWhen: (previous, current) => context
          .read<RequestBoxCubit>()
          .buildListSendBoxesFirstWhen(previous, current),
      builder: (context, state) =>
          context.read<RequestBoxCubit>().buildListSendBoxesFirst(
                context,
                pagingController: context
                    .read<RequestBoxCubit>()
                    .pagingAdapterSend
                    .pagingController,
                itemBuilder: (_, item, index) => Column(
                  children: [
                    MailBoxRequestWidget(
                      requestBox: item ?? RequestBox(title: 'Unknown'),
                    ),
                    const Divider(),
                  ],
                ),
              ),
    );
  }
}

class BuildListRecBoxes extends StatelessWidget {
  const BuildListRecBoxes({super.key, this.list});

  final List<RequestBox>? list;

  @override
  Widget build(BuildContext context) {
    if (list == null) {
      return const LoadList();
    } else if (list!.isEmpty)
      return EmptyDataView();
    else
      return ListView.separated(
          itemBuilder: (context, index) {
            return MailBoxRequestWidget(
              requestBox: list![index] ?? RequestBox(title: 'Unknown'),
            );
          },
          separatorBuilder: (_, __) => const Divider(),
          itemCount: list?.length ?? 0);
  }
}

class MailBoxRequestWidget extends StatefulWidget {
  const MailBoxRequestWidget({
    super.key,
    required this.requestBox,
  });

  final RequestBox requestBox;

  @override
  State<MailBoxRequestWidget> createState() => _MailBoxRequestWidgetState();
}

class _MailBoxRequestWidgetState extends State<MailBoxRequestWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => MailBoxDetails(
                      requestBox: widget.requestBox,
                    )));
      },
      leading: CircleAvatar(
        child: ClipOval(
          child: ProfileImage(url: widget.requestBox.sendUser?.image),
        ),
      ),
      title: Text(
        widget.requestBox.title,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat.yMd()
                .add_jm()
                .format(widget.requestBox.showDate ?? DateTime.now()),
            style: const TextStyle(fontSize: 10, color: ColorManager.black),
          ),
          const SizedBox(
            height: AppSize.s4,
          ),
          Text(
            'Replies : ${widget.requestBox.countReplayBoxes ?? 0}',
            style: const TextStyle(fontSize: 12, color: ColorManager.primary),
          )
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSize.s4,
          ),
          Text(
            widget.requestBox.sendUser?.completeName ?? 'Unknown',
          ),
          Text(
            widget.requestBox.sendUser?.email ?? 'Unknown',
            style: const TextStyle(fontSize: 12, color: ColorManager.primary),
          ),
        ],
      ),
    );
  }
}
