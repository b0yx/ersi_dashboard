
<?php

if (isset($_POST['logout'])) {
    session_destroy();
    header("Location: login.php");
    exit();
}

?>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>لوحة التحكم</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --sidebar-width: 18rem;
            --sidebar-mini-width: 5rem;
            --primary-color: #0d9488;
            --primary-hover: #0f766e;
            --secondary-color: #3b82f6;
        }
        
        body {
            font-family: 'Tajawal', sans-serif;
            background-color: #f8fafc;
        }
        
        #sidebar {
            width: var(--sidebar-width);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .sidebar-mini {
            width: var(--sidebar-mini-width) !important;
        }
        
        .sidebar-mini .sidebar-content {
            opacity: 0;
            width: 0;
            height: 0;
            overflow: hidden;
            transition: opacity 0.2s ease;
        }
        
        .sidebar-mini .nav-item {
            justify-content: center;
        }
        
        .sidebar-mini .nav-link {
            padding: 0.75rem;
            justify-content: center;
        }
        
        .sidebar-mini .nav-icon {
            margin-left: 0;
            margin-right: 0;
        }
        
        .sidebar-mini .logo-icon {
            display: flex !important;
        }
        
        .sidebar-mini .logo-text {
            display: none;
        }
        
        .sidebar-mini .profile-info {
            display: none;
        }
        
        .sidebar-mini .profile-avatar {
            margin-right: 0;
        }
        
        .nav-item {
            transition: all 0.2s ease;
        }
        
        .nav-item:hover {
            transform: translateX(-5px);
        }
        
        .nav-link {
            position: relative;
            overflow: hidden;
        }
        
        .nav-link::after {
            content: '';
            position: absolute;
            right: 0;
            top: 0;
            height: 100%;
            width: 3px;
            background-color: var(--primary-color);
            transform: scaleY(0);
            transition: transform 0.2s ease;
        }
        
        .nav-link:hover::after,
        .nav-link.active::after {
            transform: scaleY(1);
        }
        
        .nav-link.active {
            background-color: rgba(13, 148, 136, 0.1);
            color: var(--primary-color);
        }
        
        .nav-link.active .nav-icon {
            color: var(--primary-color);
        }
        
        .sidebar-toggle {
            transition: all 0.3s ease;
        }
        
        .sidebar-mini .nav-item:hover {
            transform: none;
        }
        
        .notification-badge {
            position: absolute;
            left: 0.5rem;
            top: 50%;
            transform: translateY(-50%);
        }
        
        .dropdown-menu {
            display: none;
            position: absolute;
            right: 100%;
            top: 0;
            width: 12rem;
            background-color: white;
            border-radius: 0.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            z-index: 50;
        }
        
        .dropdown:hover .dropdown-menu {
            display: block;
        }
        
        .theme-switcher {
            width: 2.5rem;
            height: 1.25rem;
        }
        
        .theme-switcher-toggle {
            width: 1rem;
            height: 1rem;
            transition: transform 0.3s ease;
        }
        
        .dark .theme-switcher-toggle {
            transform: translateX(1.25rem);
        }

        /* Tooltip styles */
        .tooltip {
            position: absolute;
            right: 100%;
            margin-right: 0.5rem;
            padding: 0.25rem 0.5rem;
            background-color: #1f2937;
            color: white;
            border-radius: 0.25rem;
            font-size: 0.75rem;
            white-space: nowrap;
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.2s;
            z-index: 50;
        }
        
        .nav-item:hover .tooltip {
            opacity: 1;
        }
    </style>
