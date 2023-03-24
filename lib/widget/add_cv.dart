import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Newcv extends StatefulWidget {
  final Function addcv;

  Newcv(this.addcv);

  @override
  State<Newcv> createState() => _NewcvState();
}

class _NewcvState extends State<Newcv> {
  //Khai báo đối tượng dùng lưu trữ giá trị người dùng nhập vào
  final tenControl = TextEditingController();
  final macontrol = TextEditingController();  //mota
  final dlinecontrol = TextEditingController();
  void submitData() {
    // Lấy giá trị người dùng nhập vào
    final enten = tenControl.text;
    final enma = macontrol.text;
    final endline = dlinecontrol.text;
    //Không thực hiện nếu các giá trị nhập vào là rỗng
    if (enten.isEmpty || enma.isEmpty || endline.isEmpty) return;
    //Method
    widget.addcv(
      enten,
      enma,
      endline,
    );
    //Trở lại Menu sau khi thêm dữ liệu
    Navigator.of(context).pop();
  }

  DateTime currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 1000,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Tên công việc'),
              controller: tenControl,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Mô tả công việc'),
              controller: macontrol,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration:
              InputDecoration(labelText: 'Thời hạn hoàn thành'),
              controller: dlinecontrol,
              readOnly: true,//ko hien ban phim
              onTap: () async {
                // Hiển thị picker ngày tháng năm khi người dùng chọn trường này
                final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2050));
                if (pickedDate != null) {
                  // Cập nhật giá trị cho trường ngày tháng năm
                  setState(() {
                    dlinecontrol.text =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                  });
                }
              },
            ),
            TextButton(
              child: Text('Thêm công việc này vào'),
              onPressed: () {
                submitData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
