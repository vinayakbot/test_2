import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_page_view_astro/infinity_page_view_astro.dart';
import 'package:test_2/data/rawData/pl_data.dart';
import 'package:test_2/di/di.dart';
import 'package:test_2/domain/models/player_data_model.dart';
import 'package:test_2/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:test_2/presentation/dashboard/ui/widget/custom_text_field.dart';
import 'package:test_2/utils/theme.dart';

class PlayerCardWidget extends StatefulWidget {
  PlayerDataModel teamData;
  int pageNumber;
  InfinityPageController mainViewController;
  PlayerCardWidget(
      {super.key,
      required this.teamData,
      required this.pageNumber,
      required this.mainViewController});

  @override
  State<PlayerCardWidget> createState() => _PlayerCardWidgetState();
}

class _PlayerCardWidgetState extends State<PlayerCardWidget> {
  late DashboardBloc bloc;
  late Color col;

  InfinityPageController pageCol = InfinityPageController();

  @override
  void initState() {
    bloc = locator.get<DashboardBloc>();

    var colorString = "0xFF${widget.teamData.color}";
    var colorIntCode = int.parse(colorString);

    col = Color(colorIntCode);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      color: col,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            text: 'SPORTS',
            col: ThemeConstants.white,
            fontsize: 35,
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: BlocConsumer<DashboardBloc, DashboardState>(
              bloc: bloc,
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return Container(

                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
 
 boxShadow: const [
  BoxShadow(color: ThemeConstants.black , blurRadius: 10 , spreadRadius: 0.2)
 ],
                      color: ThemeConstants.black,
                      borderRadius: BorderRadius.circular(30)),
                  height: 400,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              widget.mainViewController
                                  .jumpToPage(widget.pageNumber - 1);
                            },
                            child: Icon(
                              Icons.arrow_left,
                              color: ThemeConstants.white,
                            ),
                          ),
                          Column(children: [
                             CustomTextField(
                          text: '${widget.teamData.teamName}',
                          col: ThemeConstants.white),
                      Text(
                        '${widget.teamData.team}',
                        style: TextStyle(
                            fontSize: 16, color: ThemeConstants.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                          ],),
                          InkWell(
                            onTap: () {
                              widget.mainViewController
                                  .jumpToPage(widget.pageNumber + 1);
                            },
                            child: Icon(
                              Icons.arrow_right,
                              color: ThemeConstants.white,
                            ),
                          ),
                        ],
                      ),
                     
                      // ListView.builder(itemBuilder:(context, index) {

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 1, color: ThemeConstants.white),
                            color: col,
                          ),
                          child: Column(children: [
                            if (state is DashboardPageChangedState) ...[
                              Row(
                                children: [
                                  CustomTextField(
                                      text: 'Total Players',
                                      col: ThemeConstants.white),
                                  Spacer(),
                                  CustomTextField(
                                      text:
                                          '${state.selectedPlayer}/${widget.teamData.players!.length!}',
                                      col: ThemeConstants.white),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(0, 255, 255, 255),
                                ),
                                height: 8,
                                width: double.infinity,
                                child: LayoutBuilder(
                                  // separatorBuilder:(context, index) => SizedBox(width: 5,),

                                  // scrollDirection: Axis.horizontal,

                                  // itemCount: widget.teamData.players!.length,

                                  // itemBuilder: (context, index) {

                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    List<Widget> data = [];

                                    for (var i = 0;
                                        i < widget.teamData.players!.length;
                                        i++) {
                                      data.add(InkWell(
                                        onTap: () {
                                      pageCol.jumpToPage(i);
                                          // bloc.add(PlayerChangeEvent(
                                          //     player: i,
                                          //     pageNumber: widget.pageNumber)
                                          //     );
                                        },
                                        child: Container(
                                          width: constraints.maxWidth /
                                                  widget.teamData.players!
                                                      .length -
                                              10,
                                          height: 15,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: i == state.selectedPlayer
                                                  ? ThemeConstants.white
                                                  : ThemeConstants.whiteLight),
                                        ),
                                      ));
                                    }

                                    return Row(
                                      children: [...data],
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 220,
                                child: InfinityPageView(
                                    controller: pageCol,
                                    onPageChanged: (value) {
                                      bloc.add(PlayerChangeEvent(
                                        player: value,
                                        pageNumber: widget.pageNumber,
                                      ));
                                    },
                                    itemCount: widget.teamData.players!.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomTextField(
                                            text:
                                                '${widget.teamData.players![index].name}',
                                            col: ThemeConstants.white,
                                            fontsize: 20,
                                          ),

                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  pageCol.jumpToPage(index - 1);
                                                },
                                                child: Icon(
                                                  Icons.arrow_left,
                                                  color: ThemeConstants.white,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  bloc.add(
                                                      PlayerScoreDecreaseEvent(
                                                          player: state
                                                              .selectedPlayer,
                                                          pageNumber:
                                                              widget.pageNumber,
                                                          score: state.score));
                                                },
                                                child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        color: ThemeConstants
                                                            .white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(200)),
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: col,
                                                    )),
                                              ),
                                              CustomTextField(
                                                text: '${state.score}',
                                                col: ThemeConstants.white,
                                                fontsize: 20,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  bloc.add(
                                                      PlayerScoreIncreaseEvent(
                                                          player: state
                                                              .selectedPlayer,
                                                          pageNumber:
                                                              widget.pageNumber,
                                                          score: state.score));
                                                },
                                                child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        color: ThemeConstants
                                                            .white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(200)),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: col,
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  pageCol.jumpToPage(index + 1);
                                                },
                                                child: Icon(Icons.arrow_right,
                                                    color:
                                                        ThemeConstants.white),
                                              ),
                                            ],
                                          ),

                                          //  Text('${state.score}'),
                                        ],
                                      );
                                    }),
                              ),
                            ]
                          ]),
                        ),
                      ),

                  
                      // },)
                    ],
                  ),
                );
              },
            ),
          ),

          
SizedBox(height: 10,),

Container(
  alignment: Alignment.center,
  // color: ThemeConstants.white,
  height: 15,
  width: 100,
  child: ListView.builder(
    
    scrollDirection: Axis.horizontal,
    itemCount: PlData.data.length ,
    itemBuilder:(context, index) {
      return Center(
        child: InkWell(
          onTap: (){
             widget.mainViewController.jumpToPage(index);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            width: index == widget.pageNumber ? 20 : 15 ,
            height: 10,
            decoration: BoxDecoration(
            color: index == widget.pageNumber ? ThemeConstants.white :ThemeConstants.whiteLight  ,
            borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      );
  },))
        ],
      ),
    );
  }
}
