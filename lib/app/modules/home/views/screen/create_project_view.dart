import 'package:ersei/app/core/constant/colors.dart';
import 'package:ersei/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/create_project_controller.dart';


class CreateProjectView extends GetView<CreateProjectController> {
  const CreateProjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.backgroundforapp,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Get.back(),
                              icon: const Icon(Icons.arrow_back_ios),
                              color: Colors.black54,
                            ),
                            const Expanded(
                              child: Center(
                                child: Image(
                                  image: AssetImage('images/ers.eilogo.png'),
                                  height: 60,
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            'إنشاء مشروع',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildInputField(
                          hint: 'اسم المشروع',
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 15),
                        _buildInputField(
                          hint: 'اسم جهة استلام التقرير',
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 15),
                        _buildInputField(
                          hint: 'رقم الهاتف',
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 15),
                        _buildDatePicker(context),
                        const SizedBox(height: 15),
                        _buildDropdownField(
                          title: 'الغرض من الفحص',
                          onTap: () => _showPurposeSelection(),
                        ),
                        const SizedBox(height: 15),
                        _buildDropdownField(
                          title: 'نوع المنشأة',
                          onTap: () => _showBuildingTypeSelection(),
                        ),
                        const Spacer(),
                        _buildNextButton(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String hint,
    TextAlign textAlign = TextAlign.left,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        textAlign: textAlign,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black38),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: controller.selectedDate.value,
          firstDate: DateTime(2000),
          lastDate: DateTime(2026),
        );
        if (picked != null) {
          controller.updateDate(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today,
              color: Color(0xFF96E6B3),
            ),
            const Spacer(),
            Obx(() => Text(
                  '${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF96E6B3),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Get.toNamed(Routes.INSPECTION_TYPES),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF96E6B3),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
        ),
        child: const Text(
          'NEXT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showPurposeSelection() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            ListTile(
              title: const Text('فحص سلامة المبنى', textAlign: TextAlign.right),
              onTap: () {
                controller.updatePurpose('فحص سلامة المبنى');
                Get.back();
              },
            ),
            ListTile(
              title:
                  const Text('فحص الصيانة الدورية', textAlign: TextAlign.right),
              onTap: () {
                controller.updatePurpose('فحص الصيانة الدورية');
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBuildingTypeSelection() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            ListTile(
              title: const Text('سكني', textAlign: TextAlign.right),
              onTap: () {
                controller.updateBuildingType('سكني');
                Get.back();
              },
            ),
            ListTile(
              title: const Text('تجاري', textAlign: TextAlign.right),
              onTap: () {
                controller.updateBuildingType('تجاري');
                Get.back();
              },
            ),
            ListTile(
              title: const Text('صناعي', textAlign: TextAlign.right),
              onTap: () {
                controller.updateBuildingType('صناعي');
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
