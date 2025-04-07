<?php
session_start();
require 'connection.php';

// Initialize error variable
$login_error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['Password'] ?? '';  // Changed to lowercase to match HTML form
    var_dump($email, $password);
    // Validate inputs
    if (empty($email) || empty($password)) {
        $login_error = "يجب إدخال اسم المستخدم وكلمة المرور";
    } else {
        try {
            $stmt = $pdo->prepare("SELECT * FROM administrator WHERE Email = ?");
            $stmt->execute([$email]);
            $user = $stmt->fetch();
            
            if ($user) {
                if (($password == $user['Password'])) {
                    $_SESSION['Email'] = $user['Email'];  

                    
                    // Regenerate session ID to prevent session fixation
                    session_regenerate_id(true);
                    
                    header("Location: dashboard.php");
                    exit();
                } else {
                    $login_error = "اسم المستخدم أو كلمة المرور غير صحيحة";
                }
            } else {
                $login_error = "اسم المستخدم أو كلمة المرور غير صحيحة";
            }
        } catch (PDOException $e) {
            // Log the error instead of showing it to users
            error_log("Login error: " . $e->getMessage());
            $login_error = "حدث خطأ أثناء محاولة تسجيل الدخول";
        }
    }
}
?>