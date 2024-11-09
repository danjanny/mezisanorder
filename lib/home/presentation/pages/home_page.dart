import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/base/presentation/appbar/quickcount_home_app_bar.dart';
import 'package:skeleton/base/presentation/icons/icon_asset.dart';
import 'package:skeleton/base/presentation/styles/text_styles.dart';
import '../../../base/presentation/textformfield/app_colors.dart';
import '../../../route/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return PopScope(
        onPopInvokedWithResult: (_, __) {
          if (QR.history.length > 0) {
            QR.history.clear();
          }

          SystemNavigator.pop();
        },
        child: Scaffold(
          appBar: const QuickcountHomeAppBar(),
          body: Stack(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Menu Utama',
                                  style: TextStyles.heading24Bold.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              MenuCardItem(
                                iconPath: IconAsset.inputHasilPilkadaIcon,
                                title: 'Input Hasil Pilkada',
                                subtitle: 'Kirim hasil perhitungan cepat',
                                onTap: () {
                                  QR.to(AppRoutes.inputResultPath);
                                },
                              ),
                              const SizedBox(height: 19),
                              MenuCardItem(
                                iconPath: IconAsset.editProfileIcon,
                                title: 'Edit Profil',
                                subtitle:
                                    'Perbaharui data anda atau ubah jika terdapat kesalahan',
                                onTap: () {
                                  QR.to(AppRoutes.editProfilePath);
                                },
                              ),
                              const SizedBox(height: 19),
                              MenuCardItem(
                                iconPath: IconAsset.logoutIcon,
                                title: 'Logout',
                                subtitle: 'Keluar ke menu awal',
                                onTap: () {
                                  logout(context);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    Text('powered by',
                        style: TextStyles.body16Regular
                            .copyWith(height: 20 / 16, color: AppColors.grey)),
                    const SizedBox(height: 4),
                    Image.asset(
                      IconAsset.companyLogo,
                      width: 200,
                      height: 35,
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
      );
    });
  }

  void logout(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Yakin keluar kembali ke halaman awal?'),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.dangerMain,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 8), // Added spacing between buttons
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primaryColor,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () async {
                        var box = Hive.box('settings');
                        await box.put('isLogin', false);
                        QR.navigator.popUntilOrPush(AppRoutes.rootPath);
                        Navigator.pop(context);
                      },
                      child: const Text('Yakin'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class MenuCardItem extends StatelessWidget {
  final String? iconPath;
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;

  const MenuCardItem(
      {super.key, this.iconPath, this.title, this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 13.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: AppColors.grey2,
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath ?? '',
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    style: TextStyles.body16Bold.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle ?? '',
                    style: TextStyles.body14Regular
                        .copyWith(color: AppColors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
