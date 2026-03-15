// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome back`
  String get welcome_back {
    return Intl.message(
      'Welcome back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Hi Class Factory`
  String get welcome_back_info {
    return Intl.message(
      'Hi Class Factory',
      name: 'welcome_back_info',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Required field`
  String get required_field {
    return Intl.message(
      'Required field',
      name: 'required_field',
      desc: '',
      args: [],
    );
  }

  /// `The email format is incorrect.`
  String get email_incorrect {
    return Intl.message(
      'The email format is incorrect.',
      name: 'email_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enter_password {
    return Intl.message(
      'Enter Password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `It must be at least 6 characters long.`
  String get least_characters {
    return Intl.message(
      'It must be at least 6 characters long.',
      name: 'least_characters',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get login {
    return Intl.message(
      'Sign in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get light_mode {
    return Intl.message(
      'Light Mode',
      name: 'light_mode',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Accessories Store`
  String get accessories_store {
    return Intl.message(
      'Accessories Store',
      name: 'accessories_store',
      desc: '',
      args: [],
    );
  }

  /// `No accessories found`
  String get no_accessories {
    return Intl.message(
      'No accessories found',
      name: 'no_accessories',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Delete`
  String get delete_confirm_title {
    return Intl.message(
      'Confirm Delete',
      name: 'delete_confirm_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this?`
  String get delete_confirm_message {
    return Intl.message(
      'Are you sure you want to delete this?',
      name: 'delete_confirm_message',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Add Accessory`
  String get add_accessory {
    return Intl.message(
      'Add Accessory',
      name: 'add_accessory',
      desc: '',
      args: [],
    );
  }

  /// `Accessory Name`
  String get accessory_name {
    return Intl.message(
      'Accessory Name',
      name: 'accessory_name',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get required {
    return Intl.message(
      'Required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Save Accessory`
  String get save_accessory {
    return Intl.message(
      'Save Accessory',
      name: 'save_accessory',
      desc: '',
      args: [],
    );
  }

  /// `Edit Accessory`
  String get edit_accessory {
    return Intl.message(
      'Edit Accessory',
      name: 'edit_accessory',
      desc: '',
      args: [],
    );
  }

  /// `Choose Color`
  String get choose_color {
    return Intl.message(
      'Choose Color',
      name: 'choose_color',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Red`
  String get color_red {
    return Intl.message(
      'Red',
      name: 'color_red',
      desc: '',
      args: [],
    );
  }

  /// `Green`
  String get color_green {
    return Intl.message(
      'Green',
      name: 'color_green',
      desc: '',
      args: [],
    );
  }

  /// `Blue`
  String get color_blue {
    return Intl.message(
      'Blue',
      name: 'color_blue',
      desc: '',
      args: [],
    );
  }

  /// `Yellow`
  String get color_yellow {
    return Intl.message(
      'Yellow',
      name: 'color_yellow',
      desc: '',
      args: [],
    );
  }

  /// `Orange`
  String get color_orange {
    return Intl.message(
      'Orange',
      name: 'color_orange',
      desc: '',
      args: [],
    );
  }

  /// `Purple`
  String get color_purple {
    return Intl.message(
      'Purple',
      name: 'color_purple',
      desc: '',
      args: [],
    );
  }

  /// `Black`
  String get color_black {
    return Intl.message(
      'Black',
      name: 'color_black',
      desc: '',
      args: [],
    );
  }

  /// `White`
  String get color_white {
    return Intl.message(
      'White',
      name: 'color_white',
      desc: '',
      args: [],
    );
  }

  /// `Brown`
  String get color_brown {
    return Intl.message(
      'Brown',
      name: 'color_brown',
      desc: '',
      args: [],
    );
  }

  /// `Grey`
  String get color_grey {
    return Intl.message(
      'Grey',
      name: 'color_grey',
      desc: '',
      args: [],
    );
  }

  /// `Teal`
  String get color_teal {
    return Intl.message(
      'Teal',
      name: 'color_teal',
      desc: '',
      args: [],
    );
  }

  /// `Pink`
  String get color_pink {
    return Intl.message(
      'Pink',
      name: 'color_pink',
      desc: '',
      args: [],
    );
  }

  /// `Cyan`
  String get color_cyan {
    return Intl.message(
      'Cyan',
      name: 'color_cyan',
      desc: '',
      args: [],
    );
  }

  /// `Indigo`
  String get color_indigo {
    return Intl.message(
      'Indigo',
      name: 'color_indigo',
      desc: '',
      args: [],
    );
  }

  /// `Lime`
  String get color_lime {
    return Intl.message(
      'Lime',
      name: 'color_lime',
      desc: '',
      args: [],
    );
  }

  /// `Amber`
  String get color_amber {
    return Intl.message(
      'Amber',
      name: 'color_amber',
      desc: '',
      args: [],
    );
  }

  /// `Dark Orange`
  String get color_deep_orange {
    return Intl.message(
      'Dark Orange',
      name: 'color_deep_orange',
      desc: '',
      args: [],
    );
  }

  /// `Dark Purple`
  String get color_deep_purple {
    return Intl.message(
      'Dark Purple',
      name: 'color_deep_purple',
      desc: '',
      args: [],
    );
  }

  /// `Light Blue`
  String get color_light_blue {
    return Intl.message(
      'Light Blue',
      name: 'color_light_blue',
      desc: '',
      args: [],
    );
  }

  /// `Light Green`
  String get color_light_green {
    return Intl.message(
      'Light Green',
      name: 'color_light_green',
      desc: '',
      args: [],
    );
  }

  /// `Blue Grey`
  String get color_blue_grey {
    return Intl.message(
      'Blue Grey',
      name: 'color_blue_grey',
      desc: '',
      args: [],
    );
  }

  /// `Light Red`
  String get color_red_accent {
    return Intl.message(
      'Light Red',
      name: 'color_red_accent',
      desc: '',
      args: [],
    );
  }

  /// `Light Green`
  String get color_green_accent {
    return Intl.message(
      'Light Green',
      name: 'color_green_accent',
      desc: '',
      args: [],
    );
  }

  /// `Light Blue`
  String get color_blue_accent {
    return Intl.message(
      'Light Blue',
      name: 'color_blue_accent',
      desc: '',
      args: [],
    );
  }

  /// `Light Yellow`
  String get color_yellow_accent {
    return Intl.message(
      'Light Yellow',
      name: 'color_yellow_accent',
      desc: '',
      args: [],
    );
  }

  /// `Light Orange`
  String get color_orange_accent {
    return Intl.message(
      'Light Orange',
      name: 'color_orange_accent',
      desc: '',
      args: [],
    );
  }

  /// `Light Purple`
  String get color_purple_accent {
    return Intl.message(
      'Light Purple',
      name: 'color_purple_accent',
      desc: '',
      args: [],
    );
  }

  /// `Light Pink`
  String get color_pink_accent {
    return Intl.message(
      'Light Pink',
      name: 'color_pink_accent',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Attendance`
  String get attendance {
    return Intl.message(
      'Attendance',
      name: 'attendance',
      desc: '',
      args: [],
    );
  }

  /// `No Data`
  String get noData {
    return Intl.message(
      'No Data',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Records count: {count}`
  String recordsCount(Object count) {
    return Intl.message(
      'Records count: $count',
      name: 'recordsCount',
      desc: '',
      args: [count],
    );
  }

  /// `Confirm Delete`
  String get deleteConfirmTitle {
    return Intl.message(
      'Confirm Delete',
      name: 'deleteConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete?`
  String get deleteConfirmMessage {
    return Intl.message(
      'Are you sure you want to delete?',
      name: 'deleteConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `From {from}-to {to}`
  String attendanceRange(Object from, Object to) {
    return Intl.message(
      'From $from-to $to',
      name: 'attendanceRange',
      desc: '',
      args: [from, to],
    );
  }

  /// `Upload Attendance File`
  String get uploadAttendanceFile {
    return Intl.message(
      'Upload Attendance File',
      name: 'uploadAttendanceFile',
      desc: '',
      args: [],
    );
  }

  /// `Upload completed successfully`
  String get uploadSuccess {
    return Intl.message(
      'Upload completed successfully',
      name: 'uploadSuccess',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get errorOccurred {
    return Intl.message(
      'An error occurred',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Select Period`
  String get selectPeriod {
    return Intl.message(
      'Select Period',
      name: 'selectPeriod',
      desc: '',
      args: [],
    );
  }

  /// `No period selected`
  String get noPeriodSelected {
    return Intl.message(
      'No period selected',
      name: 'noPeriodSelected',
      desc: '',
      args: [],
    );
  }

  /// `Choose Excel File`
  String get chooseExcelFile {
    return Intl.message(
      'Choose Excel File',
      name: 'chooseExcelFile',
      desc: '',
      args: [],
    );
  }

  /// `Upload Data`
  String get uploadData {
    return Intl.message(
      'Upload Data',
      name: 'uploadData',
      desc: '',
      args: [],
    );
  }

  /// `Attendance Details`
  String get attendanceDetails {
    return Intl.message(
      'Attendance Details',
      name: 'attendanceDetails',
      desc: '',
      args: [],
    );
  }

  /// `Thread Store`
  String get bakrStore {
    return Intl.message(
      'Thread Store',
      name: 'bakrStore',
      desc: '',
      args: [],
    );
  }

  /// `No threads found`
  String get noBakr {
    return Intl.message(
      'No threads found',
      name: 'noBakr',
      desc: '',
      args: [],
    );
  }

  /// `Add Thread`
  String get addBakr {
    return Intl.message(
      'Add Thread',
      name: 'addBakr',
      desc: '',
      args: [],
    );
  }

  /// `Thread Name`
  String get threadName {
    return Intl.message(
      'Thread Name',
      name: 'threadName',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get requiredField {
    return Intl.message(
      'Required',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `Add Color`
  String get addColor {
    return Intl.message(
      'Add Color',
      name: 'addColor',
      desc: '',
      args: [],
    );
  }

  /// `Save Thread`
  String get saveThread {
    return Intl.message(
      'Save Thread',
      name: 'saveThread',
      desc: '',
      args: [],
    );
  }

  /// `Edit Thread`
  String get editThread {
    return Intl.message(
      'Edit Thread',
      name: 'editThread',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Employees`
  String get employees {
    return Intl.message(
      'Employees',
      name: 'employees',
      desc: '',
      args: [],
    );
  }

  /// `No employees found`
  String get no_employees {
    return Intl.message(
      'No employees found',
      name: 'no_employees',
      desc: '',
      args: [],
    );
  }

  /// `Add New Employee`
  String get addNewEmployee {
    return Intl.message(
      'Add New Employee',
      name: 'addNewEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Edit Employee`
  String get editEmployee {
    return Intl.message(
      'Edit Employee',
      name: 'editEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Employee Name`
  String get employeeName {
    return Intl.message(
      'Employee Name',
      name: 'employeeName',
      desc: '',
      args: [],
    );
  }

  /// `National ID`
  String get nationalId {
    return Intl.message(
      'National ID',
      name: 'nationalId',
      desc: '',
      args: [],
    );
  }

  /// `Employee Code`
  String get employeeCode {
    return Intl.message(
      'Employee Code',
      name: 'employeeCode',
      desc: '',
      args: [],
    );
  }

  /// `Job Title`
  String get jobTitle {
    return Intl.message(
      'Job Title',
      name: 'jobTitle',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Salary`
  String get monthlySalary {
    return Intl.message(
      'Monthly Salary',
      name: 'monthlySalary',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Salary`
  String get weeklySalary {
    return Intl.message(
      'Weekly Salary',
      name: 'weeklySalary',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Advance`
  String get weeklyAdvance {
    return Intl.message(
      'Weekly Advance',
      name: 'weeklyAdvance',
      desc: '',
      args: [],
    );
  }

  /// `Employee Status`
  String get employeeStatus {
    return Intl.message(
      'Employee Status',
      name: 'employeeStatus',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get inactive {
    return Intl.message(
      'Inactive',
      name: 'inactive',
      desc: '',
      args: [],
    );
  }

  /// `Save Employee`
  String get saveEmployee {
    return Intl.message(
      'Save Employee',
      name: 'saveEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Update Employee`
  String get updateEmployee {
    return Intl.message(
      'Update Employee',
      name: 'updateEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Numbers only`
  String get numbersOnly {
    return Intl.message(
      'Numbers only',
      name: 'numbersOnly',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get invalidPhone {
    return Intl.message(
      'Invalid phone number',
      name: 'invalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `National ID must be 14 digits`
  String get nationalIdLength {
    return Intl.message(
      'National ID must be 14 digits',
      name: 'nationalIdLength',
      desc: '',
      args: [],
    );
  }

  /// `Invalid national ID`
  String get invalidNationalId {
    return Intl.message(
      'Invalid national ID',
      name: 'invalidNationalId',
      desc: '',
      args: [],
    );
  }

  /// `Invalid birth month`
  String get invalidBirthMonth {
    return Intl.message(
      'Invalid birth month',
      name: 'invalidBirthMonth',
      desc: '',
      args: [],
    );
  }

  /// `Invalid birth day`
  String get invalidBirthDay {
    return Intl.message(
      'Invalid birth day',
      name: 'invalidBirthDay',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Advance Amount`
  String get weeklyAdvanceAmount {
    return Intl.message(
      'Weekly Advance Amount',
      name: 'weeklyAdvanceAmount',
      desc: '',
      args: [],
    );
  }

  /// `Remaining Salary`
  String get remainingSalary {
    return Intl.message(
      'Remaining Salary',
      name: 'remainingSalary',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get yearly {
    return Intl.message(
      'Yearly',
      name: 'yearly',
      desc: '',
      args: [],
    );
  }

  /// `Basic Salary`
  String get basicSalary {
    return Intl.message(
      'Basic Salary',
      name: 'basicSalary',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Balance`
  String get monthlyBalance {
    return Intl.message(
      'Monthly Balance',
      name: 'monthlyBalance',
      desc: '',
      args: [],
    );
  }

  /// `Yearly Balance`
  String get yearlyBalance {
    return Intl.message(
      'Yearly Balance',
      name: 'yearlyBalance',
      desc: '',
      args: [],
    );
  }

  /// `Fabric Store`
  String get fabricStore {
    return Intl.message(
      'Fabric Store',
      name: 'fabricStore',
      desc: '',
      args: [],
    );
  }

  /// `No fabric found`
  String get no_fabric {
    return Intl.message(
      'No fabric found',
      name: 'no_fabric',
      desc: '',
      args: [],
    );
  }

  /// `Add Fabric`
  String get addFabric {
    return Intl.message(
      'Add Fabric',
      name: 'addFabric',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Cut Quantity`
  String get cutQuantity {
    return Intl.message(
      'Cut Quantity',
      name: 'cutQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Upload invoice here`
  String get uploadInvoiceHere {
    return Intl.message(
      'Upload invoice here',
      name: 'uploadInvoiceHere',
      desc: '',
      args: [],
    );
  }

  /// `Select Invoice`
  String get selectInvoice {
    return Intl.message(
      'Select Invoice',
      name: 'selectInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Upload Incoming Invoice`
  String get uploadIncomingInvoice {
    return Intl.message(
      'Upload Incoming Invoice',
      name: 'uploadIncomingInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Available In Stock`
  String get availableInStock {
    return Intl.message(
      'Available In Stock',
      name: 'availableInStock',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get addProduct {
    return Intl.message(
      'Add Product',
      name: 'addProduct',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get productName {
    return Intl.message(
      'Product Name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Product Code`
  String get productCode {
    return Intl.message(
      'Product Code',
      name: 'productCode',
      desc: '',
      args: [],
    );
  }

  /// `Add Size`
  String get addSize {
    return Intl.message(
      'Add Size',
      name: 'addSize',
      desc: '',
      args: [],
    );
  }

  /// `Save Product`
  String get saveProduct {
    return Intl.message(
      'Save Product',
      name: 'saveProduct',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get editProduct {
    return Intl.message(
      'Edit Product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `Finished Products Store`
  String get finishedProductsStore {
    return Intl.message(
      'Finished Products Store',
      name: 'finishedProductsStore',
      desc: '',
      args: [],
    );
  }

  /// `No products available`
  String get noProducts {
    return Intl.message(
      'No products available',
      name: 'noProducts',
      desc: '',
      args: [],
    );
  }

  /// `Delete Confirmation`
  String get deleteConfirmation {
    return Intl.message(
      'Delete Confirmation',
      name: 'deleteConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this product?`
  String get deleteProductQuestion {
    return Intl.message(
      'Are you sure you want to delete this product?',
      name: 'deleteProductQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Hi Class`
  String get appName {
    return Intl.message(
      'Hi Class',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Factory Management System`
  String get systemTitle {
    return Intl.message(
      'Factory Management System',
      name: 'systemTitle',
      desc: '',
      args: [],
    );
  }

  /// `Daily Production`
  String get dailyProduction {
    return Intl.message(
      'Daily Production',
      name: 'dailyProduction',
      desc: '',
      args: [],
    );
  }

  /// `Piece`
  String get piece {
    return Intl.message(
      'Piece',
      name: 'piece',
      desc: '',
      args: [],
    );
  }

  /// `Main Warehouse`
  String get mainWarehouse {
    return Intl.message(
      'Main Warehouse',
      name: 'mainWarehouse',
      desc: '',
      args: [],
    );
  }

  /// `{count} Items Available`
  String availableItems(Object count) {
    return Intl.message(
      '$count Items Available',
      name: 'availableItems',
      desc: '',
      args: [count],
    );
  }

  /// `Invoices`
  String get invoices {
    return Intl.message(
      'Invoices',
      name: 'invoices',
      desc: '',
      args: [],
    );
  }

  /// `{count} Pending Invoices`
  String pendingInvoices(Object count) {
    return Intl.message(
      '$count Pending Invoices',
      name: 'pendingInvoices',
      desc: '',
      args: [count],
    );
  }

  /// `Attendance`
  String get attendanceAndDeparture {
    return Intl.message(
      'Attendance',
      name: 'attendanceAndDeparture',
      desc: '',
      args: [],
    );
  }

  /// `{count} Employees Present`
  String employeesPresent(Object count) {
    return Intl.message(
      '$count Employees Present',
      name: 'employeesPresent',
      desc: '',
      args: [count],
    );
  }

  /// `Salaries`
  String get salaries {
    return Intl.message(
      'Salaries',
      name: 'salaries',
      desc: '',
      args: [],
    );
  }

  /// `Salaries Details`
  String get salariesDetails {
    return Intl.message(
      'Salaries Details',
      name: 'salariesDetails',
      desc: '',
      args: [],
    );
  }

  /// `Prepare Monthly Payroll`
  String get preparePayroll {
    return Intl.message(
      'Prepare Monthly Payroll',
      name: 'preparePayroll',
      desc: '',
      args: [],
    );
  }

  /// `Latest Updates`
  String get latestUpdates {
    return Intl.message(
      'Latest Updates',
      name: 'latestUpdates',
      desc: '',
      args: [],
    );
  }

  /// `New Invoice`
  String get newInvoice {
    return Intl.message(
      'New Invoice',
      name: 'newInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Store is empty`
  String get storeEmpty {
    return Intl.message(
      'Store is empty',
      name: 'storeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Customer Name`
  String get customerName {
    return Intl.message(
      'Customer Name',
      name: 'customerName',
      desc: '',
      args: [],
    );
  }

  /// `Choose Product`
  String get chooseProduct {
    return Intl.message(
      'Choose Product',
      name: 'chooseProduct',
      desc: '',
      args: [],
    );
  }

  /// `Unit Price`
  String get unitPrice {
    return Intl.message(
      'Unit Price',
      name: 'unitPrice',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Total`
  String get invoiceTotal {
    return Intl.message(
      'Invoice Total',
      name: 'invoiceTotal',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Save Invoice`
  String get saveInvoice {
    return Intl.message(
      'Save Invoice',
      name: 'saveInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Total After Discount`
  String get totalAfterDiscount {
    return Intl.message(
      'Total After Discount',
      name: 'totalAfterDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Discount Percentage`
  String get discountPercent {
    return Intl.message(
      'Discount Percentage',
      name: 'discountPercent',
      desc: '',
      args: [],
    );
  }

  /// `Not available in store`
  String get notAvailable {
    return Intl.message(
      'Not available in store',
      name: 'notAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Quantity not enough in store`
  String get insufficientQuantity {
    return Intl.message(
      'Quantity not enough in store',
      name: 'insufficientQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Number`
  String get invoiceNumber {
    return Intl.message(
      'Invoice Number',
      name: 'invoiceNumber',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Sales Invoice`
  String get salesInvoice {
    return Intl.message(
      'Sales Invoice',
      name: 'salesInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Financial transaction details`
  String get invoiceDescription {
    return Intl.message(
      'Financial transaction details',
      name: 'invoiceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Item`
  String get item {
    return Intl.message(
      'Item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Goods sold cannot be returned or exchanged after 14 days.`
  String get note1 {
    return Intl.message(
      'Goods sold cannot be returned or exchanged after 14 days.',
      name: 'note1',
      desc: '',
      args: [],
    );
  }

  /// `The original invoice must be presented for exchange.`
  String get note2 {
    return Intl.message(
      'The original invoice must be presented for exchange.',
      name: 'note2',
      desc: '',
      args: [],
    );
  }

  /// `Total Items`
  String get totalItems {
    return Intl.message(
      'Total Items',
      name: 'totalItems',
      desc: '',
      args: [],
    );
  }

  /// `Grand Total`
  String get grandTotal {
    return Intl.message(
      'Grand Total',
      name: 'grandTotal',
      desc: '',
      args: [],
    );
  }

  /// `Only`
  String get only {
    return Intl.message(
      'Only',
      name: 'only',
      desc: '',
      args: [],
    );
  }

  /// `no more`
  String get noMore {
    return Intl.message(
      'no more',
      name: 'noMore',
      desc: '',
      args: [],
    );
  }

  /// `EGP`
  String get egp {
    return Intl.message(
      'EGP',
      name: 'egp',
      desc: '',
      args: [],
    );
  }

  /// `EGP`
  String get pound {
    return Intl.message(
      'EGP',
      name: 'pound',
      desc: '',
      args: [],
    );
  }

  /// `cent`
  String get piastre {
    return Intl.message(
      'cent',
      name: 'piastre',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message(
      'Reports',
      name: 'reports',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Details`
  String get invoiceDetails {
    return Intl.message(
      'Invoice Details',
      name: 'invoiceDetails',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Factory Data`
  String get enterFactoryData {
    return Intl.message(
      'Enter Your Factory Data',
      name: 'enterFactoryData',
      desc: '',
      args: [],
    );
  }

  /// `Manager`
  String get manager {
    return Intl.message(
      'Manager',
      name: 'manager',
      desc: '',
      args: [],
    );
  }

  /// `Add Factory Data`
  String get addFactoryData {
    return Intl.message(
      'Add Factory Data',
      name: 'addFactoryData',
      desc: '',
      args: [],
    );
  }

  /// `Edit Factory Data`
  String get editFactoryData {
    return Intl.message(
      'Edit Factory Data',
      name: 'editFactoryData',
      desc: '',
      args: [],
    );
  }

  /// `Factory Description`
  String get factoryDescription {
    return Intl.message(
      'Factory Description',
      name: 'factoryDescription',
      desc: '',
      args: [],
    );
  }

  /// `Second Phone Number`
  String get secondPhoneNumber {
    return Intl.message(
      'Second Phone Number',
      name: 'secondPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Invoices Archive`
  String get invoiceArchive {
    return Intl.message(
      'Invoices Archive',
      name: 'invoiceArchive',
      desc: '',
      args: [],
    );
  }

  /// `Total Invoices`
  String get totalInvoices {
    return Intl.message(
      'Total Invoices',
      name: 'totalInvoices',
      desc: '',
      args: [],
    );
  }

  /// `Add New`
  String get addNew {
    return Intl.message(
      'Add New',
      name: 'addNew',
      desc: '',
      args: [],
    );
  }

  /// `No Invoices Found`
  String get noInvoices {
    return Intl.message(
      'No Invoices Found',
      name: 'noInvoices',
      desc: '',
      args: [],
    );
  }

  /// `No attendance found`
  String get no_attendance {
    return Intl.message(
      'No attendance found',
      name: 'no_attendance',
      desc: '',
      args: [],
    );
  }

  /// `Choose the period`
  String get choose_period {
    return Intl.message(
      'Choose the period',
      name: 'choose_period',
      desc: '',
      args: [],
    );
  }

  /// `No Attendance Records`
  String get noAttendance {
    return Intl.message(
      'No Attendance Records',
      name: 'noAttendance',
      desc: '',
      args: [],
    );
  }

  /// `Choose Period`
  String get choosePeriod {
    return Intl.message(
      'Choose Period',
      name: 'choosePeriod',
      desc: '',
      args: [],
    );
  }

  /// `Select a period to view salaries`
  String get selectPeriodToView {
    return Intl.message(
      'Select a period to view salaries',
      name: 'selectPeriodToView',
      desc: '',
      args: [],
    );
  }

  /// `No payroll found, please calculate salaries for this period`
  String get noPayrollFound {
    return Intl.message(
      'No payroll found, please calculate salaries for this period',
      name: 'noPayrollFound',
      desc: '',
      args: [],
    );
  }

  /// `Calculate Salaries`
  String get calculateSalaries {
    return Intl.message(
      'Calculate Salaries',
      name: 'calculateSalaries',
      desc: '',
      args: [],
    );
  }

  /// `Total Paid Salaries`
  String get totalPaidSalaries {
    return Intl.message(
      'Total Paid Salaries',
      name: 'totalPaidSalaries',
      desc: '',
      args: [],
    );
  }

  /// `Basic Salary`
  String get basicSalary2 {
    return Intl.message(
      'Basic Salary',
      name: 'basicSalary2',
      desc: '',
      args: [],
    );
  }

  /// `Attendance Days`
  String get attendanceDays {
    return Intl.message(
      'Attendance Days',
      name: 'attendanceDays',
      desc: '',
      args: [],
    );
  }

  /// `Overtime`
  String get overtime {
    return Intl.message(
      'Overtime',
      name: 'overtime',
      desc: '',
      args: [],
    );
  }

  /// `Overtime Amount`
  String get overtimeAmount {
    return Intl.message(
      'Overtime Amount',
      name: 'overtimeAmount',
      desc: '',
      args: [],
    );
  }

  /// `Late Time`
  String get lateTime {
    return Intl.message(
      'Late Time',
      name: 'lateTime',
      desc: '',
      args: [],
    );
  }

  /// `Late Deduction`
  String get lateDeduction {
    return Intl.message(
      'Late Deduction',
      name: 'lateDeduction',
      desc: '',
      args: [],
    );
  }

  /// `Absent Days`
  String get absentDays {
    return Intl.message(
      'Absent Days',
      name: 'absentDays',
      desc: '',
      args: [],
    );
  }

  /// `Absent Deduction`
  String get absentDeduction {
    return Intl.message(
      'Absent Deduction',
      name: 'absentDeduction',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Salary`
  String get weeklySalaryLabel {
    return Intl.message(
      'Weekly Salary',
      name: 'weeklySalaryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Account Settings`
  String get accountSettings {
    return Intl.message(
      'Account Settings',
      name: 'accountSettings',
      desc: '',
      args: [],
    );
  }

  /// `App Preferences`
  String get appPreferences {
    return Intl.message(
      'App Preferences',
      name: 'appPreferences',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get off {
    return Intl.message(
      'Off',
      name: 'off',
      desc: '',
      args: [],
    );
  }

  /// `Security & Support`
  String get securityAndSupport {
    return Intl.message(
      'Security & Support',
      name: 'securityAndSupport',
      desc: '',
      args: [],
    );
  }

  /// `Privacy & Security`
  String get privacyAndSecurity {
    return Intl.message(
      'Privacy & Security',
      name: 'privacyAndSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Technical Support`
  String get technicalSupport {
    return Intl.message(
      'Technical Support',
      name: 'technicalSupport',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `HI CLASS FACTORY`
  String get companyName {
    return Intl.message(
      'HI CLASS FACTORY',
      name: 'companyName',
      desc: '',
      args: [],
    );
  }

  /// `Finished Products Warehouse`
  String get finishedProducts {
    return Intl.message(
      'Finished Products Warehouse',
      name: 'finishedProducts',
      desc: '',
      args: [],
    );
  }

  /// `Ready goods for shipping`
  String get finishedProductsDesc {
    return Intl.message(
      'Ready goods for shipping',
      name: 'finishedProductsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Raw Materials Warehouse`
  String get rawMaterial {
    return Intl.message(
      'Raw Materials Warehouse',
      name: 'rawMaterial',
      desc: '',
      args: [],
    );
  }

  /// `Threads and embroidery cones`
  String get rawMaterialDesc {
    return Intl.message(
      'Threads and embroidery cones',
      name: 'rawMaterialDesc',
      desc: '',
      args: [],
    );
  }

  /// `Fabrics Warehouse`
  String get fabrics {
    return Intl.message(
      'Fabrics Warehouse',
      name: 'fabrics',
      desc: '',
      args: [],
    );
  }

  /// `All types of fabrics`
  String get fabricsDesc {
    return Intl.message(
      'All types of fabrics',
      name: 'fabricsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Accessories Warehouse`
  String get accessories {
    return Intl.message(
      'Accessories Warehouse',
      name: 'accessories',
      desc: '',
      args: [],
    );
  }

  /// `Buttons and zippers`
  String get accessoriesDesc {
    return Intl.message(
      'Buttons and zippers',
      name: 'accessoriesDesc',
      desc: '',
      args: [],
    );
  }

  /// `kg`
  String get kg {
    return Intl.message(
      'kg',
      name: 'kg',
      desc: '',
      args: [],
    );
  }

  /// `m`
  String get m {
    return Intl.message(
      'm',
      name: 'm',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
