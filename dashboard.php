
<?php
session_start();
require_once 'connection.php';

// تسجيل الخروج
if (isset($_POST['logout'])) {
    session_destroy();
    header("Location: login.php");
    exit();
}

// منع الوصول لغير المسجلين
if (!isset($_SESSION['email'])) {
    header("Location: login.php");
    exit();
}

// جلب بيانات المشرف
try {
    $stmt = $pdo->prepare("SELECT user.name, administrator.is_superAdmin 
                          FROM user 
                          JOIN administrator ON user.id = administrator.user_id 
                          WHERE user.email = :email");
    $stmt->bindParam(':email', $_SESSION['email']);
    $stmt->execute();
    $admin = $stmt->fetch();
} catch (PDOException $e) {
    die("خطأ: " . $e->getMessage());
}

// تحديث حالة المستخدم (بدون JSON)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_status'])) {
    $user_id = intval($_POST['user_id'] ?? 0);
    $status = intval($_POST['status'] ?? 0);
    try {
        $stmt = $pdo->prepare("UPDATE user SET users_approve = ? WHERE id = ?");
        $stmt->execute([$status, $user_id]);
        header("Location: dashboard.php");
        exit();
    } catch (PDOException $e) {
        die("خطأ أثناء التحديث: " . $e->getMessage());
    }
}

// جلب المستخدمين
try {
    $stmt = $pdo->query("SELECT 
        u.id, u.name, u.phone, u.users_approve,
        COALESCE(a.is_superAdmin, 0) AS is_superadmin,
        (SELECT COUNT(*) FROM project WHERE user_id = u.id) AS report_count
        FROM user u
        LEFT JOIN administrator a ON u.id = a.user_id");
    $users = $stmt->fetchAll();
} catch (PDOException $e) {
    die("فشل في جلب المستخدمين: " . $e->getMessage());
}
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>لوحة التحكم</title>
    <link rel='preconnect' href='https://fonts.googleapis.com'>
    <link href='https://fonts.googleapis.com/css2?family=Tajawal:wght@400;700&display=swap' rel='stylesheet'>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* General Styles */
        body {
            font-family: 'Tajawal', sans-serif;
        }
        
        /* Sidebar Styles */
        .sidebar {
            width: 18rem;
            transition: all 0.3s ease;
        }
        
        .sidebar-mini .sidebar-content {
            display: none;
        }
        
        .sidebar-mini {
            width: 5rem !important;
        }
        
        .sidebar-mini .sidebar-collapse-icon {
            transform: rotate(180deg);
        }
        
        .nav-item {
            transition: all 0.2s ease;
        }
        
        .nav-item:hover {
            transform: translateX(-5px);
        }
        
        /* Main Content Styles */
        .main-content {
            flex: 1;
            padding: 2rem;
            transition: all 0.3s ease;
            width: calc(100% - 18rem);
        }
        
        .sidebar-mini ~ .main-content {
            width: calc(100% - 5rem);
        }
        
        .data-table th {
            background-color: #f1f5f9;
            color: #1f2937;
        }
        
        .data-table td {
            background-color: #fff;
        }
        
        /* Responsive Styles */
        @media (max-width: 1024px) {
            .sidebar {
                width: 16rem;
            }
            .main-content {
                width: calc(100% - 16rem);
            }
        }
        
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            .main-content {
                width: 100%;
                margin-right: 0;
                padding: 1rem;
            }
        }
        
        /* Table Responsiveness */
        .table-container {
            overflow-x: auto;
            max-width: 100%;
        }
        
        /* Floating Button */
        .floating-button {
            position: fixed;
            bottom: 2rem;
            left: 2rem;
            z-index: 50;
        }
    </style>
