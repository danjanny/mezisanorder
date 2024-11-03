import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeleton/base/presentation/appbar/quickcount_app_bar.dart';
import 'package:skeleton/base/presentation/icons/icon_asset.dart';
import 'package:skeleton/base/presentation/styles/text_styles.dart';

import '../../../base/presentation/textformfield/app_colors.dart';

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
      return Scaffold(
        appBar: const QuickcountAppBar(),
        body: Stack(
          children: [
            Container(
              color: AppColors.backgroundSolidDefault,
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            // Menu Utama
                            Text(
                              'Menu Utama',
                              style: TextStyles.heading24Bold.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const MenuCardItem(
                              iconPath: IconAsset.inputHasilPilkadaIcon,
                              title: 'Input Hasil Pilkada',
                              subtitle: 'Kirim hasil perhitungan cepat',
                            ),
                            const SizedBox(height: 19),
                            const MenuCardItem(
                              iconPath: IconAsset.uploadC1Icon,
                              title: 'Upload Formulir C1',
                              subtitle: 'Kirim foto formulir C1',
                            ),
                            const SizedBox(height: 19),
                            const MenuCardItem(
                              iconPath: IconAsset.editProfileIcon,
                              title: 'Edit Profil',
                              subtitle:
                                  'Perbaharui data anda atau ubah jika terdapat kesalahan',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
            // logo indikator
            Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    Text('powered by',
                        style: TextStyles.body16Regular
                            .copyWith(height: 20 / 16, color: AppColors.grey)),
                    const SizedBox(
                      height: 4,
                    ),
                    SvgPicture.asset(
                      IconAsset.companyLogo,
                      width: 200,
                      height: 35,
                    ),
                  ],
                ))
          ],
        ),
      );
    });
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
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(title ?? '',
                    style: TextStyles.body16Bold.copyWith(color: Colors.black)),
                const SizedBox(height: 2),
                Text(subtitle ?? '',
                    style: TextStyles.body14Regular
                        .copyWith(color: AppColors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
