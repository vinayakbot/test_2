import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_page_view_astro/infinity_page_view_astro.dart';
import 'package:test_2/di/di.dart';
import 'package:test_2/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:test_2/presentation/dashboard/ui/widget/playerCard_widget.dart';
import 'package:test_2/utils/theme.dart';

class DashboardMainView extends StatefulWidget {
  const DashboardMainView({super.key});

  @override
  State<DashboardMainView> createState() => _DashboardMainViewState();
}

class _DashboardMainViewState extends State<DashboardMainView> {
  late DashboardBloc bloc;

  @override
  void initState() {
    bloc = locator.get<DashboardBloc>();

bloc.add(DashboardInitialEvent());
    // bloc.add(DashboardPageChangeEvent(pageNumber: 0 , score: 0));
    // TODO: implement initState
    super.initState();
  }

  var pageContro = InfinityPageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 145, 168, 30),
      body: BlocConsumer<DashboardBloc, DashboardState>(
        bloc: bloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container(
            child: InfinityPageView(
                controller: pageContro,
                onPageChanged: (value) {
                  bloc.add(DashboardPageChangeEvent(pageNumber: value , player: 0 ));
                },
                itemCount: 4,
                itemBuilder: (context, index) {
                  if (state is DashboardPageChangedState) {
                    return state.card;
                  } else {
                    return SizedBox.shrink();
                  }
                }),
          );
        },
      ),
    );
  }
}
