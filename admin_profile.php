
<?php
session_start();
require_once 'connection.php';

if (!isset($_SESSION['email'])) {
    die("يرجى تسجيل الدخول أولاً.");
}

try {
    $stmt = $pdo->prepare("SELECT user.id, user.name, user.email, user.phone, user.password, administrator.is_superAdmin 
                          FROM user 
                          JOIN administrator ON user.id = administrator.user_id 
                          WHERE user.email = :email");
    $stmt->bindParam(':email', $_SESSION['email']);
    $stmt->execute();
    $admin = $stmt->fetch();
} catch(PDOException $e) {
    die("خطأ في جلب البيانات: " . $e->getMessage());
}

$success_message = '';
$error_message = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'] ?? $admin['name'];
    $phone = $_POST['phone'] ?? $admin['phone'];
    $oldPassword = $_POST['old_password'] ?? '';
    $newPassword = $_POST['new_password'] ?? '';
    $confirmPassword = $_POST['confirm_password'] ?? '';

    try {
        // Update name and phone
        $stmt = $pdo->prepare("UPDATE user SET name = :name, phone = :phone WHERE id = :id");
        $stmt->execute(['name' => $name, 'phone' => $phone, 'id' => $admin['id']]);
        $success_message = "تم تحديث البيانات الشخصية بنجاح.";

        // Update password if provided
        if ($oldPassword && $newPassword && $newPassword === $confirmPassword) {
            if ($oldPassword === $admin['password']) {
                $stmt = $pdo->prepare("UPDATE user SET password = :password WHERE id = :id");
                $stmt->execute(['password' => $newPassword, 'id' => $admin['id']]);
                $success_message .= " وتم تحديث كلمة المرور.";
            } else {
                $error_message = "كلمة المرور الحالية غير صحيحة.";
            }
        } elseif ($newPassword || $confirmPassword) {
            $error_message = "يرجى التأكد من تطابق كلمة المرور الجديدة وتأكيدها.";
        }

        // Refresh data
        $stmt = $pdo->prepare("SELECT user.id, user.name, user.email, user.phone, administrator.is_superAdmin 
                              FROM user 
                              JOIN administrator ON user.id = administrator.user_id 
                              WHERE user.email = :email");
        $stmt->bindParam(':email', $_SESSION['email']);
        $stmt->execute();
        $admin = $stmt->fetch();

    } catch (PDOException $e) {
        $error_message = "حدث خطأ أثناء تحديث البيانات.";
    }
}
?>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>الملف الشخصي للمشرف</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@400;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Tajawal', sans-serif; }
    </style>
</head>
<body class="bg-gray-100">
<div class="flex min-h-screen bg-gray-100 font-sans">
    <aside class="w-64 bg-white shadow-lg p-6">
        <?php include 'sidebar.php'; ?>
    </aside>
    <main class="flex-1 p-10 space-y-6 overflow-x-auto">


<div class="min-h-screen flex">

    <!-- Sidebar -->
    

<main class="flex-1 bg-gray-100 p-6 flex items-center justify-center">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-3xl">
        <h2 class="text-3xl font-bold text-teal-600 mb-6 text-center">الملف الشخصي للمشرف</h2>

        <?php if ($success_message): ?>
            <div class="bg-green-100 text-green-700 p-3 rounded mb-4"><?php echo $success_message; ?></div>
        <?php elseif ($error_message): ?>
            <div class="bg-red-100 text-red-700 p-3 rounded mb-4"><?php echo $error_message; ?></div>
        <?php endif; ?>

        <form method="POST" class="space-y-6">
            <div>
                <label class="block mb-1 text-sm font-semibold">الاسم الكامل</label>
                <input type="text" name="name" value="<?php echo htmlspecialchars($admin['name']); ?>" required
                       class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-teal-500">
            </div>
            <div>
                <label class="block mb-1 text-sm font-semibold">رقم الجوال</label>
                <input type="text" name="phone" pattern="^05\d{8}$" title="يجب أن يبدأ الرقم بـ 05 ويتكون من 10 أرقام" value="<?php echo htmlspecialchars($admin['phone']); ?>"
                       class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-teal-500">
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label class="block mb-1 text-sm font-semibold">كلمة المرور الحالية</label>
                    <input type="password" name="old_password"
                           class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-teal-500">
                </div>
                <div>
                    <label class="block mb-1 text-sm font-semibold">كلمة المرور الجديدة</label>
                    <input type="password" name="new_password" pattern=".{6,}" title="كلمة المرور يجب أن تكون 6 أحرف على الأقل"
                           class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-teal-500">
                </div>
                <div class="md:col-span-2">
                    <label class="block mb-1 text-sm font-semibold">تأكيد كلمة المرور</label>
                    <input type="password" name="confirm_password" pattern=".{6,}" title="يرجى تأكيد كلمة المرور الجديدة بشكل صحيح"
                           class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-teal-500">
                </div>
            </div>
            <div class="text-left">
                <button type="submit" class="bg-teal-600 hover:bg-teal-700 text-white px-6 py-2 rounded-lg shadow">
                    حفظ التغييرات
                </button>
            </div>
        
        </form>
        <div class="mt-6 text-left">
            <a href="dashboard.php" class="text-blue-600 hover:underline">← العودة إلى لوحة التحكم</a>
        </div>
    
    </div>
</div>

</main>
</div>
</body>
</html>

    </main>
</div>
