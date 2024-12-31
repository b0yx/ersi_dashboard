import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/mechanical_inspection_controller.dart';
import 'package:image_picker/image_picker.dart';

class MechanicalInspectionView extends GetView<MechanicalInspectionController> {
  const MechanicalInspectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F9F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.black54),
            onPressed: () => Get.offAllNamed('/home'),
          ),
        ],
        title: const Text(
          'الفحص الميكانيكي (السباكة)',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPlumbingSection(),
              const SizedBox(height: 20),
              _buildSewageSection(),
              const SizedBox(height: 20),
              _buildElementsSection(),
              const SizedBox(height: 20),
              _buildRainwaterSection(),
              const SizedBox(height: 20),
              _buildMaterialQualitySection(),
              const SizedBox(height: 20),
              _buildTanksSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to next page
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF96E6B3),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
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
      ),
    );
  }

  Widget _buildPlumbingSection() {
    return _buildInspectionCard(
      title: 'أ-اختبار الضغط للتمديدات الداخلية',
      checkboxValue: controller.selectedPlumbing,
    );
  }

  Widget _buildSewageSection() {
    return _buildInspectionCard(
      title: 'ب-شبكة الصرف الصحي',
      checkboxValue: controller.selectedSewage,
      options: const ['مطابق', 'غير مطابق'],
    );
  }

  Widget _buildElementsSection() {
    return _buildInspectionCard(
      title: 'ج-العناصر القوية',
      checkboxValue: controller.selectedElements,
    );
  }

  Widget _buildRainwaterSection() {
    return _buildInspectionCard(
      title: 'د- شبكة تصريف مياة الأمطار',
      checkboxValue: controller.selectedRainwater,
    );
  }

  Widget _buildMaterialQualitySection() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'ه-نوعية وجودة المواد الصحية',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildDropdownField(
                  'جودة المواد',
                  ['ممتاز', 'جيد', 'مقبول'],
                  controller.materialQuality,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildDropdownField(
                  'نوع المواد',
                  ['إيطالي', 'صيني', 'محلي'],
                  controller.materialType,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildImageGrid(),
        ],
      ),
    );
  }

  Widget _buildTanksSection() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'ع-خزانات المياة',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('خزانات أرضية'),
                    const SizedBox(height: 10),
                    _buildDropdownField(
                      'النوع',
                      ['اسمنتي', 'بلاستيك', 'فايبر'],
                      controller.groundTankType,
                    ),
                    const SizedBox(height: 10),
                    _buildDropdownField(
                      'الحالة',
                      ['ممتاز', 'جيد', 'مقبول'],
                      controller.groundTankCondition,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('خزانات السطح'),
                    const SizedBox(height: 10),
                    _buildDropdownField(
                      'النوع',
                      ['بلاستيك', 'فايبر', 'استانلس'],
                      controller.surfaceTankType,
                    ),
                    const SizedBox(height: 10),
                    _buildDropdownField(
                      'الحالة',
                      ['جيد', 'ممتاز', 'مقبول'],
                      controller.surfaceTankCondition,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildImageGrid(),
        ],
      ),
    );
  }

  Widget _buildInspectionCard({
    required String title,
    required RxBool checkboxValue,
    List<String>? options,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Checkbox(
                    value: checkboxValue.value,
                    onChanged: (value) => checkboxValue.value = value ?? false,
                    activeColor: const Color(0xFF96E6B3),
                  )),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (options != null) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: options
                  .map((option) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Chip(
                          label: Text(option),
                          backgroundColor: const Color(0xFFF1F9F4),
                        ),
                      ))
                  .toList(),
            ),
          ],
          const SizedBox(height: 15),
          _buildImageGrid(),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        if (index == 2) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.add_circle,
                color: Color(0xFF96E6B3),
                size: 30,
              ),
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  // Handle image
                }
              },
            ),
          );
        }
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage('assets/placeholder.png'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdownField(
    String hint,
    List<String> items,
    RxString value,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(
        () => DropdownButton<String>(
          value: value.value.isEmpty ? null : value.value,
          hint: Text(hint),
          isExpanded: true,
          underline: const SizedBox(),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: (newValue) => value.value = newValue ?? '',
        ),
      ),
    );
  }
}