</head>
<body class="bg-gray-50">
    <div class="flex flex-col md:flex-row min-h-screen overflow-hidden">
        <!-- Sidebar -->
         <aside class="">
         <?php
            include "sidebar.php"; // Include sidebar content here
        ?>
         </aside>
       

        <!-- Main content -->
        <main class="main-content">
            <!-- Header -->
            <header class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-gray-800 mb-6"><?php echo "مرحبا, " . htmlspecialchars($admin['name'] ?? ''); ?></h2>
            </header>

            <!-- Stats Section -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 bg-white p-4 rounded-lg shadow-md mb-6">
                <!-- Total Users -->
                <div class="flex items-center gap-4 border-l-2 pl-4 p-2">
                    <div class="bg-blue-100 p-3 rounded-full">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-8 h-8 text-blue-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
                        </svg>
                    </div>
                    <div class="flex flex-col justify-center items-center font-bold">
                        <span class="text-gray-500 text-sm">إجمالي المستخدمين</span>
                        <span class="text-gray-900 text-lg font-bold"><?php echo count($users); ?></span>
                    </div>
                </div>

                <!-- Active Users -->
                <div class="flex items-center gap-4 border-l-2 pl-4 p-2">
                    <div class="bg-green-100 p-3 rounded-full">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-8 h-8 text-green-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                    <div class="flex flex-col justify-center items-center font-bold">
                        <span class="text-gray-500 text-sm">المستخدمون النشطون</span>
                        <span class="text-gray-900 text-lg font-bold"><?php
                            $activeUsers = array_filter($users, function ($user) {
                                return $user['users_approve'] == 1;
                            });
                            echo count($activeUsers);
                        ?></span>
                    </div>
                </div>

                <!-- Total Reports -->
                <div class="flex items-center gap-4 border-l-2 pl-4 p-2">
                    <div class="bg-purple-100 p-3 rounded-full">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-8 h-8 text-purple-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                        </svg>
                    </div>
                    <div class="flex flex-col justify-center items-center font-bold">
                        <span class="text-gray-500 text-sm">إجمالي التقارير</span>
                        <span class="text-gray-900 text-lg font-bold"><?php
                            $totalReports = array_sum(array_column($users, 'report_count'));
                            echo $totalReports;
                        ?></span>
                    </div>
                </div>
            </div>

            <!-- Users Table Section -->
            <div class="bg-white shadow rounded-lg overflow-hidden">
                <div class="flex flex-col md:flex-row justify-between items-center p-2 m-2">
                    <h1 class="text-2xl md:text-3xl font-bold text-gray-800 m-2">قائمة المهندسين</h1>
                    <!-- Search and Filter -->
                    <div class="flex flex-col md:flex-row items-center gap-4 w-full md:w-auto">
                        <!-- Search -->
                        <div class="relative w-full md:w-auto">
                            <input type="search" name="search" id="search" class="p-2 pl-8 bg-gray-100 border border-gray-200 rounded-lg shadow-sm text-center pr-4 focus:outline-none w-full" placeholder="البحث" />
                            <span class="absolute inset-y-0 right-2 flex items-center pointer-events-none ml-16">
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-gray-500" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" />
                                </svg>
                            </span>
                        </div>
                        <!-- Filter -->
                        <div class="relative flex items-center w-full md:w-auto">
                            <span class="absolute right-10 text-gray-500 hidden md:block">الترتيب بواسطة:</span>
                            <select name="filter" id="filter" class="p-2 pl-8 bg-gray-100 border border-gray-200 rounded-lg shadow-sm text-left appearance-none w-full focus:outline-none">
                                <option value="id-asc">ID تصاعدي</option>
                                <option value="id-desc">ID تنازلي</option>
                                <option value="name-asc">الاسم (أ-ي)</option>
                                <option value="name-desc">الاسم (ي-أ)</option>
                                <option value="status-active">النشطون أولاً</option>
                                <option value="status-inactive">غير النشطين أولاً</option>
                                <option value="reports-asc">التقارير (أقل لأكثر)</option>
                                <option value="reports-desc">التقارير (أكثر لأقل)</option>
                            </select>
                            <span class="absolute inset-y-0 left-2 flex items-center pointer-events-none">
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 text-gray-500" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
                                </svg>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="table-container">
                    <table class="min-w-full text-right">
                        <thead class="bg-white border-b text-teal-500 shadow shadow-lg mb-4">
                            <tr>
                                <th class="py-3 px-4">رقم المهندس</th>
                                <th class="py-3 px-4">اسم المهندس</th>
                                <th class="py-3 px-4">رقم الهاتف</th>
                                <th class="py-3 px-4">الحالة</th>
                                <th class="py-3 px-4">عدد التقارير</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($users as $user): ?>
                            <tr class="border-b">
                                <td class="py-3 px-4"><?php echo htmlspecialchars($user['id']); ?></td>
                                <td class="py-3 px-4"><?php echo htmlspecialchars($user['name']); ?></td>
                                <td class="py-3 px-4"><?php echo htmlspecialchars($user['phone']); ?></td>
                                <td class="py-3 px-4">
                                    <label class="relative inline-flex items-center cursor-pointer">
                                        <input type="checkbox" class="sr-only peer" <?php echo $user['users_approve'] == 1 ? 'checked' : ''; ?> onchange="updateUserStatus(this, <?php echo $user['id']; ?>)">
                                        <div class="w-11 h-6 transition-colors duration-300 ease-in-out <?php echo $user['users_approve'] == 1 ? 'bg-green-500' : 'bg-red-500'; ?> peer-focus:outline-none peer-focus:ring-2 peer-focus:ring-blue-400 rounded-full peer"></div>
                                        <span class="absolute top-0.5 left-[2px] bg-white border border-gray-300 h-5 w-5 rounded-full transition-transform peer-checked:translate-x-5 peer-checked:border-white"></span>
                                    </label>
                                </td>
                                <td class="py-3 px-4">
                                    <span class="px-3 py-1 rounded-full <?php echo $user['report_count'] > 0 ? 'bg-blue-100 text-blue-800' : 'bg-gray-100 text-gray-800'; ?>">
                                        <?php echo htmlspecialchars($user['report_count']); ?>
                                    </span>
                                </td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <!-- Floating button to add admin -->
    <?php if (!empty($admin['is_superAdmin']) && $admin['is_superAdmin'] == 1): ?>
