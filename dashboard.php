<?php
session_start();
require_once 'connection.php';

// Authentication check
if (!isset($_SESSION['Email'])) {
    header("Location: login.php");
    exit();
}

try {
    // Get admin data
    $stmt = $pdo->prepare("SELECT FirstName, is_superAdmin FROM administrator WHERE Email = :email");
    $stmt->bindParam(':email', $_SESSION['Email']);
    $stmt->execute();
    $admin = $stmt->fetch();

    if (!$admin) {
        throw new Exception("Admin data not found");
    }

    // Get engineers with report counts
    $engineersQuery = "
        SELECT u.id, u.name, u.phone, u.users_approve as status, 
               COUNT(r.id) as report_count
        FROM user u
        LEFT JOIN report r ON u.id = r.eng_id
        GROUP BY u.id
        ORDER BY u.name
    ";
    $engineers = $pdo->query($engineersQuery)->fetchAll();

    // Get total reports count
    $totalReports = $pdo->query("SELECT COUNT(*) FROM report")->fetchColumn();

} catch(PDOException $e) {
    error_log("Database Error: " . $e->getMessage());
    die("An error occurred while fetching data. Please try again later.");
} catch(Exception $e) {
    error_log("Error: " . $e->getMessage());
    die($e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>لوحة تحكم المشرفين</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .sidebar-mini .sidebar-content {
            display: none;
        }
        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 30px;
        }
        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #f44336;
            transition: .4s;
            border-radius: 34px;
        }
        .slider:before {
            position: absolute;
            content: "";
            height: 22px;
            width: 22px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        input:checked + .slider {
            background-color: #4CAF50;
        }
        input:checked + .slider:before {
            transform: translateX(30px);
        }
    </style>
</head>
<body class="bg-gray-100 font-sans">
    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <aside id="sidebar" class="w-64 bg-white shadow-md p-4 flex flex-col justify-between transition-all duration-300">
            <div>
                <div class="flex justify-between items-center py-6">
                    <h1 class="text-2xl font-bold text-teal-500 sidebar-content">لوحة التحكم</h1>
                    <button id="toggleButton" class="text-gray-700 hover:text-teal-500">
                        <i class="fas fa-cog"></i>
                    </button>
                </div>
                <nav class="mt-6 sidebar-content">
                    <ul>
                        <li class="mb-4">
                            <a href="#" class="flex items-center justify-between text-gray-700 hover:text-teal-500">
                                <div class="flex items-center">
                                    <i class="fas fa-users mx-2"></i>
                                    <span>المهندسين</span>
                                </div>
                                <i class="fas fa-chevron-left"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="flex items-center justify-between text-gray-700 hover:text-teal-500">
                                <div class="flex items-center space-x-2">
                                    <i class="fas fa-file-alt mx-2"></i>
                                    <span>تقارير</span>
                                </div>
                                <i class="fas fa-chevron-left"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
            <div class="flex items-center sidebar-content">
                <img src="profile.png" alt="User Avatar" class="rounded-full border-2 border-teal-500 m-2 size-10">
                <span class="ml-2 text-gray-700"><?= htmlspecialchars($admin['FirstName'] ?? '') ?></span>
                <a href="logout.php" class="ml-2">
                    <i class="fas fa-sign-out-alt text-gray-700 hover:text-teal-500"></i>
                </a>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 p-6 overflow-auto">
            <header class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-gray-800">
                    <?= "مرحبا, " . htmlspecialchars($admin['FirstName'] ?? '') ?>
                </h2>
                <div class="text-sm text-gray-500">
                    <?= date('Y-m-d') ?>
                </div>
            </header>

            <!-- Stats Cards -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                <div class="bg-white p-4 rounded-lg shadow-md border-l-2 border-blue-500">
                    <div class="flex items-center gap-4">
                        <div class="bg-blue-100 p-3 rounded-full">
                            <i class="fas fa-users text-blue-500 text-xl"></i>
                        </div>
                        <div>
                            <span class="text-gray-500 text-sm">إجمالي المهندسين</span>
                            <span class="text-gray-900 text-lg font-bold block"><?= count($engineers) ?></span>
                        </div>
                    </div>
                </div>

                <div class="bg-white p-4 rounded-lg shadow-md border-l-2 border-green-500">
                    <div class="flex items-center gap-4">
                        <div class="bg-green-100 p-3 rounded-full">
                            <i class="fas fa-file-alt text-green-500 text-xl"></i>
                        </div>
                        <div>
                            <span class="text-gray-500 text-sm">إجمالي التقارير</span>
                            <span class="text-gray-900 text-lg font-bold block"><?= $totalReports ?></span>
                        </div>
                    </div>
                </div>

                <div class="bg-white p-4 rounded-lg shadow-md border-l-2 border-green-500">
                    <div class="flex items-center gap-4">
                        <div class="bg-green-100 p-3 rounded-full">
                            <i class="fas fa-check-circle text-green-500 text-xl"></i>
                        </div>
                        <div>
                            <span class="text-gray-500 text-sm">المهندسون النشطون</span>
                            <span class="text-gray-900 text-lg font-bold block">
                                <?= count(array_filter($engineers, fn($e) => $e['status'] == 1)) ?>
                            </span>
                        </div>
                    </div>
                </div>

                <?php if ($admin['is_superAdmin'] == 1): ?>
                <div class="bg-white p-4 rounded-lg shadow-md border-l-2 border-blue-500">
                    <a href="add_engineer.php" class="flex items-center gap-4 text-blue-500">
                        <div class="bg-blue-100 p-3 rounded-full">
                            <i class="fas fa-plus text-blue-500 text-xl"></i>
                        </div>
                        <div>
                            <span class="text-gray-700 text-sm font-semibold">إضافة مهندس جديد</span>
                        </div>
                    </a>
                </div>
                <?php endif; ?>
            </div>

            <!-- Engineers Table -->
            <div class="bg-white shadow rounded-lg overflow-hidden">
                <div class="flex flex-col md:flex-row justify-between items-center p-4 border-b">
                    <h2 class="text-xl font-bold text-gray-800 mb-4 md:mb-0">قائمة المهندسين</h2>
                    
                    <!-- Search and Filter Section -->
                    <div class="flex flex-col md:flex-row gap-4 w-full md:w-auto">
                        <!-- Search Bar -->
                        <div class="relative w-full md:w-64">
                            <input
                                type="search"
                                name="search"
                                id="search"
                                class="w-full p-2 pl-10 bg-gray-100 border border-gray-200 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                                placeholder="البحث عن مهندس"
                            >
                            <i class="fas fa-search absolute right-3 top-3 text-gray-500"></i>
                        </div>
                        
                        <!-- Sort Dropdown -->
                        <div class="relative w-full md:w-64">
                            <select 
                                name="filter" 
                                id="filter" 
                                class="w-full p-2 pl-10 bg-gray-100 border border-gray-200 rounded-lg shadow-sm appearance-none focus:outline-none focus:ring-2 focus:ring-blue-500"
                            >
                                <option value="name-asc">الاسم (أ-ي)</option>
                                <option value="name-desc">الاسم (ي-أ)</option>
                                <option value="id-asc">رقم المهندس تصاعدي</option>
                                <option value="id-desc">رقم المهندس تنازلي</option>
                                <option value="reports-asc">التقارير (أقل أولاً)</option>
                                <option value="reports-desc">التقارير (أكثر أولاً)</option>
                                <option value="status-active">النشطون أولاً</option>
                                <option value="status-inactive">غير النشطين أولاً</option>
                            </select>
                            <i class="fas fa-sort absolute right-3 top-3 text-gray-500"></i>
                        </div>
                    </div>
                </div>
                
                <div class="overflow-x-auto">
                    <table class="min-w-full" id="engineersTable">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">رقم المهندس</th>
                                <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">اسم المهندس</th>
                                <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">هاتف المهندس</th>
                                <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">عدد التقارير</th>
                                <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">الحالة</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <?php foreach ($engineers as $engineer): ?>
                            <tr class="hover:bg-gray-50">
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><?= htmlspecialchars($engineer['id']) ?></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><?= htmlspecialchars($engineer['name']) ?></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><?= htmlspecialchars($engineer['phone']) ?></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><?= htmlspecialchars($engineer['report_count']) ?></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                    <label class="toggle-switch">
                                        <input type="checkbox" <?= $engineer['status'] ? 'checked' : '' ?> 
                                            onchange="updateEngineerStatus(this, <?= $engineer['id'] ?>)">
                                        <span class="slider"></span>
                                    </label>
                                </td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Toggle sidebar
        const sidebar = document.getElementById("sidebar");
        const toggleButton = document.getElementById("toggleButton");

        toggleButton.addEventListener("click", () => {
            sidebar.classList.toggle("w-64");
            sidebar.classList.toggle("w-16");
            sidebar.classList.toggle("sidebar-mini");
        });

        // Update engineer status
        async function updateEngineerStatus(checkbox, engineerId) {
            const status = checkbox.checked ? 1 : 0;
            
            try {
                const response = await fetch('update_engineer_status.php', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        engineer_id: engineerId,
                        status: status
                    })
                });
                
                const data = await response.json();
                
                if (!data.success) {
                    throw new Error(data.message || 'Update failed');
                }
                
                // Visual feedback
                const slider = checkbox.nextElementSibling;
                if (status) {
                    slider.style.backgroundColor = '#4CAF50';
                } else {
                    slider.style.backgroundColor = '#f44336';
                }
                
            } catch (error) {
                console.error('Error:', error);
                checkbox.checked = !checkbox.checked;
                alert('فشل تحديث الحالة. الرجاء المحاولة مرة أخرى.');
            }
        }

        // Search and Filter functionality
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('search');
            const filterSelect = document.getElementById('filter');
            const tableBody = document.querySelector('#engineersTable tbody');
            const rows = Array.from(tableBody.querySelectorAll('tr'));
            
            // Search function
            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                
                rows.forEach(row => {
                    const cells = row.querySelectorAll('td');
                    const matches = Array.from(cells).some(cell => 
                        cell.textContent.toLowerCase().includes(searchTerm)
                    );
                    row.style.display = matches ? '' : 'none';
                });
            });
            
            // Sort function
            filterSelect.addEventListener('change', function() {
                const value = this.value;
                const [sortKey, sortDirection] = value.split('-');
                
                const sortedRows = rows.sort((a, b) => {
                    let aValue, bValue;
                    
                    switch(sortKey) {
                        case 'name':
                            aValue = a.querySelector('td:nth-child(2)').textContent;
                            bValue = b.querySelector('td:nth-child(2)').textContent;
                            return sortDirection === 'asc' 
                                ? aValue.localeCompare(bValue, 'ar')
                                : bValue.localeCompare(aValue, 'ar');
                            
                        case 'id':
                            aValue = parseInt(a.querySelector('td:first-child').textContent);
                            bValue = parseInt(b.querySelector('td:first-child').textContent);
                            return sortDirection === 'asc' ? aValue - bValue : bValue - aValue;
                            
                        case 'reports':
                            aValue = parseInt(a.querySelector('td:nth-child(4)').textContent);
                            bValue = parseInt(b.querySelector('td:nth-child(4)').textContent);
                            return sortDirection === 'asc' ? aValue - bValue : bValue - aValue;
                            
                        case 'status':
                            aValue = a.querySelector('.toggle-switch input').checked ? 1 : 0;
                            bValue = b.querySelector('.toggle-switch input').checked ? 1 : 0;
                            return sortDirection === 'active' ? bValue - aValue : aValue - bValue;
                    }
                });
                
                // Rebuild table
                tableBody.innerHTML = '';
                sortedRows.forEach(row => tableBody.appendChild(row));
            });
        });
    </script>
</body>
</html>