</head>
<body class="bg-gray-50">
    <aside id="sidebar" class="bg-gradient-to-b from-white to-gray-50 shadow-lg p-4 flex flex-col justify-between min-h-screen border-l border-gray-200 relative">
        <!-- Toggle Button -->
        <button id="sidebarToggle" class="sidebar-toggle absolute left-0 top-1/2 -translate-y-1/2 -translate-x-1/2 bg-white p-2 rounded-full shadow-md border border-gray-200 hover:bg-teal-50 hover:border-teal-200 z-10">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-500 sidebar-collapse-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
        </button>
        
        <div>
            <!-- Header with logo and title -->
            <div class="flex justify-between items-center pb-4 mb-4 border-b border-gray-200">
                <div class="flex items-center space-x-3 space-x-reverse">
                    <div class="p-2 bg-teal-100 rounded-lg logo-icon" style="display: none;">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-teal-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" />
                        </svg>
                    </div>
                    <h1 class="text-xl font-bold text-gray-800 sidebar-content logo-text">لوحة التحكم</h1>
                </div>
            </div>
            
            <!-- Navigation Menu -->
            <nav class="mt-2">
                <ul class="space-y-1">
                    <li class="nav-item">
                        <a href="dashboard.php" class="flex items-center px-3 py-2 text-gray-600 hover:text-teal-600 hover:bg-teal-50 rounded-lg transition-all group nav-link active">
                            <i class="fas fa-users nav-icon ml-3 text-gray-400 group-hover:text-teal-500"></i>
                            <span class="font-medium sidebar-content">إدارة المستخدمين</span>
                            <span class="tooltip">إدارة المستخدمين</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="ReportsDashboard.php" class="flex items-center px-3 py-2 text-gray-600 hover:text-teal-600 hover:bg-teal-50 rounded-lg transition-all group nav-link">
                            <i class="fas fa-chart-bar nav-icon ml-3 text-gray-400 group-hover:text-teal-500"></i>
                            <span class="font-medium sidebar-content">تقارير المستخدمين</span>
                            <span class="tooltip">تقارير المستخدمين</span>
                        </a>
                    </li>
                   
                    <li class="nav-item">
                        <a href="logs.php" class="flex items-center px-3 py-2 text-blue-600 bg-blue-50 rounded-lg font-medium group nav-link">
                            <i class="fas fa-clipboard-list nav-icon ml-3"></i>
                            <span class="sidebar-content">سجل الأنشطة</span>
                            <span class="tooltip">سجل الأنشطة</span>
                        </a>
                    </li>

                    <!-- <li class="nav-item">
                        <a href="logs.php" class="flex items-center px-3 py-2 text-blue-600 bg-blue-50 rounded-lg font-medium group nav-link">
                            <i class="fas fa-clipboard-list nav-icon ml-3"></i>
                            <span class="sidebar-content">إدارة المشرفين</span>
                            <span class="tooltip">سجل الأنشطة</span>
                        </a>
                    </li> -->
                </ul>
            </nav>
        </div>
        
        <!-- User Profile Section -->
        <div class="sidebar-content">
            <div class="relative dropdown">
                <div class="flex items-center justify-between p-3 bg-gray-100 rounded-lg cursor-pointer hover:bg-gray-200 transition-colors">
                    <div class="flex items-center">
                        <img src="Static/IMG/user.png" alt="صورة المستخدم" class="rounded-full border-2 border-teal-400 w-10 h-10 object-cover profile-avatar" />
                        <div class="mr-3 profile-info">
                            <p class="text-sm font-medium text-gray-800"><?php echo htmlspecialchars($admin['name'] ?? ''); ?></p>
                        </div>
                    </div>
                    <i class="fas fa-chevron-down text-gray-500 text-xs transition-transform duration-200 dropdown-arrow"></i>
                </div>
                
                <div class="dropdown-menu">
                    <a href="admin_profile.php" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 transition-colors">
                        <i class="fas fa-user mr-2"></i>
                        <span>الملف الشخصي</span>
                    </a>
                    <form method="post">
                        <button type="submit" name="logout"  class="block w-full text-right px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 transition-colors">
                            <i class="fas fa-sign-out-alt mr-2"></i>
                            <span>تسجيل الخروج</span>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </aside>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const sidebar = document.getElementById('sidebar');
            const toggleBtn = document.getElementById('sidebarToggle');
            const collapseIcon = document.querySelector('.sidebar-collapse-icon');
            
            // Initialize sidebar state from localStorage
            if (localStorage.getItem('sidebarMini') === 'true') {
                sidebar.classList.add('sidebar-mini');
                collapseIcon.style.transform = 'rotate(180deg)';
            }
            
            // Toggle sidebar function
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
            
            // Set active nav item based on current page
            function setActiveNavItem() {
                const currentPage = window.location.pathname.split('/').pop();
                const navLinks = document.querySelectorAll('.nav-link');
                
                navLinks.forEach(link => {
                    link.classList.remove('active');
                    if (link.getAttribute('href') === currentPage) {
                        link.classList.add('active');
                    }
                });
            }
            
            // Initialize active nav item
            setActiveNavItem();
            
            // Dropdown functionality
            const dropdown = document.querySelector('.dropdown');
            const dropdownMenu = document.querySelector('.dropdown-menu');
            const dropdownArrow = document.querySelector('.dropdown-arrow');
            
            if (dropdown) {
                dropdown.addEventListener('click', function(e) {
                    e.stopPropagation();
                    const isOpen = dropdownMenu.style.display === 'block';
                    dropdownMenu.style.display = isOpen ? 'none' : 'block';
                    dropdownArrow.style.transform = isOpen ? 'rotate(0deg)' : 'rotate(180deg)';
                });
            }
            
            // Close dropdown when clicking outside
            document.addEventListener('click', function() {
                if (dropdownMenu) {
                    dropdownMenu.style.display = 'none';
                    dropdownArrow.style.transform = 'rotate(0deg)';
                }
            });
            
            // Prevent dropdown from closing when clicking inside
            if (dropdownMenu) {
                dropdownMenu.addEventListener('click', function(e) {
                    e.stopPropagation();
                });
            }
        });
    </script>
</body>
</html>
