import 'package:flutter/material.dart';
import 'package:responsible_unicorn/constants/app_color.dart';

final List<String> tabTitles = [
  "Каталог",
  "Товары в пути",
  "Услуги",
  "Работы",
  "Проект",
  "Партнеры",
  "Склад",
];

class ResponsiveTabsPage extends StatefulWidget {
  const ResponsiveTabsPage({super.key});

  @override
  State<ResponsiveTabsPage> createState() => _ResponsiveTabsPageState();
}

class _ResponsiveTabsPageState extends State<ResponsiveTabsPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  int? _selectedTabIndex; // No tab selected at launch

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabTitles.length, vsync: this);
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
            padding: const EdgeInsets.only(top: 16.0, left: 16.0),
            child: Text(
              'Меню',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(tabTitles.length, (index) {
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
                    tabTitles[index],
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
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0),
            child: Text(
              'Допалнительное',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
          Expanded(
            child:
                _selectedTabIndex == null
                    ? const InformationScreen(
                      key: ValueKey('default'),
                    ) // default screen
                    : TabBarView(
                      controller: _tabController,
                      children: List.generate(tabTitles.length, (index) {
                        if (index == 0) {
                          return const InformationScreen(
                            key: ValueKey('catalog'),
                          ); // tabbed version
                        }
                        return Center(
                          child: Text("Раздел: ${tabTitles[index]}"),
                        );
                      }),
                    ),
          ),
        ],
      ),
    );
  }
}

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isFromTab = key.toString().contains('catalog');
    return DefaultTabController(
      length: 3,
      child:
          isFromTab
              ? Padding(
                padding: EdgeInsets.all(16),
                child: ProductAdvancedTableView(),
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TabBar(
                      labelColor: AppColors.blue,
                      unselectedLabelColor: AppColors.grey,
                      indicatorColor: AppColors.blue,
                      // ignore: deprecated_member_use
                      dividerColor: AppColors.blue.withOpacity(0.1),
                      dividerHeight: 1,
                      tabs: const [
                        Tab(text: "Заканчивающиеся товары"),
                        Tab(text: "Перевозки(за 2 дня)"),
                        Tab(text: "Критические задолженности"),
                      ],
                    ),
                  ),

                  Expanded(
                    child: TabBarView(
                      children: [
                        ProductTableView(),
                        Center(child: Text("Перевозки (пусто)")),
                        Center(child: Text("Критические задолженности")),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}

class ProductTableView extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Картошка",
      "number": "1",
      "config": "Shopping",
      "details": "Тут текст",
      "qty": 10,
    },
    {
      "name": "Морковь",
      "number": "2",
      "config": "Transfer",
      "details": "Тут текст",
      "qty": 20,
    },
    {
      "name": "Дыня",
      "number": "3",
      "config": "Service",
      "details": "Тут текст",
      "qty": 10,
    },
    {
      "name": "Арбуз",
      "number": "4",
      "config": "Transfer",
      "details": "Тут текст",
      "qty": 5,
    },
    {
      "name": "Emilly",
      "number": "5",
      "config": "Transfer",
      "details": "Тут текст",
      "qty": 35,
    },
  ];

  ProductTableView({super.key});

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
                color: Colors.white, // Background color
                borderRadius: BorderRadius.circular(16), // Rounded corners
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
                        "Фото Название",
                        style: TextStyle(color: AppColors.mainTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Номер товара",
                        style: TextStyle(color: AppColors.mainTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Конфигурация",
                        style: TextStyle(color: AppColors.mainTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Детали",
                        style: TextStyle(color: AppColors.mainTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Количество",
                        style: TextStyle(color: AppColors.mainTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Действие",
                        style: TextStyle(color: AppColors.mainTextColor),
                      ),
                    ),
                  ],
                  rows:
                      products.map((product) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_upward,
                                    size: 16,
                                    color: AppColors.mainTextColor,
                                  ),
                                  SizedBox(width: 8),
                                  Text(product["name"]),
                                ],
                              ),
                            ),
                            DataCell(Text(product["number"])),
                            DataCell(Text(product["config"])),
                            DataCell(Text(product["details"])),
                            DataCell(
                              Text(
                                "${product["qty"]}",
                                style: TextStyle(
                                  color:
                                      product["qty"] < 15
                                          ? Colors.red
                                          : Colors.green,
                                ),
                              ),
                            ),
                            DataCell(
                              OutlinedButton(
                                onPressed: () {},
                                child: Text("Перейти"),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductAdvancedTableView extends StatefulWidget {
  const ProductAdvancedTableView({super.key});

  @override
  State<ProductAdvancedTableView> createState() =>
      _ProductAdvancedTableViewState();
}

class _ProductAdvancedTableViewState extends State<ProductAdvancedTableView> {
  List<Map<String, dynamic>> products = [
    {
      "index": 1,
      "direction": Icons.arrow_upward,
      "firm": "АО Крон",
      "brand": "#12548796",
      "config": "Shopping",
      "description": "Длинное описание д***",
      "currency": "AMD",
      "priceCash": 100,
      "priceInvoice": 100,
      "date": "28.10.2025",
      "details": "Тут текст",
    },
    {
      "index": 2,
      "direction": Icons.arrow_downward,
      "firm": "ПАО Виль",
      "brand": "#12548796",
      "config": "Transfer",
      "description": "Описание",
      "currency": "AMD",
      "priceCash": 100,
      "priceInvoice": 100,
      "date": "28.10.2025",
      "details": "Тут текст",
    },
    // Add more entries...
  ];

  bool showNewRow = false;

  // Controllers for new row fields
  final TextEditingController firmController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController configController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedCurrency = "AMD";
  String selectedLocation = "СКЛАД";
  String selectedTransport = "АВТ";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 24,

                columns: const [
                  DataColumn(
                    label: Text(
                      "№",
                      style: TextStyle(color: AppColors.mainTextColor),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Фото",
                      style: TextStyle(color: AppColors.mainTextColor),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Фирма*",
                      style: TextStyle(color: AppColors.mainTextColor),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Марка*",
                      style: TextStyle(color: AppColors.mainTextColor),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Конфигурация*",
                      style: TextStyle(color: AppColors.mainTextColor),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Описание",
                      style: TextStyle(color: AppColors.mainTextColor),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Цена*",
                      style: TextStyle(color: AppColors.mainTextColor),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Валюта",
                      style: TextStyle(color: AppColors.mainTextColor),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Цена кеш",
                      style: TextStyle(color: AppColors.mainTextColor),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Цена Инвойс",
                      style: TextStyle(color: AppColors.mainTextColor),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Дата",
                      style: TextStyle(color: AppColors.mainTextColor),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Детали",
                      style: TextStyle(color: AppColors.mainTextColor),
                    ),
                  ),
                ],
                rows: [
                  ...products.map((item) {
                    return DataRow(
                      cells: [
                        DataCell(Text('${item["index"]}')),
                        DataCell(
                          Icon(
                            item["direction"],
                            size: 18,
                            color: AppColors.mainTextColor,
                          ),
                        ),
                        DataCell(Text(item["firm"])),
                        DataCell(Text(item["brand"])),
                        DataCell(Text(item["config"])),
                        DataCell(Text(item["description"])),
                        DataCell(
                          Text(
                            "1",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataCell(
                          Text(
                            item["currency"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataCell(Text('${item["priceCash"]}')),
                        DataCell(Text('${item["priceInvoice"]}')),
                        DataCell(Text(item["date"])),
                        DataCell(Text(item["details"])),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          if (showNewRow)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                    DataColumn(label: SizedBox()),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text('${products.length + 1}')),
                        const DataCell(
                          Icon(Icons.radio_button_unchecked, size: 18),
                        ),
                        DataCell(
                          TextField(
                            controller: firmController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '—',
                            ),
                          ),
                        ),
                        DataCell(
                          TextField(
                            controller: brandController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '—',
                            ),
                          ),
                        ),
                        DataCell(
                          TextField(
                            controller: configController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '—',
                            ),
                          ),
                        ),
                        DataCell(
                          TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '—',
                            ),
                          ),
                        ),
                        const DataCell(Text("1")),
                        DataCell(
                          DropdownButton<String>(
                            value: selectedCurrency,
                            underline: const SizedBox(),
                            items: const [
                              DropdownMenuItem(
                                value: "AMD",
                                child: Text("AMD"),
                              ),
                              DropdownMenuItem(
                                value: "USD",
                                child: Text("USD"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedCurrency = value!;
                              });
                            },
                          ),
                        ),
                        const DataCell(Text("100")),
                        const DataCell(Text("100")),
                        DataCell(
                          Text(DateTime.now().toString().split(' ').first),
                        ),
                        DataCell(
                          Row(
                            children: [
                              DropdownButton<String>(
                                value: selectedLocation,
                                underline: const SizedBox(),
                                items: const [
                                  DropdownMenuItem(
                                    value: "СКЛАД",
                                    child: Text("СКЛАД"),
                                  ),
                                  DropdownMenuItem(
                                    value: "МАГ",
                                    child: Text("МАГ"),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedLocation = value!;
                                  });
                                },
                              ),
                              const SizedBox(width: 8),
                              Text(selectedTransport),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (!showNewRow)
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      showNewRow = true;
                    });
                  },
                  child: const Text(
                    "Добавить",
                    style: TextStyle(color: AppColors.blue),
                  ),
                ),
              if (showNewRow)
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.blue),
                  ),
                  onPressed: () {
                    // Example save logic
                    setState(() {
                      products.add({
                        "index": products.length + 1,
                        "direction": Icons.arrow_upward,
                        "firm": firmController.text,
                        "brand": brandController.text,
                        "config": configController.text,
                        "description": descriptionController.text,
                        "currency": selectedCurrency,
                        "priceCash": 100,
                        "priceInvoice": 100,
                        "date": DateTime.now().toString().split(' ').first,
                        "details": selectedLocation,
                      });

                      // Clear inputs
                      firmController.clear();
                      brandController.clear();
                      configController.clear();
                      descriptionController.clear();
                      selectedLocation = "СКЛАД";
                      showNewRow = false;
                    });
                  },
                  child: const Text(
                    "Сохранить",
                    style: TextStyle(color: AppColors.blue),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
