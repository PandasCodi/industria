import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:industria/core/constants/colors.dart';
import 'package:industria/core/constants/images.dart';
import 'package:industria/core/utils/debounce.dart';
import 'package:industria/core/utils/toast.dart';
import 'package:industria/presentation/widgets/app_elevated_button.dart';
import 'package:pandas_tableview/p_tableview.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/themes/theme.dart';
import '../../../domain/entities/vacancy/vacancy.dart';
import '../../../domain/repositories/admin_vacancy/admin_vacancy_repository_contract.dart';
import '../../bloc/vacancies_feature/admin_delete_vacancy/admin_delete_vacancy_bloc.dart';
import '../../bloc/vacancies_feature/admin_vacancy_list/admin_vacancy_list_bloc.dart';
import '../../widgets/custom_checkbox.dart';

class AdminVacancies extends StatefulWidget {
  const AdminVacancies({Key? key}) : super(key: key);

  @override
  State<AdminVacancies> createState() => _AdminVacanciesState();
}

class _AdminVacanciesState extends State<AdminVacancies> {
  List<bool> checkable = [];
  List<Vacancy> employee = [];

  @override
  void initState() {
    super.initState();
    if (context
        .read<AdminVacancyListBloc>()
        .state
        .tableData
        .element
        .isEmpty) {
      context.read<AdminVacancyListBloc>().add(
          const AdminVacancyListEvent.fetchData(elementsPerPage: 7, page: 0));
    }
  }
  @override
  void didChangeDependencies() {
    employee = context
        .read<AdminVacancyListBloc>()
        .state
        .tableData
        .element;
    checkable = List.generate(
        context
            .read<AdminVacancyListBloc>()
            .state
            .tableData
            .totalElementCounts,
            (index) => false);
  }

