

<?php
// بدء الجلسة لحماية الصفحة
session_start();
// استدعاء الاتصال بقاعدة البيانات
require_once 'connection.php';

// تسجيل الخروج إذا تم الضغط على زر logout
if (isset($_POST['logout'])) {
    session_destroy();
    header("Location: login.php");
    exit();
}

// التحقق من تسجيل الدخول، إذا لم يتم تسجيل الدخول يتم إعادة التوجيه
if (!isset($_SESSION['email'])) {
    header("Location: login.php");
    exit();
}

try {
    $stmt = $pdo->query("SELECT * FROM project");
    $stmt->execute();
    $reports = $stmt->fetchAll();

} catch (PDOException $e) {
    die("Error: " . $e->getMessage());
}

// Fetch users with their report counts
$users = [];
try {
    $stmt = $pdo->query("SELECT 
        u.id, 
        u.name, 
        u.phone, 
        u.users_approve,
        COALESCE(a.is_superAdmin, 0) AS is_superadmin,
        (SELECT COUNT(*) FROM report WHERE user_id = u.id) AS report_count
    FROM 
        user u
    LEFT JOIN 
        administrator a ON u.id = a.user_id
    ");
    $users = $stmt->fetchAll();
        
    // echo "<pre>";
    // print_r($users);
    // echo "</pre>";
} catch(PDOException $e) {
    die("Error fetching users: " . $e->getMessage());
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
   
    </style>
</head>
<body class="bg-gray-50">
    <div class="flex flex-col md:flex-row min-h-screen overflow-hidden">
        <!-- Sidebar -->
        <?php

        include "sidebar.php"; 
        ?>

        <!-- Main content -->
        
<header class="flex justify-between items-center mb-6">
            </header>
<main class="flex-1 bg-gray-50 p-10 space-y-10">
    <header class="mb-6">
        <p class="text-sm text-gray-500 mt-1">لوحة تقارير المشاريع</p>
    </header>

    <!-- إحصائيات -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <div class="bg-white shadow-md rounded-xl p-6 flex justify-between items-center">
            <div>
                <p class="text-gray-500 text-sm mb-1">إجمالي التقارير</p>
                <p class="text-3xl font-bold text-gray-800"><?php echo count($reports); ?></p>
            </div>
            <div class="bg-blue-100 text-blue-600 p-3 rounded-full">📄</div>
        </div>
        <div class="bg-white shadow-md rounded-xl p-6 flex justify-between items-center">
            <div>
                <p class="text-gray-500 text-sm mb-1">عدد المهندسين</p>
                <p class="text-3xl font-bold text-gray-800"><?php echo count(array_unique(array_column($reports, 'reportOwner'))); ?></p>
            </div>
            <div class="bg-green-100 text-green-600 p-3 rounded-full">👷‍♂️</div>
        </div>
    </div>

    <!-- جدول التقارير -->
    <div class="bg-white shadow rounded-xl p-6 overflow-x-auto">
        <h3 class="text-xl font-semibold text-gray-800 mb-4">قائمة التقارير</h3>
    <!-- شريط البحث وخيارات الترتيب -->
    <div class="flex flex-col sm:flex-row justify-between items-center mb-4 gap-4">
        <div class="relative w-full sm:w-1/2">
            <input
                type="search"
                id="searchInput"
                placeholder="ابحث عن تقرير أو مهندس"
                class="w-full p-2 pl-10 bg-gray-100 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
            <i class="fas fa-search absolute right-3 top-3 text-gray-400"></i>
        </div>
        <select id="sortSelect" class="w-full sm:w-1/3 p-2 bg-gray-100 border border-gray-300 rounded-lg shadow-sm">
            <option value="id-desc">الأحدث أولاً</option>
            <option value="id-asc">الأقدم أولاً</option>
            <option value="name-asc">اسم التقرير (أ-ي)</option>
            <option value="name-desc">اسم التقرير (ي-أ)</option>
            <option value="owner-asc">اسم المهندس (أ-ي)</option>
            <option value="owner-desc">اسم المهندس (ي-أ)</option>
        </select>
    </div>

        <table class="min-w-full text-sm text-right border border-gray-200 divide-y divide-gray-100">
            <thead class="bg-gray-100 text-gray-600">
                <tr>
                    <th class="p-3">رقم التقرير</th>
                    <th class="p-3">اسم التقرير</th>
                    <th class="p-3">اسم المهندس</th>
<th class="p-3">رقم الجوال</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-100">
                <?php foreach ($reports as $report): ?>
                <tr class="hover:bg-gray-50">
                    <td class="p-3"><?php echo htmlspecialchars($report['id']); ?></td>
                    <td class="p-3 font-medium text-teal-700"><?php echo htmlspecialchars($report['name']); ?></td>
                    <td class="p-3"><?php echo htmlspecialchars($report['reportOwner']); ?> </td>
                    <td class="p-3"><?php echo htmlspecialchars($report['phone']); ?></td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</main>

    </div>


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
                    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
                    $stmt = $pdo->prepare("INSERT INTO user (name, email, phone, password, users_approve) VALUES (?, ?, ?, ?, 1)");
                    $stmt->execute([$name, $email, $phone, $hashedPassword]);

                    $user_id = $pdo->lastInsertId();
                    $stmt = $pdo->prepare("INSERT INTO administrator (user_id, is_superAdmin) VALUES (?, 0)");
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
    // Sidebar toggle functionality
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
            
    document.getElementById('sidebarToggle').addEventListener('click', function() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('sidebar-mini');

        // Store state in localStorage
        const isMini = sidebar.classList.contains('sidebar-mini');
        localStorage.setItem('sidebarMini', isMini);
    });

    // Check localStorage on page load
    document.addEventListener('DOMContentLoaded', function() {
        if (localStorage.getItem('sidebarMini') === 'true') {
            document.getElementById('sidebar').classList.add('sidebar-mini');
        }
    });

    // Update user status function
    function updateUserStatus(checkbox, userId) {
        const status = checkbox.checked ? 1 : 0;
        const switchWrapper = checkbox.nextElementSibling;

        fetch('update_user_status.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    user_id: userId,
                    status: status
                })
            })
            .then(response => response.json())
            .then(data => {
                if (!data.success) {
                    throw new Error(data.message || 'Failed to update status');
                }
                switchWrapper.classList.toggle('bg-green-500', checkbox.checked);
                switchWrapper.classList.toggle('bg-red-500', !checkbox.checked);
                showToast('تم تحديث الحالة بنجاح', 'success');
            })
            .catch(error => {
                console.error('Error:', error);
                showToast('تعذر تحديث الحالة', 'error');
                checkbox.checked = !checkbox.checked;
            });
    }

    // Search and filter functionality
    function filterUsers() {
        const searchInput = document.getElementById('search');
        const filterSelect = document.getElementById('filter');
        const tbody = document.querySelector('tbody');
        const rows = Array.from(tbody.querySelectorAll('tr'));

        const searchTerm = searchInput.value.toLowerCase();
        const filterValue = filterSelect.value;

        // Filter rows based on search
        const filteredRows = rows.filter(row => {
            const userName = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
            const userId = row.querySelector('td:first-child').textContent;
            const userPhone = row.querySelector('td:nth-child(3)').textContent;

            return userName.includes(searchTerm) ||
                userId.includes(searchTerm) ||
                userPhone.includes(searchTerm);
        });

        // Sort the filtered rows
        filteredRows.sort((a, b) => {
            const [sortColumn, sortDirection] = getSortParams(filterValue);

            if (sortColumn === 'status') {
                const statusA = a.querySelector('td:nth-child(4) input').checked ? 1 : 0;
                const statusB = b.querySelector('td:nth-child(4) input').checked ? 1 : 0;
                return sortDirection === 'desc' ? statusB - statusA : statusA - statusB;
            } else if (sortColumn === 'reports') {
                const reportsA = parseInt(a.querySelector('td:nth-child(5) span').textContent);
                const reportsB = parseInt(b.querySelector('td:nth-child(5) span').textContent);
                return sortDirection === 'desc' ? reportsB - reportsA : reportsA - reportsB;
            } else {
                const cellA = a.querySelector(`td:nth-child(${sortColumn + 1})`).textContent;
                const cellB = b.querySelector(`td:nth-child(${sortColumn + 1})`).textContent;

                let comparison = 0;

                if (sortColumn === 0) { // ID column
                    comparison = parseInt(cellA) - parseInt(cellB);
                } else { // Name or other text columns
                    comparison = cellA.localeCompare(cellB, 'ar');
                }

                return sortDirection === 'desc' ? -comparison : comparison;
            }
        });

        // Rebuild the table
        while (tbody.firstChild) {
            tbody.removeChild(tbody.firstChild);
        }

        filteredRows.forEach(row => tbody.appendChild(row));
    }

    // Helper function to determine sort parameters
    function getSortParams(filterValue) {
        switch (filterValue) {
            case 'id-asc':
                return [0, 'asc'];
            case 'id-desc':
                return [0, 'desc'];
            case 'name-asc':
                return [1, 'asc'];
            case 'name-desc':
                return [1, 'desc'];
            case 'status-active':
                return ['status', 'desc'];
            case 'status-inactive':
                return ['status', 'asc'];
            case 'reports-asc':
                return ['reports', 'asc'];
            case 'reports-desc':
                return ['reports', 'desc'];
            default:
                return [0, 'asc'];
        }
    }

    // Show toast notification
    function showToast(message, type = 'info') {
        const toast = document.createElement('div');
        toast.className = `fixed bottom-4 right-4 z-50 px-4 py-2 rounded shadow-lg text-white transition-opacity duration-500 ease-in-out ${type === 'error' ? 'bg-red-500' : 'bg-green-500'}`;
        toast.textContent = message;
        document.body.appendChild(toast);
        setTimeout(() => {
            toast.style.opacity = '0';
            setTimeout(() => toast.remove(), 500);
        }, 3000);
    }

    // Toggle admin form
    function toggleAdminForm() {
        const form = document.getElementById('adminForm');
        form.classList.toggle('hidden');
    }

    // Initialize event listeners
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('search').addEventListener('input', filterUsers);
        document.getElementById('filter').addEventListener('change', filterUsers);
    });
    </script>

    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const searchInput = document.getElementById('searchInput');
        const sortSelect = document.getElementById('sortSelect');
        const table = document.querySelector('table');
        const tbody = table.querySelector('tbody');

        function normalize(text) {
            return text.toLowerCase().trim();
        }

        function sortRows(rows, key, direction) {
            return rows.sort((a, b) => {
                const valA = normalize(a.querySelector(`td[data-key="${key}"]`).textContent);
                const valB = normalize(b.querySelector(`td[data-key="${key}"]`).textContent);
                if (!isNaN(valA) && !isNaN(valB)) {
                    return direction === 'asc' ? valA - valB : valB - valA;
                }
                return direction === 'asc' ? valA.localeCompare(valB, 'ar') : valB.localeCompare(valA, 'ar');
            });
        }

        function filterAndSort() {
            const searchTerm = normalize(searchInput.value);
            const rows = Array.from(tbody.querySelectorAll('tr'));

            let [sortKey, sortDirection] = sortSelect.value.split('-');

            const visibleRows = rows.filter(row => {
                return Array.from(row.querySelectorAll('td')).some(td => normalize(td.textContent).includes(searchTerm));
            });

            const sortedRows = sortRows(visibleRows, sortKey, sortDirection);

            tbody.innerHTML = '';
            sortedRows.forEach(row => tbody.appendChild(row));
        }

        searchInput.addEventListener('input', filterAndSort);
        sortSelect.addEventListener('change', filterAndSort);
    });
    </script>

</body>
</html>