import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../data/models/attendance_record_model.dart';
import 'attendance_data_source.dart';

class CustomTableData extends StatelessWidget {
  final List<AttendanceRecordModel> records;
  const CustomTableData({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        gridLineColor: Colors.grey.shade300,
        headerColor: Color(0xff904A42),
      ),
      child: SfDataGrid(
        source: AttendanceDataSource(records: records),
        allowSorting: false,
        headerRowHeight: 35,
        rowHeight: 35,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        columnWidthMode: ColumnWidthMode.auto,
        isScrollbarAlwaysShown: true,

        horizontalScrollPhysics: const BouncingScrollPhysics(),
        columns: [
          GridColumn(
            columnName: 'AC-No',
            label: Center(
              child: Text(
                'AC-No',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'Name',
            label: Center(
              child: Text(
                'Name',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'Date',
            label: Center(
              child: Text(
                'Date',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'Timetable',
            label: Center(
              child: Text(
                'Timetable',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'OnDuty',
            label: Center(
              child: Text(
                'On Duty',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'OffDuty',
            label: Center(
              child: Text(
                'Off Duty',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'ClockIn',
            label: Center(
              child: Text(
                'Clock In',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'ClockOut',
            label: Center(
              child: Text(
                'Clock Out',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'Normal',
            label: Center(
              child: Text(
                'Normal',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'RealTime',
            label: Center(
              child: Text(
                'Real Time',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'Late',
            label: Center(
              child: Text(
                'Late',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'Early',
            label: Center(
              child: Text(
                'Early',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'Absent',
            label: Center(
              child: Text(
                'Absent',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'OTTime',
            label: Center(
              child: Text(
                'OT Time',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'WorkTime',
            label: Center(
              child: Text(
                'Work Time',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'NDays',
            label: Center(
              child: Text(
                'NDays',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'ATTTime',
            label: Center(
              child: Text(
                'ATT Time',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          GridColumn(
            columnName: 'NDaysOT',
            label: Center(
              child: Text(
                'NDays OT',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