  void toggleAllCheckboxes(bool newValue) {
    setState(() {
      checkable.fillRange(0, checkable.length, newValue);
    });
  }

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  final deleteEmployeeBloc = AdminDeleteVacancyBloc(
      adminVacancyRepository: sl<AdminVacancyRepository>());

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminDeleteVacancyBloc, AdminDeleteVacancyState>(
      bloc: deleteEmployeeBloc,
      listener: (context, state) {
        state.maybeMap(
            loading: (_) {
              showProgressSnackBar(context, "Deleting vacancy ...");
            },
            success: (_) {
              showSuccessSnackBar(context, "Successfully deleted vacancy");
              context.read<AdminVacancyListBloc>().add(
                  const AdminVacancyListEvent.fetchData(
                      page: 0, elementsPerPage: 5));
            },
            fail: (_) {
              showErrorSnackBar(context, "Failed to delete vacancy");
            },
            orElse: () {});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              _tableTitle(
                  title: 'Vacancies',
                  subtitle: context
                      .watch<AdminVacancyListBloc>()
                      .state
                      .tableData
                      .totalElementCounts
                      .toString()),
              const SizedBox(
                width: 60,
              ),
              Expanded(child: _search(onTextChanged: (val) {
                _debouncer.run(() {
                  context.read<AdminVacancyListBloc>().add(
                      AdminVacancyListEvent.changeSearchTerm(searchTerm: val));
                });
              })),
              const SizedBox(
                width: 60,
              ),
              SizedBox(
                  width: 200,
                  child: AppElevatedButton(
                    text: "Create vacancy",
                    prefixIcon: const Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                    ),
                    textStyle: const TextStyle(fontSize: 14),
                    onPressed: () {
                      context.push('/admin/create_vacancy', extra: 'Create vacancy');
                    },
                    verticalPadding: 15,
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          checkable.contains(true)
              ? Row(
                children: [
                  Text(
                      '${checkable.where((value) => value).length == context.read<AdminVacancyListBloc>().state.tableData.totalElementCounts ? "All" : checkable.where((value) => value).length} selected',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkGrey,
                      )),
                  const SizedBox(
                    width: 25,
                  ),
                  TextButton(
                    onPressed: () {
                      deleteBucketDialog(context,
                          text:
                          'Are you sure you want to delete feedback?',
                          // feedbacks: feedback,
                          checkable: checkable);
                    },
                    child: Text(
                      checkable.where((value) => value).length ==
                          context
                              .read<AdminVacancyListBloc>()
                              .state
                              .tableData
                              .totalElementCounts
                          ? 'Delete All'
                          : 'Delete Selected',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.red,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.red),
                    ),
                  ),
                ],
              )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: PTableView(
              pagination: PTableViewPagination(
                currentPage: context
                    .watch<AdminVacancyListBloc>()
                    .state
                    .tableData
                    .currentPage,
                pagesCount: context
                    .watch<AdminVacancyListBloc>()
                    .state
                    .tableData
                    .numberOfPages,
                onPageChanged: (i) {
                  context.read<AdminVacancyListBloc>().add(
                      AdminVacancyListEvent.fetchData(
                          page: i, elementsPerPage: 5));
                },
              ),
              fixedHeight: 500,
              borderRadius: BorderRadius.circular(4),
              headerHeight: 45,
              header: PTableViewHeader(
                contentPadding: EdgeInsets.symmetric(horizontal: 18),
                backgroundColor: Color(0xFFF1F1F1),
                rows: [
                  PTableViewRowFixed(
                    width: 100,
                    child: Row(
                      children: [
                        CustomCheckbox(value: checkable.every((value) => value == true), onChanged: (v) {toggleAllCheckboxes(v!);}),
                        const SizedBox(width: 11,),
                        const Text(
                          "NAME",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const PTableViewRowFixed(
                      width: 450,
                      child: Center(
                        child: Text(
                          "COMPANY",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      )),
                  const PTableViewRowFixed(
                      width: 800,
                      child: Padding(
                        padding: EdgeInsets.only(left: 350.0),
                        child: Text(
                          "ACTIONS",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      )),
                ],
              ),
              content: PTableViewContent(
                  onTap: (i) {
                    context.go("/admin/view_vacancy",
                        extra: context
                            .read<AdminVacancyListBloc>()
                            .state
                            .tableData
                            .element[i]);
                  },
                  divider: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                  backgroundColor: Colors.white,
                  horizontalPadding: 18,
                  columns: context
                      .watch<AdminVacancyListBloc>()
                      .state
                      .tableData
                      .element
                      .asMap()
                      .entries
                      .map((e) =>
                      _feedbackList(vacancy: e.value,
                          index: e.key,
                          checkable: checkable))
                      .toList()),
            ),
          )
        ],
      ),
    );
  }

  PTableViewColumn _feedbackList({required Vacancy vacancy,
    required int index,
    required List<bool> checkable}) {
    return PTableViewColumn(rows: [
      PTableViewRowFixed(
          width: 300,
          child: SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.only(right: 38.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCheckbox(
                      value: checkable[index],
                      onChanged: (v) {
                        setState(() {
                          checkable[index] = v!;
                        });
                      }),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Text(
                      vacancy.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          )),
      PTableViewRowFixed(
          width: 601,
          child: SizedBox(
            height: 60,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                vacancy.company.name,
                style:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )),
      PTableViewRowFixed(
          width: 400,
          child: SizedBox(
            height: 60,
            child: _tableAction(
                title: 'Change vacancy',
                icon: FontAwesomeIcons.solidPenToSquare,
                onTap: () {
                  context.push("/admin/edit_vacancy");
                }),
          )),
    ]);
  }
}

Widget _tableAction({required String title,
  required IconData icon,
  required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: SelectionContainer.disabled(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: AppColors.darkGrey,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: AppColors.darkGrey,fontSize: 14),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _search({required Function(String) onTextChanged}) {
  return SizedBox(
    height: 39,
    child: TextField(
      onChanged: onTextChanged,
      decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          hintText: 'Search',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(11),
            child: SvgPicture.asset(
              AppImages.search,
              color: AppColors.darkGrey,
              width: 16,
              height: 16,
            ),
          ),
          hintStyle: const TextStyle(color: AppColors.darkGrey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
    ),
  );
}

Widget _tableTitle({required String title, required String subtitle}) {
  return SizedBox(
    height: 25,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 1,
          height: double.infinity,
          color: AppColors.darkGrey,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          subtitle,
          style: const TextStyle(
              color: AppColors.darkGrey, fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}
deleteBucketDialog(BuildContext context,
    {required String text,
      List<Feedback>? feedbacks,
      required List<bool>? checkable}) {
  Widget cancelButton = TextButton(
    child: const Text(
      'Cancel',
      style: TextStyle(color: AppColors.red),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: const Text(
      'Delete',
      style: TextStyle(color: AppColors.mainAccent),
    ),
    onPressed: () {
      // context
      //     .read<AdminDeleteFeedbackBloc>()
      //     .add(AdminDeleteFeedbackEvent.deleteFeedback(feedbackId: feedbacks!));
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    title: Text('Warning', style: AppTheme.themeData.textTheme.titleSmall),
    content: Text(text, style: AppTheme.themeData.textTheme.bodySmall),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}