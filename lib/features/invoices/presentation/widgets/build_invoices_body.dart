import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/widgets/custom_button.dart';
import 'package:hi_class_factory/features/invoices/presentation/manager/save_invoices/save_invoices_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../finishedProducts/data/models/product_model.dart';
import '../../../finishedProducts/data/models/size_model.dart';
import '../../data/models/invoice_model.dart';
import '../../data/models/select_product_model.dart';
import 'invoices_bottom_sheet.dart';
import 'items_table_section.dart';
import 'size_item.dart';

class BuildInvoicesBody extends StatefulWidget {
  const BuildInvoicesBody({super.key, required this.productsList});
  final List<ProductModel> productsList;

  @override
  State<BuildInvoicesBody> createState() => _BuildInvoicesBodyState();
}

class _BuildInvoicesBodyState extends State<BuildInvoicesBody> {
  ProductModel? productSelected;
  List<SizeModel>? sizeList;
  SelectProductModel? selectProductModel;
  TextEditingController customerController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController(text: "0");
  TextEditingController discountPercentageController = TextEditingController(text: "0");
  List<SelectProductModel> listProduct = [];
  final _formKey = GlobalKey<FormState>();
  final _formKeyName = GlobalKey<FormState>();
  double totalInvoice = 0;
  double totalInvoiceAfterDiscount = 0;
  bool isUpdating = false;
  @override
  void initState() {
    super.initState();
    discountController.addListener(() {
      if (isUpdating) return;
      isUpdating = true;
      double value = double.tryParse(discountController.text) ?? 0;
      double percent = (value / totalInvoice) * 100;
      discountPercentageController.text = percent.toStringAsFixed(2);
      isUpdating = false;
    });
    discountPercentageController.addListener(() {
      if (isUpdating) return;
      isUpdating = true;
      double percent = double.tryParse(discountPercentageController.text) ?? 0;
      double value = totalInvoice * (percent / 100);
      discountController.text = value.toStringAsFixed(2);
      isUpdating = false;
    });
  }

