<?php
session_start();
require 'connection.php';

$login_error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? '');
    $password = md5($_POST['Password']) ?? '';

    try {
        // 1. Find user
        $stmt = $pdo->prepare("SELECT id, email, password FROM user WHERE email = ?");
        $stmt->execute([$email]);
        $user = $stmt->fetch();


            
    
        // 2. Verify password with MD5 (not recommended but preserved as requested)
        if ($user && $user['email'] == $email && $password == $user['password']) {            // 3. Start secure session
            session_regenerate_id(true);
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['email'] = $user['email'];
            $_SESSION['last_login'] = time();
            
            // 4. Redirect to protected area
            header("Location: dashboard.php");
            exit();
        } else {
            $login_error = "Invalid email or password";
        }
    } catch (PDOException $e) {
        error_log("Login error: " . $e->getMessage());
        $login_error = "Login failed. Please try again.";
    }
}
?>


<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>تسجيل الدخول</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Tajawal:wght@400;500;700&display=swap');
        
        body {
            font-family: 'Tajawal', sans-serif;
            background: linear-gradient(135deg, #27cba7 0%, #44ecb1 100%);
        }
        
        .login-container {
            background: linear-gradient(135deg, rgba(39, 203, 167, 0.9) 0%, rgba(68, 236, 177, 0.9) 100%);
        }
        
        .login-box {
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            border-radius: 16px;
            overflow: hidden;
        }
        
        .input-field {
            transition: all 0.3s ease;
            border: 1px solid #e5e7eb;
        }
        
        .input-field:focus {
            border-color: #27cba7;
            box-shadow: 0 0 0 3px rgba(39, 203, 167, 0.2);
        }
        
        .submit-btn {
            background: linear-gradient(to right, #27cba7, #44ecb1);
            transition: all 0.3s ease;
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(39, 203, 167, 0.4);
        }
        
        .error-notification {
            animation: fadeIn 0.4s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-15px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .error-highlight {
            animation: pulse 0.6s 2;
        }
        
        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(198, 40, 40, 0.4); }
            70% { box-shadow: 0 0 0 12px rgba(198, 40, 40, 0); }
            100% { box-shadow: 0 0 0 0 rgba(198, 40, 40, 0); }
        }
        
        .image-section {
            background: linear-gradient(135deg, #27cba7 0%, #44ecb1 100%);
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4">
    <div class="login-box bg-white w-full max-w-4xl flex flex-col md:flex-row z-10">
        <!-- Left Section - Form -->
        <div class="w-full md:w-1/2 p-8 md:p-12 flex flex-col justify-center">
            <div class="text-center mb-8">
                <h1 class="text-3xl font-bold text-gray-800 mb-2">مرحباً بعودتك</h1>
                <p class="text-gray-600">الرجاء إدخال بياناتك للدخول إلى لوحة التحكم</p>
            </div>
            
            <?php if (!empty($login_error)): ?>
                <div class="error-notification bg-red-50 text-red-700 p-4 rounded-lg mb-6 border border-red-200 flex items-start <?php echo $error_class; ?>">
                    <i class="fas fa-exclamation-circle mt-1 ml-2"></i>
                    <div><?php echo htmlspecialchars($login_error); ?></div>
                </div>
            <?php endif; ?>
            
            <form method="POST" action="" class="space-y-6">
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700 mb-1">البريد الإلكتروني</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                            <i class="fas fa-envelope text-gray-400"></i>
                        </div>
                        <input type="email" name="email" id="email" required 
                               value="<?php echo htmlspecialchars($email ?? ''); ?>" 
                               class="input-field w-full pr-10 pl-4 py-3 rounded-lg border focus:outline-none"
                               placeholder="example@domain.com">
                    </div>
                </div>
                
                <div>
                    <div class="flex justify-between items-center mb-1">
                        <label for="Password" class="block text-sm font-medium text-gray-700">كلمة المرور</label>
                        <a href="forgot_Password.php" class="text-sm text-blue-500 hover:text-blue-700">هل نسيت كلمة المرور؟</a>
                    </div>
                    <div class="relative">
                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                            <i class="fas fa-lock text-gray-400"></i>
                        </div>
                        <input type="password" name="Password" id="Password" required 
                               class="input-field w-full pr-10 pl-4 py-3 rounded-lg border focus:outline-none <?php echo ($error_class === 'error-highlight') ? 'border-red-300 bg-red-50' : ''; ?>"
                               placeholder="••••••••">
                    </div>
                </div>
                
                <div>
                    <button type="submit" class="submit-btn w-full py-3 px-4 rounded-lg text-white font-semibold shadow-md">
                        تسجيل الدخول
                        <i class="fas fa-sign-in-alt mr-2"></i>
                    </button>
                </div>
            </form>
            
            
        </div>
        
        <!-- Right Section - Image -->
        <div class="hidden md:block md:w-1/2 bg-gradient-to-br from-teal-400 to-emerald-500 p-12 flex items-center justify-center">
            <div class="text-center text-white">
                <img src="Static/IMG/caractor-working.png" alt="شخص يعمل" class="w-full max-w-xs mx-auto mb-8">
                <h2 class="text-2xl font-bold mb-4">نظام إدارة التقارير</h2>
                <p class="opacity-90">إدارة كاملة لمهندسيك وتقاريرهم في مكان واحد</p>
            </div>
        </div>
    </div>
    
    <script>
        <?php if ($error_class === 'error-highlight'): ?>
            document.addEventListener('DOMContentLoaded', function() {
                document.getElementById('Password').focus();
            });
        <?php endif; ?>
    </script>
</body>
</html>