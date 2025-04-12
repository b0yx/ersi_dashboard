<?php
session_start();
require 'connection.php';

// Security headers
header("X-Frame-Options: DENY");
header("X-Content-Type-Options: nosniff");
header("X-XSS-Protection: 1; mode=block");

// Check if user is logged in and is superadmin
if (!isset($_SESSION['user']) || $_SESSION['user']['role'] !== 'superadmin')
{
    echo "<div style='
        font-family: Tajawal, sans-serif;
        padding: 20px;
        margin: 50px auto;
        background: #ffe5e5;
        color: #b10000;
        border-radius: 10px;
        width: fit-content;
        text-align: center;
        box-shadow: 0 0 15px rgba(0,0,0,0.1);
    '>
        🚫 ليس لديك صلاحية الدخول إلى هذه الصفحة.
    </div>";
    exit;
}

// CSRF token generation
if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}
?>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>لوحة المسؤولين</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Tajawal', sans-serif;
        }
        .action-link {
            transition: all 0.2s ease;
        }
        .action-link:hover {
            transform: translateY(-1px);
        }
    </style>
</head>
<body class="bg-gray-100">

    <!-- Navigation Bar -->
    <nav class="bg-white shadow p-4 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-teal-600">لوحة إدارة المسؤولين</h1>
        <div class="flex items-center gap-4">
            <span class="text-gray-600"><?php echo htmlspecialchars($_SESSION['user']['name']); ?></span>
            <a href="logout.php" class="text-red-500 hover:text-red-700 action-link">
                <i class="fas fa-sign-out-alt"></i> تسجيل خروج
            </a>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="p-6 max-w-7xl mx-auto">
        <div class="bg-white shadow rounded-lg p-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-gray-800">قائمة المسؤولين</h2>
                <a href="add_admin.php" class="bg-teal-600 hover:bg-teal-700 text-white px-4 py-2 rounded-lg action-link">
                    <i class="fas fa-plus ml-2"></i> إضافة مسؤول جديد
                </a>
            </div>
            
            <div class="overflow-x-auto">
                <table class="min-w-full table-auto text-right border rounded">
                    <thead class="bg-gray-100 text-gray-600 uppercase text-sm leading-normal">
                        <tr>
                            <th class="py-3 px-6">#</th>
                            <th class="py-3 px-6">الاسم</th>
                            <th class="py-3 px-6">البريد الإلكتروني</th>
                            <th class="py-3 px-6">الحالة</th>
                            <th class="py-3 px-6">الإجراءات</th>
                        </tr>
                    </thead>
                    <tbody class="text-gray-700 text-sm divide-y divide-gray-200">
                        <?php
                        // Prepared statement for security
                        $stmt = $conn->prepare("SELECT u.id, u.name, u.email, u.users_approve, a.is_superadmin FROM user u LEFT JOIN administrator a ON u.id = a.user_id ORDER BY u.name ASC;
");
                        $stmt->execute();
                        $result = $stmt->get_result();
                        
                        $count = 1;
                        while ($admin = $result->fetch_assoc()) {
                            $status = $admin['users_approve'] ? 
                                "<span class='px-2 py-1 bg-green-100 text-green-800 rounded-full text-xs font-medium'>مفعل</span>" : 
                                "<span class='px-2 py-1 bg-red-100 text-red-800 rounded-full text-xs font-medium'>غير مفعل</span>";
                            
                            echo "<tr class='hover:bg-gray-50'>";
                            echo "<td class='py-3 px-6'>" . $count . "</td>";
                            echo "<td class='py-3 px-6'>" . htmlspecialchars($admin['name']) . "</td>";
                            echo "<td class='py-3 px-6'>" . htmlspecialchars($admin['email']) . "</td>";
                            echo "<td class='py-3 px-6'>" . $status . "</td>";
                            echo "<td class='py-3 px-6'>
                                    <div class='flex items-center gap-3'>
                                        <a href='edit_admin.php?id=" . $admin['id'] . "' class='text-blue-500 hover:text-blue-700 action-link'>
                                            <i class='fas fa-edit'></i> تعديل
                                        </a>
                                        <a href='delete_admin.php?id=" . $admin['id'] . "&csrf_token=" . $_SESSION['csrf_token'] . "' 
                                           onclick=\"return confirm('هل أنت متأكد من حذف هذا المسؤول؟');\" 
                                           class='text-red-500 hover:text-red-700 action-link'>
                                            <i class='fas fa-trash-alt'></i> حذف
                                        </a>
                                        <a href='toggle_admin.php?id=" . $admin['id'] . "&csrf_token=" . $_SESSION['csrf_token'] . "' 
                                           class='text-yellow-600 hover:text-yellow-800 action-link'>
                                            <i class='fas fa-toggle-" . ($admin['users_approve'] ? "on" : "off") . "'></i> " . ($admin['users_approve'] ? "تعطيل" : "تفعيل") . "
                                        </a>
                                    </div>
                                  </td>";
                            echo "</tr>";
                            $count++;
                        }
                        $stmt->close();
                        ?>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script>
        // Confirm before important actions
        document.querySelectorAll('a[onclick]').forEach(link => {
            link.addEventListener('click', function(e) {
                if (!confirm(this.getAttribute('data-confirm') || 'هل أنت متأكد؟')) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>