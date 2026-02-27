import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../data/models/attendance_record_model.dart';

class AttendanceDataSource extends DataGridSource {
  AttendanceDataSource({required List<AttendanceRecordModel> records}) {
    dataGridRows = records.map<DataGridRow>((record) {
      return DataGridRow(
        cells: [
          DataGridCell<int>(columnName: 'AC-No', value: record.acNo),
          DataGridCell<String>(columnName: 'Name', value: record.name),
          DataGridCell<String>(columnName: 'Date', value: record.date),
          DataGridCell<String>(columnName: 'Timetable', value: record.timetable),
          DataGridCell<String>(columnName: 'OnDuty', value: record.onDuty),
          DataGridCell<String>(columnName: 'OffDuty', value: record.offDuty),
          DataGridCell<String>(columnName: 'ClockIn', value: record.clockIn),
          DataGridCell<String>(columnName: 'ClockOut', value: record.clockOut),
          DataGridCell<double>(columnName: 'Normal', value: record.normal),
          DataGridCell<double>(columnName: 'RealTime', value: record.realTime),
          DataGridCell<String>(columnName: 'Late', value: record.late),
          DataGridCell<String>(columnName: 'Early', value: record.early),
          DataGridCell<String>(columnName: 'Absent', value: record.absent),
          DataGridCell<String>(columnName: 'OTTime', value: record.otTime),
          DataGridCell<String>(columnName: 'WorkTime', value: record.workTime),
          DataGridCell<double>(columnName: 'NDays', value: record.nDays),
          DataGridCell<String>(columnName: 'ATTTime', value: record.attTime),
          DataGridCell<double>(columnName: 'NDaysOT', value: record.nDaysOt),
        ],
      );
    }).toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(cell.value?.toString() ?? ''),
        );
      }).toList(),
    );
  }
}