<button onclick="toggleAdminForm()" class="floating-button bg-green-600 hover:bg-green-700 text-white rounded-full w-14 h-14 text-3xl shadow-lg flex items-center justify-center">
        +
    </button>
<?php endif; ?>

    <!-- Admin add form -->
    <div id="adminForm" class="hidden fixed bottom-24 left-6 bg-white p-6 rounded-lg shadow-xl border w-80 z-50">
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-lg font-bold">إضافة مشرف جديد</h3>
            <button onclick="toggleAdminForm()" class="text-gray-500 hover:text-red-500 text-xl">&times;</button>
        </div>
        <?php
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_admin'])) {
            $name = $_POST['admin_name'] ?? '';
            $email = $_POST['admin_email'] ?? '';
            $phone = $_POST['admin_phone'] ?? '';
            $password = $_POST['admin_password'] ?? '';

            if ($name && $email && $phone && $password) {
                try {
                    $hashedPassword = md5($password);
                    $stmt = $pdo->prepare("INSERT INTO user (name, email, phone, password, users_approve ) VALUES (?, ?, ?, ?, 1)");
                    $stmt->execute([$name, $email, $phone, $hashedPassword]);

                    $user_id = $pdo->lastInsertId();
                    $stmt = $pdo->prepare("INSERT INTO administrator (user_id, is_superAdmin , is_admin) VALUES (?, 0 , 1)");
                    $stmt->execute([$user_id]);

                    echo "<script>
                        setTimeout(() => {
                            document.getElementById('adminForm').classList.add('hidden');
                            alert('تمت إضافة المشرف بنجاح!');
                        }, 100);
                    </script>";
                } catch (PDOException $e) {
                    echo '<div class="bg-red-100 text-red-700 p-3 mb-4 rounded">خطأ: ' . $e->getMessage() . '</div>';
                }
            } else {
                echo '<div class="bg-red-100 text-red-700 p-3 mb-4 rounded">يرجى تعبئة جميع الحقول.</div>';
            }
        }
        ?>
        <form method="POST">
            <input type="hidden" name="add_admin" value="1">
            <div class="mb-2">
                <label class="block text-sm">الاسم</label>
                <input type="text" name="admin_name" class="w-full border rounded px-3 py-2" required>
            </div>
            <div class="mb-2">
                <label class="block text-sm">البريد الإلكتروني</label>
                <input type="email" name="admin_email" class="w-full border rounded px-3 py-2" required>
            </div>
            <div class="mb-2">
                <label class="block text-sm">رقم الهاتف</label>
                <input type="text" name="admin_phone" class="w-full border rounded px-3 py-2" required>
            </div>
            <div class="mb-3">
                <label class="block text-sm">كلمة المرور</label>
                <input type="password" name="admin_password" class="w-full border rounded px-3 py-2" required>
            </div>
            <button type="submit" class="bg-green-600 text-white w-full py-2 rounded hover:bg-green-700">إضافة</button>
        </form>
    </div>

    <script>
