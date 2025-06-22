import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../data/model_api/selectedDoctor/Data.dart';
import '../../../../l10n/app_localizations.dart';
import '../../home/categories_item/categories_item.dart';
import '../../widgets/build_circleButton.dart';
import '../view_model/doctor_view_model.dart';
import 'doctor_card.dart';

class CategoryDetailsScreen extends StatefulWidget {
  const CategoryDetailsScreen({Key? key,}) : super(key: key);

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  String? specialty;
  DoctorViewModel? _viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      specialty = ModalRoute.of(context)?.settings.arguments as String?;
      if (specialty != null) {
        _viewModel = Provider.of<DoctorViewModel>(context, listen: false);
        print('Initializing for specialty: $specialty at ${DateTime.now()}');
        _viewModel!.clearCache(specialty!);
        _viewModel!.getSpecialDoctor(specialty: specialty!, forceRefresh: true);
        _viewModel!.startPolling(specialty!, interval: const Duration(seconds: 3));
        setState(() {});
      }
    });
  }


  @override
  void dispose() {
    _viewModel?.stopPolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (specialty == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final loc = AppLocalizations.of(context)!;
    final Map<String, String> specialtyMap = {
      'Cardiology': loc.cardiology,
      'Pulmonology': loc.pulmonology,
      'Dentistry': loc.dentistry,
      'Orthopedics': loc.orthopedics,
      'Pediatrics': loc.pediatrics,
      'Oncology': loc.oncology,
      'Ophthalmology': loc.ophthalmology,
      'Dermatology': loc.dermatology,
      'OB-GYN': loc.oBGYN,
      'Surgery': loc.surgery,
      'Physical therapy': loc.physicalTherapy,
      'Psychiatry': loc.psychiatry,
      'Neurology': loc.neurology,
      'Internal medicine': loc.internalMedicine,
      'ENT': loc.eNT,
    };

    final specialtyKey = specialty ?? "Unknown";
    String displayedSpecialty = specialtyMap[specialtyKey] ?? specialtyKey;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
          child: Consumer<DoctorViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BuildCircleButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        Localizations.localeOf(context).languageCode == 'ar'
                            ? "${AppLocalizations.of(context)!.doctors} $displayedSpecialty"
                            : "$displayedSpecialty ${AppLocalizations.of(context)!.doctors}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),

                      BuildCircleButton(
                        icon: Icons.refresh,
                        onTap: () async {
                          viewModel.clearCache(specialty!);
                          await viewModel.getSpecialDoctor(specialty: specialty!, forceRefresh: true);
                          print('Manual refresh triggered for $specialty at ${DateTime.now()}');
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: REdgeInsets.only(left: 20.w, right: 20.w, top: 5.h),
                    child: Divider(
                      color: Theme.of(context).dividerColor,
                      thickness: 0.5.w,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        viewModel.clearCache(specialty!);
                        await viewModel.getSpecialDoctor(specialty: specialty!, forceRefresh: true);
                        print('RefreshIndicator triggered for $specialty at ${DateTime.now()}');
                      },
                      child: StreamBuilder<List<Data>>(
                        stream: viewModel.getDataStream(specialty!),
                        builder: (context, snapshot) {
                          print('StreamBuilder snapshot for $specialty: ${snapshot.data?.map((e) => e.drID).toList()} at ${DateTime.now()}');
                          print('ConnectionState: ${snapshot.connectionState}, HasData: ${snapshot.hasData}, HasError: ${snapshot.hasError}, IsLoading: ${viewModel.isLoading}');
                          if (snapshot.connectionState == ConnectionState.waiting || (viewModel.isLoading && !snapshot.hasData)) {
                            return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, index) => const SkeletonLoader(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text(snapshot.error.toString()));
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child: Text(loc.noData));
                          }

                          return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final doctorData = snapshot.data![index];
                              return Directionality(
                                textDirection: TextDirection.ltr,
                                child: DoctorCard(doctor: doctorData),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              margin: REdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100.w,
                    height: 16.h,
                    color: Colors.grey[300],
                    margin: REdgeInsets.only(bottom: 8.h),
                  ),
                  Container(
                    width: 150.w,
                    height: 12.h,
                    color: Colors.grey[300],
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