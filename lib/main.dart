import 'package:flutter/material.dart';
import 'widget/list_congviec.dart';
import 'widget/add_cv.dart';
import 'model/congviec.dart';
import 'package:intl/intl.dart';
import 'package:color/color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //tắt chữ debug
      debugShowCheckedModeBanner: false,
      title: 'Nhóm 14',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final dateFormat = DateFormat('dd/MM/yyyy');

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController = TextEditingController();
  List<Congviec> _filteredCongViec = [];
  final List<Congviec> danhSachCongviec = [
    Congviec(
      id: 1,
      tencv: 'Học ngôn ngữ C++',
      macv: 'Học trên F8',
      deadline: dateFormat.parse('24/06/2023'),
    ),
    Congviec(
      id: 2,
      tencv: 'Thực hành Mobile',
      macv: 'Trên android studio',
      deadline: dateFormat.parse('25/02/2023'),
    ),
  ];

  @override
  void initState() {
    _filteredCongViec.addAll(danhSachCongviec);
    super.initState();
  }

  //Tạo hàm _filterCongViec
  void _filterCongViec(String query) {
    //Tạo bản sao của danhSachCongViec
    List<Congviec> filteredCongViec = [];
    filteredCongViec.addAll(danhSachCongviec);

    setState(() {
      _filteredCongViec.clear();
      _filteredCongViec.addAll(filteredCongViec);
    });
  }

  void addNewCongviec(String tencv, String macv, String deadline) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final newCongviec = Congviec(
      id: danhSachCongviec.length +1,
      tencv: tencv,
      macv: macv,
      deadline: dateFormat.parse(deadline),
    );
    setState(() {
      danhSachCongviec.add(newCongviec);
      _filteredCongViec.add(newCongviec);
    });
  }
  //hàm xoá công việc
  void deleteCongViec(int index) {
    setState(() {
      danhSachCongviec.removeAt(index);
      _filteredCongViec.removeAt(index);
      for (int i = index; i < danhSachCongviec.length; i++) {    //phần id của list cong viec
        danhSachCongviec[i].id--;
      }
    });
  }

  //Nhập dữ liệu
  void startAddNewCongviec(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Newcv(addNewCongviec),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override                                  // buid backgroud
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //thanh tiêu đề
      appBar: AppBar(                           //thanh tiêu đề
        backgroundColor: Colors.green[400],
        elevation: 0,
        title: Row(
          mainAxisAlignment:
              //căn chỉnh các đối tượng
              MainAxisAlignment.spaceBetween,
          children: [
            //căn chỉnh text
            Expanded(
              child: Text(                          //text cau thanh tieu de
                'Quản Lý Công Việc Cá Nhân',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(             //chứa ảnh
              height: 50,
              width: 50,
              child: ClipRRect(
                //bo góc của ảnh
                borderRadius: BorderRadius.circular(30),
                child: Image.asset('assets/images/Hữu Đa.jpg'),
              ),
            ),
          ],
        ),
      ),
      //nút drawer
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Tìm kiếm công việc",
                hintText: "Nhập từ khóa...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              onChanged: (value) {
                _filterCongViec(value);
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CVList(_filteredCongViec, deleteCongViec),
                ],
              ),
            ),
          ),
        ],
      ),
      //Icon thêm dữ liệu
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box,color: Colors.white,),
        onPressed: () => startAddNewCongviec(context),
      ),
    );
  }
}