document.addEventListener('DOMContentLoaded', function () {
    // === عناصر DOM ===
    const sidebar = document.getElementById('sidebar');
    const toggleBtn = document.getElementById('sidebarToggle');
    const collapseIcon = document.querySelector('.sidebar-collapse-icon');
    const searchInput = document.getElementById('search');
    const filterSelect = document.getElementById('filter');
    const tbody = document.querySelector('tbody');

    // === حالة الشريط الجانبي من التخزين المحلي ===
    if (localStorage.getItem('sidebarMini') === 'true') {
        sidebar.classList.add('sidebar-mini');
        if (collapseIcon) collapseIcon.style.transform = 'rotate(180deg)';
    }

    // === زر التبديل للشريط الجانبي ===
    toggleBtn.addEventListener('click', function () {
        sidebar.classList.toggle('sidebar-mini');
        const isMini = sidebar.classList.contains('sidebar-mini');
        if (collapseIcon) collapseIcon.style.transform = isMini ? 'rotate(180deg)' : 'rotate(0deg)';
        localStorage.setItem('sidebarMini', isMini);
    });

    // === تحديث حالة المستخدم ===
    window.updateUserStatus = function (checkbox, userId) {
        const status = checkbox.checked ? 1 : 0;
        const switchWrapper = checkbox.nextElementSibling;

        fetch('update_user_status.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ user_id: userId, status: status })
        })
        .then(res => res.json())
        .then(data => {
            if (!data.success) throw new Error(data.message || 'فشل في التحديث');
            switchWrapper.classList.toggle('bg-green-500', checkbox.checked);
            switchWrapper.classList.toggle('bg-red-500', !checkbox.checked);
            showToast('تم تحديث الحالة بنجاح', 'success');
        })
        .catch(error => {
            console.error('Error:', error);
            showToast('تعذر تحديث الحالة', 'error');
            checkbox.checked = !checkbox.checked;
        });
    };

    // === فلترة المستخدمين ===
    function filterUsers() {
        const searchTerm = searchInput.value.toLowerCase();
        const filterValue = filterSelect.value;
        const rows = Array.from(tbody.querySelectorAll('tr'));

        const filteredRows = rows.filter(row => {
            const userName = row.children[1].textContent.toLowerCase();
            const userId = row.children[0].textContent;
            const userPhone = row.children[2].textContent;
            return userName.includes(searchTerm) || userId.includes(searchTerm) || userPhone.includes(searchTerm);
        });

        filteredRows.sort((a, b) => {
            const [sortColumn, sortDirection] = getSortParams(filterValue);
            if (sortColumn === 'status') {
                const aVal = a.children[3].querySelector('input').checked ? 1 : 0;
                const bVal = b.children[3].querySelector('input').checked ? 1 : 0;
                return sortDirection === 'desc' ? bVal - aVal : aVal - bVal;
            } else if (sortColumn === 'reports') {
                const aVal = parseInt(a.children[4].querySelector('span').textContent);
                const bVal = parseInt(b.children[4].querySelector('span').textContent);
                return sortDirection === 'desc' ? bVal - aVal : aVal - bVal;
            } else {
                const aText = a.children[sortColumn].textContent;
                const bText = b.children[sortColumn].textContent;
                const cmp = sortColumn === 0 ? parseInt(aText) - parseInt(bText) : aText.localeCompare(bText, 'ar');
                return sortDirection === 'desc' ? -cmp : cmp;
            }
        });

        tbody.innerHTML = '';
        filteredRows.forEach(row => tbody.appendChild(row));
    }

    // === تحديد بارامترات الترتيب ===
    function getSortParams(filterValue) {
        switch (filterValue) {
            case 'id-asc': return [0, 'asc'];
            case 'id-desc': return [0, 'desc'];
            case 'name-asc': return [1, 'asc'];
            case 'name-desc': return [1, 'desc'];
            case 'status-active': return ['status', 'desc'];
            case 'status-inactive': return ['status', 'asc'];
            case 'reports-asc': return ['reports', 'asc'];
            case 'reports-desc': return ['reports', 'desc'];
            default: return [0, 'asc'];
        }
    }

    // === إشعارات (توست) ===
    window.showToast = function (message, type = 'info') {
        const toast = document.createElement('div');
        toast.className = `fixed bottom-4 right-4 z-50 px-4 py-2 rounded shadow-lg text-white transition-opacity duration-500 ease-in-out ${type === 'error' ? 'bg-red-500' : 'bg-green-500'}`;
        toast.textContent = message;
        document.body.appendChild(toast);
        setTimeout(() => {
            toast.style.opacity = '0';
            setTimeout(() => toast.remove(), 500);
        }, 3000);
    };

    // === إظهار / إخفاء نموذج المدير ===
    window.toggleAdminForm = function () {
        const form = document.getElementById('adminForm');
        form.classList.toggle('hidden');
    };

    // === الاستماع لحقول البحث والتصفية ===
    if (searchInput && filterSelect) {
        searchInput.addEventListener('input', filterUsers);
        filterSelect.addEventListener('change', filterUsers);
    }

    toggleBtn.addEventListener('click', function() {
                sidebar.classList.toggle('sidebar-mini');
                
                // Rotate icon
                if (sidebar.classList.contains('sidebar-mini')) {
                    collapseIcon.style.transform = 'rotate(180deg)';
                } else {
                    collapseIcon.style.transform = 'rotate(0deg)';
                }
                
                // Store state
                localStorage.setItem('sidebarMini', sidebar.classList.contains('sidebar-mini'));
            });
            
});
</script>

</body>
</html> 