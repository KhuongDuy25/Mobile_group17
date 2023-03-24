import 'package:b/model/congviec.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/model/congviec.dart';
import 'package:b/main.dart';


class CVList extends StatefulWidget {
  final List<Congviec> danhSachCV;
  final Function(int) onDel;

  CVList(this.danhSachCV, this.onDel);

  @override
  _CVListState createState() => _CVListState();
}

class _CVListState extends State<CVList> {
  //Hàm trả về TRUE khi thời gian truyền vào vượt quá ngày hiện tại
  bool isOverdue(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: SingleChildScrollView(
        child: Column(
          children: widget.danhSachCV.map((cv) {
            int index = widget.danhSachCV.indexOf(cv);
            Color tileColor =
                isOverdue(cv.deadline) ? Colors.redAccent : Colors.blue; //màu của thanh list cviec
            return Container(
              //giãn cách giữa các công việc
              padding: EdgeInsets.symmetric(horizontal: 10), //giãn cách chiều ngang
              margin: EdgeInsets.only(top: 10),              // giãn cách chiều dọc
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: tileColor,
                contentPadding:
                    EdgeInsets.symmetric(
                        vertical: 12, //khoảng cách chiều dọc của bảng trắng
                        horizontal: 10 //khoảng cách chiều ngang
                    ),
                leading: Container(
                  decoration: BoxDecoration(    //phan code của hình vuong bo tròn
                    borderRadius: BorderRadius.circular(
                        20// tạo bán kính là 20 để ra hình vuông bo tròn quanh dsach công việc
                    ),
                    border: Border.all(    // màu của hình vuông bo tròn
                      color: Colors.black26,
                      width: 2,
                    ),
                  ),
                  // đặt giá trị alignment thành Alignment.center để đưa Text vào giữa
                  alignment: Alignment.center,
                  width: 60,
                  height: 60,
                  child: Text(
                    cv.id.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  cv.tencv,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(        // phần dưới công việc in ra MÔ TẢ + Deadline
                  'Mô tả:' +
                      cv.macv +
                      '\n' +
                      "Deadline: " +
                      DateFormat('dd/MM/yyyy').format(cv.deadline),
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,      // màu của phần mô tả + dealine
                      fontWeight: FontWeight.normal),
                ),
                //Tạo 1 icon trash
                trailing: GestureDetector(    //phan xoa cong viec
                  onTap: () {
                    widget.onDel(index);
                  },
                  child: Container(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.symmetric(vertical: 6),
                    height: 35,
                    width: 35,
            decoration: BoxDecoration(                      // phần ô vuông ngoài thùng rác
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
            ),
                    child: Icon(    //icon thung rac
                      //Thực hiện thao tác xoá 1 widget (công việc)
                      Icons.delete,
                      color: Colors.greenAccent,
                      size: 25,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