  @override
  void dispose() {
    discountController.dispose();
    discountPercentageController.dispose();
    priceController.dispose();
    qtyController.dispose();
    customerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKeyName,
        child: CustomScrollView(
          slivers: [
            ///اسم العميل
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: customerController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "اسم العميل",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v == null || v.isEmpty ? "مطلوب" : null,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomDropdown<ProductModel>.search(
                        hintText: 'اختر منتج',
                        initialItem: productSelected,
                        items: widget.productsList,
                        excludeSelected: false,
                        onChanged: (product) {
                          setState(() {
                            productSelected = product;
                            sizeList = product?.sizes;
                            selectProductModel = null;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          productSelected = null;
                          sizeList = null;
                          selectProductModel = null;
                        });
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            if (productSelected != null)
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final itemSize = sizeList![index];
                  return SizeItem(
                    itemSize: itemSize,
                    onTap: (selectItemColorSizeModel) {
                      if (selectItemColorSizeModel != null) {
                        setState(() {
                          selectProductModel = SelectProductModel(
                            size: selectItemColorSizeModel.size,
                            id: productSelected!.id,
                            productName: productSelected!.title,
                            qtyInStore: selectItemColorSizeModel.qty,
                            selectQty: 1,
                            colorName: selectItemColorSizeModel.color,
                            price: 0,
                          );
                        });
                      }
                    },
                  );
                }, childCount: sizeList!.length),
              ),
            if (selectProductModel != null)
              SliverToBoxAdapter(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "${selectProductModel!.productName} - ${selectProductModel!.size} - ${selectProductModel!.colorName}",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),

                      ///الكمية
                      TextFormField(
                        controller: qtyController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "الكمية",
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => v == null || v.isEmpty ? "مطلوب" : null,
                      ),
                      SizedBox(height: 8),

                      ///سعر الوحدة
                      TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "سعر الوحدة",
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => v == null || v.isEmpty ? "مطلوب" : null,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          selectProductModel = selectProductModel!.copyWith(
                            price: double.parse(priceController.text),
                            selectQty: int.parse(qtyController.text),
                          );
                          int index = listProduct.indexWhere(
                            (element) =>
                                element.id == selectProductModel!.id &&
                                element.size == selectProductModel!.size &&
                                element.colorName == selectProductModel!.colorName,
                          );

                          if (index != -1) {
                            listProduct[index] = listProduct[index].copyWith(
                              selectQty:
                                  listProduct[index].selectQty +
                                  selectProductModel!.selectQty,
                            );
                          } else {
                            listProduct.add(selectProductModel!);
                          }

                          qtyController.text = '';
                          priceController.text = '';
                          FocusScope.of(context).unfocus();
                          totalInvoice = getTotalInvoice(listProduct);

                          double discount = discountController.text == ''
                              ? 0
                              : double.parse(discountController.text);
                          double discountPercentage = (discount / totalInvoice) * 100;

                          discountPercentageController.text = discountPercentage
                              .toString();
                          totalInvoiceAfterDiscount = getTotalInvoiceAfterDiscount(
                            listProduct: listProduct,
                            discountValueString: discountController.text,
                            discountPercentString: discountPercentageController.text,
                          );
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: AppColors.darkCard,
                          elevation: 5,
                          // backgroundColor: AppColors.darkCard.withValues(alpha: .5),
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text("إضافة  "),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            if (listProduct.isNotEmpty)
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    ItemsTableSection(
                      listProduct: listProduct,
                      onTapDelete: (index) {
                        setState(() {
                          listProduct.removeAt(index);
                          totalInvoice = getTotalInvoice(listProduct);

                          double discount = discountController.text == ''
                              ? 0
                              : double.parse(discountController.text);
                          double discountPercentage = totalInvoice == 0
                              ? 0
                              : (discount / totalInvoice) * 100;

                          discountPercentageController.text = discountPercentage
                              .toString();
                          totalInvoiceAfterDiscount = getTotalInvoiceAfterDiscount(
                            listProduct: listProduct,
                            discountValueString: discountController.text,
                            discountPercentString: discountPercentageController.text,
                          );
                        });
                      },
                    ),

                    ///إجمالى الفاتورة
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "إجمالى الفاتورة:- $totalInvoice",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),

                    ///الخصم
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: discountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "الخصم",
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) => v == null || v.isEmpty ? "مطلوب" : null,
                            onChanged: (value) {
                              setState(() {
                                totalInvoiceAfterDiscount = getTotalInvoiceAfterDiscount(
                                  listProduct: listProduct,
                                  discountValueString: value,
                                  discountPercentString:
                                      discountPercentageController.text,
                                );
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: discountPercentageController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "نسبةالخصم",
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) => v == null || v.isEmpty ? "مطلوب" : null,
                            onChanged: (value) {
                              setState(() {
                                totalInvoiceAfterDiscount = getTotalInvoiceAfterDiscount(
                                  listProduct: listProduct,
                                  discountValueString: discountController.text,
                                  discountPercentString: value,
                                );
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    ///إجمالى بعد الخصم
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "إجمالى الفاتوره بعد الخصم:- \n $totalInvoiceAfterDiscount",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),

                    ///ازرار الفاتورة
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BlocConsumer<SaveInvoicesCubit, SaveInvoicesState>(
                            listener: (context, state) {
                              if (state is SaveInvoicesError ||
                                  state is SaveInvoicesSuccess) {
                                _openSheet(state);
                              }
                            },
                            builder: (context, state) {
                              return CustomButton(
                                text: "حفظ الفاتورة",
                                onPressed: saveInvoice,
                                backgroundColor: Colors.green,
                                // loading: true,
                                loading: state is SaveInvoicesLoading ? true : false,
                              );
                            },
                          ),
                          CustomButton(
                            text: "حذف",
                            onPressed: deleteInvoice,
                            backgroundColor: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  double getTotalInvoice(List<SelectProductModel> listProduct) {
    return listProduct.fold(0, (sum, item) => sum + (item.price * item.selectQty));
  }

  double getTotalInvoiceAfterDiscount({
    required List<SelectProductModel> listProduct,
    required String discountValueString,
    required String discountPercentString,
  }) {
    double discountValue = discountValueString.isEmpty
        ? 0
        : double.parse(discountValueString);
    double discountPercent = discountPercentString.isEmpty
        ? 0
        : double.parse(discountPercentString);
    double subTotal = listProduct.fold(
      0,
      (sum, item) => sum + (item.price * item.selectQty),
    );

    if (discountPercent > 0) {
      discountValue = subTotal * (discountPercent / 100);
    }

    return subTotal - discountValue;
  }

  void saveInvoice() async {
    if (!_formKeyName.currentState!.validate()) return;
    InvoiceModel invoice = InvoiceModel(
      id: '',
      invoiceNumber: '',
      customerName: customerController.text,
      date: DateTime.now().toLocal(),
      items: listProduct,
      totalBeforeDiscount: totalInvoice,
      discount: discountController.text == "" ? 0 : double.parse(discountController.text),
      totalAfterDiscount: totalInvoiceAfterDiscount,
      status: InvoiceStatus.paid,
    );
    context.read<SaveInvoicesCubit>().saveInvoice(invoice: invoice);
  }

  void deleteInvoice() {
    setState(() {
      productSelected = null;
      sizeList = null;
      selectProductModel = null;
      customerController.text = '';
      qtyController.text = '';
      priceController.text = '';
      discountController.text = '';
      discountPercentageController.text = '';
      listProduct = [];
      totalInvoice = 0;
      totalInvoiceAfterDiscount = 0;
    });
  }

  void _openSheet(SaveInvoicesState state) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        if (state is SaveInvoicesError) {
          return FractionallySizedBox(
            heightFactor: 0.4,
            child: Center(child: Text(state.message)),
          );
        } else if (state is SaveInvoicesSuccess) {
          return FractionallySizedBox(
            heightFactor: 0.8,
            child: InvoicesBottomSheet(invoice: state.invoice),
          );
        }
        return SizedBox();
      },
    );
    if (!mounted) return;
    if (result != null && result == true) {
      deleteInvoice();
    } else {
      if (state is SaveInvoicesSuccess) {
        deleteInvoice();
      }
    }
  }
}
