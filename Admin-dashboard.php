<?php
session_start();

// Include your database connection file
require_once 'connection.php';

// Check if admin is logged in
if (!isset($_SESSION['Email'])) {
    die("Please login first");
}

try {
    // Prepare SQL query to get admin's full name and superadmin status
    $stmt = $pdo->prepare("SELECT FirstName, is_superAdmin FROM administrator WHERE Email = :email");
    $stmt->bindParam(':email', $_SESSION['Email']);
    $stmt->execute();
    
    // Fetch the result
    $admin = $stmt->fetch();

} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}

// Fetch users data for the table
$users = [];
try {
    $stmt = $pdo->query("SELECT user_id, full_name, phone, status, is_admin FROM users");
    $users = $stmt->fetchAll();
} catch(PDOException $e) {
    echo "Error fetching users: " . $e->getMessage();
}
?>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>لوحة تحكم المشرفين</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .sidebar-mini .sidebar-content {
            display: none;
        }
    </style>
</head>
<body class="bg-gray-100 font-sans">
    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <aside id="sidebar" class="w-64 bg-white shadow-md p-4 flex flex-col justify-between h-full transition-all duration-300">
            <div>
                <div class="flex justify-between items-center py-6">
                    <h1 class="text-2xl font-bold text-teal-500 sidebar-content">لوحة المشرفين</h1>
                    <button id="toggleButton" class="text-gray-700 hover:text-teal-500">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                        </svg>
                    </button>
                </div>
                <nav class="mt-6 sidebar-content">
                    <ul>
                        <li class="mb-4">
                            <a href="#" class="flex items-center justify-between text-gray-700 hover:text-teal-500">
                                <div class="flex items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mx-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
                                    </svg>
                                    <span>إدارة المستخدمين</span>
                                </div>
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 text-gray-700 hover:text-teal-500" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
                                </svg>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="flex items-center justify-between text-gray-700 hover:text-teal-500">
                                <div class="flex items-center space-x-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mx-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                    </svg>
                                    <span>تقارير المستخدمين</span>
                                </div>
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 text-gray-700 hover:text-teal-500" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
                                </svg>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
            <div class="flex items-center sidebar-content">
                <img src="profile.png" alt="User Avatar" class="rounded-full border-2 border-teal-500 m-2 size-10" />
                <span class="ml-2 text-gray-700"><?php echo htmlspecialchars($admin['FirstName'] ?? ''); ?></span>
                <a href="logout.php" class="ml-2">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 text-gray-700 hover:text-teal-500" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                    </svg>
                </a>
            </div>
        </aside>

        <!-- Main content -->
        <main class="flex-1 p-6 overflow-auto">
            <!-- Header -->
            <header class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-gray-800">
                    <?php echo "مرحبا, " . htmlspecialchars($admin['FirstName'] ?? ''); ?>
                </h2>
            </header>

            <!-- Stats Section -->
            <div class="grid grid-cols-3 gap-4 bg-white p-4 rounded-lg shadow-md mb-6">
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
                        <span class="text-gray-900 text-lg font-bold">
                            <?php 
                                $activeUsers = array_filter($users, function($user) {
                                    return $user['status'] == 1;
                                });
                                echo count($activeUsers);
                            ?>
                        </span>
                    </div>
                </div>
                
                <!-- Add User Button -->
                <?php if ($admin && $admin['is_superAdmin'] == 1): ?>
                <div class="flex items-center gap-4 border-l-2 pl-4 p-2">
                    <a href="add_user.php" class="flex items-center gap-2 text-blue-500">
                        <div class="bg-blue-100 rounded-full flex items-center justify-center p-2">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                            </svg>
                        </div>
                        <div class="flex flex-col">
                            <span class="text-gray-700 text-sm font-semibold">إضافة مستخدم جديد</span>
                        </div>
                    </a>
                </div>
                <?php endif; ?>
            </div>

            <!-- Users Table Section -->
            <div class="bg-white shadow rounded-lg overflow-hidden">
                <div class="flex justify-between items-center p-2 m-2">
                    <h1 class="text-3xl font-bold text-gray-800 m-2">قائمة المستخدمين</h1>
                    <!-- Search and Filter -->
                    <div class="flex items-center gap-4">
                        <!-- Search -->
                        <div class="relative">
                            <input
                                type="search"
                                name="search"
                                id="search"
                                class="p-2 pl-8 bg-gray-100 border border-gray-200 rounded-lg shadow-sm text-center pr-4 focus:outline-none lg:w-72"
                                placeholder="البحث"
                            />
                            <span class="absolute inset-y-0 right-2 flex items-center pointer-events-none ml-16">
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-gray-500" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" />
                                </svg>
                            </span>
                        </div>
                        <!-- Filter -->
                        <div class="relative flex items-center">
                            <span class="absolute right-10 text-gray-500">الترتيب بواسطة:</span>
                            <select 
                                name="filter" 
                                id="filter" 
                                class="p-2 pl-8 bg-gray-100 border border-gray-200 rounded-lg shadow-sm text-left appearance-none lg:w-64 focus:outline-none"
                            >
                                <option value="id-asc">ID تصاعدي</option>
                                <option value="id-desc">ID تنازلي</option>
                                <option value="name-asc">الاسم (أ-ي)</option>
                                <option value="name-desc">الاسم (ي-أ)</option>
                                <option value="status-active">النشطون أولاً</option>
                                <option value="status-inactive">غير النشطين أولاً</option>
                            </select>
                            <span class="absolute inset-y-0 left-2 flex items-center pointer-events-none">
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 text-gray-500" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
                                </svg>
                            </span>
                        </div>
                    </div>
                </div>
                <table class="min-w-full text-right">
                    <thead class="bg-white border-b text-teal-500 shadow shadow-lg mb-4">
                        <tr>
                            <th class="py-3 px-4">رقم المستخدم</th>
                            <th class="py-3 px-4">اسم المستخدم</th>
                            <th class="py-3 px-4">رقم الهاتف</th>
                            <th class="py-3 px-4">الحالة</th>
                            <th class="py-3 px-4">صلاحية</th>
                            <th class="py-3 px-4">إجراءات</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($users as $user): ?>
                        <tr class="border-b">
                            <td class="py-3 px-4"><?php echo htmlspecialchars($user['user_id']); ?></td>
                            <td class="py-3 px-4"><?php echo htmlspecialchars($user['full_name']); ?></td>
                            <td class="py-3 px-4"><?php echo htmlspecialchars($user['phone']); ?></td>
                            <td class="py-3 px-4">
                                <label class="relative inline-flex items-center cursor-pointer">
                                    <input type="checkbox" class="sr-only peer" <?php echo $user['status'] == 1 ? 'checked' : ''; ?> 
                                        onchange="updateUserStatus(this, <?php echo $user['user_id']; ?>)">
                                    <div class="w-11 h-6 <?php echo $user['status'] == 1 ? 'bg-green-500' : 'bg-red-500'; ?> peer-focus:outline-none peer-focus:ring-2 peer-focus:ring-blue-400 rounded-full peer"></div>
                                    <span class="absolute top-0.5 left-[2px] bg-white border border-gray-300 h-5 w-5 rounded-full transition-transform peer-checked:translate-x-5 peer-checked:border-white"></span>
                                </label>
                            </td>
                            <td class="py-3 px-4">
                                <?php echo $user['is_admin'] == 1 ? 'مشرف' : 'مستخدم عادي'; ?>
                            </td>
                            <td class="py-3 px-4">
                                <div class="flex space-x-2 space-x-reverse">
                                    <button onclick="editUser(<?php echo $user['user_id']; ?>)" class="text-blue-500 hover:text-blue-700">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                                        </svg>
                                    </button>
                                    <button onclick="confirmDelete(<?php echo $user['user_id']; ?>)" class="text-red-500 hover:text-red-700">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                        </svg>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </main>
    </div>

    <script>
        // Sidebar toggle functionality
        const sidebar = document.getElementById("sidebar");
        const toggleButton = document.getElementById("toggleButton");

        toggleButton.addEventListener("click", () => {
            if (sidebar.classList.contains("w-64")) {
                sidebar.classList.remove("w-64");
                sidebar.classList.add("w-16", "sidebar-mini");
            } else {
                sidebar.classList.remove("w-16", "sidebar-mini");
                sidebar.classList.add("w-64");
            }
        });

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
            switch(filterValue) {
                case 'id-asc': return [0, 'asc'];
                case 'id-desc': return [0, 'desc'];
                case 'name-asc': return [1, 'asc'];
                case 'name-desc': return [1, 'desc'];
                case 'status-active': return ['status', 'desc'];
                case 'status-inactive': return ['status', 'asc'];
                default: return [0, 'asc'];
            }
        }

        // Update user status
        function updateUserStatus(checkbox, userId) {
            const status = checkbox.checked ? 1 : 0;
            
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
                    alert('حدث خطأ أثناء تحديث الحالة');
                    checkbox.checked = !checkbox.checked;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                checkbox.checked = !checkbox.checked;
            });
        }

        // Edit user
        function editUser(userId) {
            window.location.href = `edit_user.php?id=${userId}`;
        }

        // Confirm delete
        function confirmDelete(userId) {
            if (confirm('هل أنت متأكد من حذف هذا المستخدم؟')) {
                fetch('delete_user.php', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        user_id: userId
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert('حدث خطأ أثناء حذف المستخدم');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('حدث خطأ أثناء حذف المستخدم');
                });
            }
        }

        // Initialize event listeners
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('search').addEventListener('input', filterUsers);
            document.getElementById('filter').addEventListener('change', filterUsers);
        });
    </script>
</body>
</html>