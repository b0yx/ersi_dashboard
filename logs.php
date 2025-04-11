
<?php
require_once 'connection.php';

try {
    $stmt = $pdo->query("SELECT log.id, log.date, log.action, user.name AS user_name,
                         CASE 
                            WHEN administrator.is_superAdmin = 1 THEN 'superadmin'
                            WHEN administrator.user_id IS NOT NULL THEN 'admin'
                            ELSE 'engineer'
                         END AS role
                         FROM log 
                         JOIN user ON log.user_id = user.id 
                         LEFT JOIN administrator ON user.id = administrator.user_id
                         ORDER BY log.date DESC");
    $logs = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("خطأ أثناء جلب السجلات: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>سجل الأنشطة</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <style>
        table.dataTable thead th, table.dataTable tbody td {
            text-align: right;
        }
    </style>
</head>
<body class="bg-gray-100 font-sans">
<div class="flex min-h-screen">
    <aside >
        <?php include 'sidebar.php'; ?>
    </aside>
    <main class="flex-1 bg-gray-100 p-8 space-y-8 transition-all duration-300 ease-in-out">

    <div class="max-w-7xl mx-auto bg-white rounded-2xl shadow-xl p-8 ring-1 ring-gray-100">
        <h1 class="text-4xl font-extrabold mb-8 text-center text-blue-900 tracking-wide">سجل الأنشطة</h1>
        <div class="bg-white p-6 md:p-8 rounded-xl shadow-lg overflow-x-auto ring-1 ring-gray-200">
            <table id="logTable" class="rounded-lg overflow-hidden shadow border border-gray-300 w-full text-right bg-white hover:shadow-xl transition-all duration-300" class="rounded-lg overflow-hidden shadow border border-gray-300 text-sm w-full text-right" class="display min-w-full text-sm border border-gray-300 rounded-lg shadow">
                <thead class="bg-gradient-to-r from-blue-200 to-blue-100 text-blue-900 font-bold text-sm rounded-t-md">
                    <tr class="text-sm leading-6 text-gray-700">
                        <th>#</th>
                        <th>التاريخ</th>
                        <th>النشاط</th>
                        <th>اسم المستخدم</th>
                        <th>الدور</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-200">
                    <?php foreach ($logs as $log): ?>
                        <?php
                            $bg = '';
                            if ($log['role'] === 'superadmin') $bg = 'style="background-color: #fef2f2;"'; // أحمر فاتح
                            elseif ($log['role'] === 'admin') $bg = 'style="background-color: #f0fdf4;"'; // أخضر فاتح
                            elseif ($log['role'] === 'engineer') $bg = 'style="background-color: #eff6ff;"'; // أزرق فاتح
                        ?>
                        <tr <?= $bg ?>>
                            <td><?= htmlspecialchars($log['id']) ?></td>
                            <td><?= htmlspecialchars($log['date']) ?></td>
                            <td><?= htmlspecialchars($log['action']) ?></td>
                            <td><?= htmlspecialchars($log['user_name']) ?></td>
                            <td>
                                <?php
                                    echo $log['role'] === 'superadmin' ? 'مشرف عام' :
                                         ($log['role'] === 'admin' ? 'مشرف' : 'مهندس');
                                ?>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>

    <!-- jQuery and DataTables -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#logTable').DataTable({
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/ar.json'
                }
            });
        });

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
            
    </script>

    </main>
</div>
</body>
</html>
