import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/structural_inspection_controller.dart';
import 'package:image_picker/image_picker.dart';

class StructuralInspectionView extends GetView<StructuralInspectionController> {
  const StructuralInspectionView({Key? key}) : super(key: key);

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
          'الفحص الإنشائي',
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
              _buildPlanMatchingSection(),
              const SizedBox(height: 20),
              _buildStructuralElementsSection(),
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

  Widget _buildPlanMatchingSection() {
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
            '1- مطابقة المخطط مع المنفذ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImageUploadButton('إضافة صورة المنفذ'),
              _buildImageUploadButton('إضافة صورة المخطط'),
            ],
          ),
          const SizedBox(height: 20),
          _buildDropdownField('نسبة التطابق', ['جيد جداً', 'جيد', 'مقبول', 'سيء']),
        ],
      ),
    );
  }

  Widget _buildStructuralElementsSection() {
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
            '2- فحص عناصر الهيكل الإنشائي',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          _buildStructuralItem(
            'A- فحص القواعد',
            hasVerticalAlignment: false,
            hasAxisTest: false,
          ),
          const SizedBox(height: 15),
          _buildStructuralItem(
            'B- فحص الجدار',
            hasVerticalAlignment: false,
            hasAxisTest: false,
          ),
          const SizedBox(height: 15),
          _buildStructuralItem(
            'C- فحص الأعمدة',
            hasVerticalAlignment: true,
            hasAxisTest: true,
          ),
          const SizedBox(height: 15),
          _buildStructuralItem(
            'D- فحص الجسور',
            hasVerticalAlignment: false,
            hasAxisTest: false,
          ),
          const SizedBox(height: 15),
          _buildStructuralItem(
            'E- فحص الأسقف',
            hasVerticalAlignment: false,
            hasAxisTest: false,
          ),
          const SizedBox(height: 15),
          _buildStructuralItem(
            'F- فحص غرفة المصعد',
            hasVerticalAlignment: false,
            hasAxisTest: false,
          ),
          const SizedBox(height: 15),
          _buildGrooveItem('G- فحص الأخاديد'),
        ],
      ),
    );
  }

  Widget _buildImageUploadButton(String title) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: const Icon(Icons.add_photo_alternate_outlined),
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                // Handle image selection
              }
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String title, List<String> options) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(title),
        value: null,
        items: options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          // Handle dropdown selection
        },
      ),
    );
  }

  Widget _buildStructuralItem(String title, {
    required bool hasVerticalAlignment,
    required bool hasAxisTest,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.check_box_outline_blank),
          ],
        ),
        const SizedBox(height: 15),
        _buildConcreteStrengthTest(),
        const SizedBox(height: 15),
        _buildReinforcementTest(),
        if (hasVerticalAlignment) ...[
          const SizedBox(height: 15),
          _buildVerticalAlignmentTest(),
        ],
        if (hasAxisTest) ...[
          const SizedBox(height: 15),
          _buildAxisTest(),
        ],
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 5,
          itemBuilder: (context, index) {
            if (index == 4) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      // Handle image selection
                    }
                  },
                ),
              );
            }
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildConcreteStrengthTest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('فحص مقاومة الخرسانة باستخدام مطرقة الشميدس'),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'قراءة المطرقة',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'مقاومة الخرسانة',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReinforcementTest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('فحص كمية حديد التسليح'),
        const SizedBox(height: 10),
        _buildDropdownField('مطابق/غير مطابق', ['مطابق', 'غير مطابق']),
      ],
    );
  }

  Widget _buildVerticalAlignmentTest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('فحص الاستقامة الرأسية'),
        const SizedBox(height: 10),
        _buildDropdownField('مطابق/غير مطابق', ['مطابق', 'غير مطابق']),
      ],
    );
  }

  Widget _buildAxisTest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('فحص المحاور'),
        const SizedBox(height: 10),
        _buildDropdownField('مطابق/غير مطابق', ['مطابق', 'غير مطابق']),
      ],
    );
  }

  Widget _buildGrooveItem(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.check_box_outline_blank),
          ],
        ),
        const SizedBox(height: 15),
        const Text('طول الأخاديد'),
        const SizedBox(height: 10),
        _buildDropdownField('مطابق/غير مطابق', ['مطابق', 'غير مطابق']),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 5,
          itemBuilder: (context, index) {
            if (index == 4) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      // Handle image selection
                    }
                  },
                ),
              );
            }
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        ),
      ],
    );
  }
}
