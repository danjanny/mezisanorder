import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/base/presentation/button/quickcount_custom_button.dart';
import 'package:skeleton/base/presentation/textformfield/quickcount_text_form_field.dart';
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

  @override
  void initState() {
    super.initState();
    _orderCubit = context.read<OrderCubit>();
    _customerNameController =
        TextEditingController(text: _orderCubit?.state.customerName ?? '');
    _addressController =
        TextEditingController(text: _orderCubit?.state.shippingAddress ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdeenioAppbar(
        title: 'Data Customer',
        onBack: () {
          QR.popUntilOrPush(MezisanOrderRoutes.mainPagePath);
        },
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: AdeenioScrollableWidget(
                    formKey: _formKey,
                    formEnabled: true,
                    children: [
                      SizedBox(height: 20),
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
                      SizedBox(
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
                          _orderCubit?.updateState(shippingAddress: text);
                        },
                      ),
                    ]),
              ),
              SizedBox(
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
                  child: BlocConsumer<OrderCubit, OrderState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        final isButtonEnabled = (state.customerName != '') &&
                            (state.shippingAddress != '');
                        return QuickcountButton(
                          text: 'Lanjut',
                          state: isButtonEnabled
                              ? QuickcountButtonState.enabled
                              : QuickcountButtonState.disabled,
                          onPressed: isButtonEnabled
                              ? () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    FocusScope.of(context)
                                        .unfocus(); // Dismiss keyboard
                                    // Handle form submission
                                  }
                                }
                              : null,
                        );
                      })))
        ],
      ),
    );
  }
}
