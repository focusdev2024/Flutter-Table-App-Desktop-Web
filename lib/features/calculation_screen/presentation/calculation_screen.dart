import 'package:flutter/material.dart';
import 'package:responsible_unicorn/constants/app_color.dart';

final List<String> tabs = [
  'Налоги',
  'Сбыт',
  'Задолженности',
  'Импорт',
  'Перевозка',
  'Продукт',
  'Разработки',
];

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  int? _selectedTabIndex; // No tab selected at launch

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(tabs.length, (index) {
                return OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedTabIndex = index;
                      _tabController.index = index;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color:
                          _selectedTabIndex == index
                              ? AppColors.blue
                              : Colors.grey,
                    ),
                    backgroundColor:
                        _selectedTabIndex == index
                            // ignore: deprecated_member_use
                            ? AppColors.blue.withOpacity(0.1)
                            : Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color:
                          _selectedTabIndex == index
                              ? AppColors.blue
                              : Colors.black,
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(tabs.length, (index) {
                if (index == 0) {
                  return TaxTableLayout(
                    key: ValueKey('catalog'),
                  ); // tabbed version
                }
                return Center(child: Text("Раздел: ${tabs[index]}"));
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class TaxTableLayout extends StatelessWidget {
  const TaxTableLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 60,

                  columns: const [
                    DataColumn(
                      label: Text(
                        "Сбыт*",
                        style: TextStyle(color: AppColors.mainTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Импорт*",
                        style: TextStyle(color: AppColors.mainTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Экспорт*",
                        style: TextStyle(color: AppColors.mainTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "От сотрудника*",
                        style: TextStyle(color: AppColors.mainTextColor),
                      ),
                    ),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              Text(
                                'Налог*',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Коменсация*',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              Text(
                                'Еврасис*',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Другое*',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              Text(
                                'Еврасис*',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Другое*',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Text(
                            'Налог*',
                            style: TextStyle(color: AppColors.mainTextColor),
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '%',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '%',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '%',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '%',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Налог*',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Коменсация*',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Налог*',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Коменсация*',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Text(
                            '-',
                            style: TextStyle(color: AppColors.mainTextColor),
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '-',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '-',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '-',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '-',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '%',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '%',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '%',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '%',
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Text(
                            '-',
                            style: TextStyle(color: AppColors.mainTextColor),
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('10'),
                              SizedBox(width: 8),
                              Text('12'),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('10'),
                              SizedBox(width: 8),
                              Text('12'),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('9'),
                              SizedBox(width: 8),
                              Text('9'),
                              SizedBox(width: 8),
                              Text('10'),
                              SizedBox(width: 8),
                              Text('12'),
                            ],
                          ),
                        ),
                        DataCell(Text('5')), // ← You were missing this cell
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
