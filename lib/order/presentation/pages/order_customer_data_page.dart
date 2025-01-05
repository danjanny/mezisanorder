import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/base/presentation/button/quickcount_custom_button.dart';
import 'package:skeleton/base/presentation/loading/adeenio_loading_dialog.dart';
import 'package:skeleton/base/presentation/loading/quickcount_loading_dialog.dart';
import 'package:skeleton/base/presentation/textformfield/quickcount_text_form_field.dart';
import 'package:skeleton/base/presentation/toast/quickcount_toast.dart';
import 'package:skeleton/order/domain/params/order_request_param.dart';
import 'package:skeleton/order/presentation/manager/order_cubit.dart';
import 'package:skeleton/order/presentation/widgets/adeenio_appbar.dart';
import 'package:skeleton/order/presentation/widgets/adeenio_scrollable_widget.dart';
import 'package:skeleton/route/mezisan_order_routes.dart';
import 'package:skeleton/route/routes.dart';

import '../manager/order_state.dart';

class OrderCustomerDataPage extends StatefulWidget {
  const OrderCustomerDataPage({super.key});

  @override
  State<OrderCustomerDataPage> createState() => _OrderCustomerDataPageState();
}

class _OrderCustomerDataPageState extends State<OrderCustomerDataPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _customerNameController;
  late TextEditingController _addressController;
  OrderCubit? _orderCubit;

  bool _isDialogShown = false;

  @override
  void initState() {
    super.initState();
    _orderCubit = context.read<OrderCubit>();
    _customerNameController =
        TextEditingController(text: _orderCubit?.state?.customerName ?? '');
    _addressController =
        TextEditingController(text: _orderCubit?.state?.shippingAddress ?? '');
  }

  @override
  void dispose() {
    // _orderCubit?.resetUiState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
          appBar: AdeenioAppbar(
            title: 'Data Customer',
            onBack: () {
              _orderCubit?.resetUiState();
              QR.popUntilOrPush(MezisanOrderRoutes.mainPagePath);
            },
          ),
          body: BlocListener<OrderCubit, OrderState?>(
              listener: (context, state) {
                print(state.toString());
                if (state?.uiState == OrderUiState.loading && !_isDialogShown) {
                  _isDialogShown = true;
                  CustomLoadingDialog.showDialog(context);
                } else if (state?.uiState == OrderUiState.loaded &&
                    _isDialogShown) {
                  _isDialogShown = false;
                  CustomLoadingDialog.hideDialog(context);
                  // Handle successful order submission
                } else if (state?.uiState == OrderUiState.error &&
                    _isDialogShown) {
                  _isDialogShown = false;
                  CustomLoadingDialog.hideDialog(context);
                }
              },
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: AdeenioScrollableWidget(
                            formKey: _formKey,
                            formEnabled: true,
                            children: [
                              const SizedBox(height: 20),
                              QuickcountTextFormField(
                                controller: _customerNameController,
                                titleLabel: 'Nama Pemesan',
                                inputLabel: 'contoh : Meszieshan Norrezka',
                                validator: (String? text) {
                                  return null;
                                },
                                onChange: (String text) {
                                  _orderCubit?.updateState(customerName: text);
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              QuickcountTextFormField(
                                controller: _addressController,
                                keyboardType: TextInputType.multiline,
                                titleLabel: 'Alamat',
                                inputLabel: 'contoh : Jl Lurah Kartoprawiro',
                                maxLines: 5,
                                validator: (String? text) {
                                  return null;
                                },
                                onChange: (String text) {
                                  _orderCubit?.updateState(
                                      shippingAddress: text);
                                },
                              ),
                            ]),
                      ),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          BlocBuilder<OrderCubit, OrderState?>(
                            builder: (context, state) {
                              final isButtonEnabled =
                                  (state?.customerName != '') &&
                                      (state?.shippingAddress != '');
                              return QuickcountButton(
                                text: 'Lanjut',
                                state: isButtonEnabled
                                    ? QuickcountButtonState.enabled
                                    : QuickcountButtonState.disabled,
                                onPressed: isButtonEnabled
                                    ? () {
                                        context.read<OrderCubit>().submitOrder(
                                              OrderRequestParam(
                                                customerName:
                                                    _customerNameController
                                                        .text,
                                                shippingAddress:
                                                    _addressController.text,
                                              ),
                                            );
                                      }
                                    : null,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )));
    });
  }
}
