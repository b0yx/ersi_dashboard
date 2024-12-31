import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/electrical_inspection_controller.dart';
import 'package:image_picker/image_picker.dart';

class ElectricalInspectionView extends GetView<ElectricalInspectionController> {
  const ElectricalInspectionView({Key? key}) : super(key: key);

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
          'الفحص الكهربائي',
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
            children: [
              _buildSystemSection(),
              const SizedBox(height: 20),
              _buildInspectionSection('أ-الإضاءة', 
                controller.lightingType, 
                controller.lightingCondition,
                controller.lightingDistribution),
              const SizedBox(height: 20),
              _buildSimpleSection('ب-نظام المسارات', controller.pathwayType),
              const SizedBox(height: 20),
              _buildInspectionSection('ج-المنافذ',
                controller.outletsType,
                controller.outletsCondition,
                controller.outletsDistribution),
              const SizedBox(height: 20),
              _buildInspectionSection('د-المفاتيح',
                controller.switchesType,
                controller.switchesCondition,
                controller.switchesDistribution),
              const SizedBox(height: 20),
              _buildInspectionSection('ه-اللوحات الفرعية',
                controller.subPanelsType,
                controller.subPanelsCondition,
                controller.subPanelsDistribution),
              const SizedBox(height: 20),
              _buildInspectionSection('و-القواطع',
                controller.breakersType,
                controller.breakersCondition,
                controller.breakersDistribution),
              const SizedBox(height: 20),
              _buildInspectionSection('ز-اللوحات الرئيسية',
                controller.mainPanelsType,
                controller.mainPanelsCondition,
                controller.mainPanelsDistribution),
              const SizedBox(height: 20),
              _buildWiringSection('ح-الأسلاك',
                controller.wiringType,
                controller.wiringSize,
                controller.wiringConnection),
              const SizedBox(height: 20),
              _buildWiringSection('ط-الكيبلات الرئيسية',
                controller.mainCablesType,
                controller.mainCablesSize,
                controller.mainCablesConnection),
              const SizedBox(height: 20),
              _buildSimpleSection('ي-نظام التأريض', controller.groundingSystem),
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

  Widget _buildSystemSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'النظام المستخدم',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildDropdownButton(controller.systemType, ['كهربائي']),
          const SizedBox(height: 15),
          _buildImageGrid(),
        ],
      ),
    );
  }

  Widget _buildInspectionSection(String title, RxString type, RxString condition, RxString distribution) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildLabeledDropdown('نوعها', type, ['مطابق', 'غير مطابق']),
          const SizedBox(height: 10),
          _buildLabeledDropdown('حالتها', condition, ['مطابق', 'غير مطابق']),
          const SizedBox(height: 10),
          _buildLabeledDropdown('توزيعها', distribution, ['مطابق', 'غير مطابق']),
          const SizedBox(height: 15),
          _buildImageGrid(),
        ],
      ),
    );
  }

  Widget _buildWiringSection(String title, RxString type, RxString size, RxString connection) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildLabeledDropdown('النوع', type, ['بوري']),
          const SizedBox(height: 10),
          _buildLabeledDropdown('الحجم', size, ['على قوة', 'القوة 2']),
          const SizedBox(height: 10),
          _buildLabeledDropdown('طريقة التوصيل', connection, ['مطابق', 'غير مطابق']),
          const SizedBox(height: 15),
          _buildImageGrid(),
        ],
      ),
    );
  }

  Widget _buildSimpleSection(String title, RxString value) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildDropdownButton(value, ['كهربائي', 'كافي']),
          const SizedBox(height: 15),
          _buildImageGrid(),
        ],
      ),
    );
  }

  Widget _buildLabeledDropdown(String label, RxString value, List<String> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: _buildDropdownButton(value, items),
        ),
        const SizedBox(width: 10),
        Text(label),
      ],
    );
  }

  Widget _buildDropdownButton(RxString value, List<String> items) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(
        () => DropdownButton<String>(
          value: value.value,
          isExpanded: true,
          underline: const SizedBox(),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: (newValue) {
            if (newValue != null) value.value = newValue;
          },
        ),
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

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
