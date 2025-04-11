<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>نسيت كلمة المرور</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@400;500;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Tajawal', sans-serif;
      background: linear-gradient(135deg, #27cba7 0%, #44ecb1 100%);
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .login-container {
      background: linear-gradient(135deg, rgba(255, 255, 255, 0.95), rgba(255, 255, 255, 0.95));
      padding: 2.5rem;
      border-radius: 20px;
      box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
      width: 100%;
      max-width: 500px;
      transition: all 0.3s ease-in-out;
    }

    .form-label {
      font-weight: 600;
      color: #333;
    }

    .input-field {
      transition: all 0.3s ease;
      border: 1px solid #ccc;
      border-radius: 8px;
    }

    .input-field:focus {
      border-color: #27cba7;
      box-shadow: 0 0 0 4px rgba(39, 203, 167, 0.2);
    }

    .submit-btn {
      background: linear-gradient(to right, #27cba7, #44ecb1);
      border: none;
      padding: 0.75rem;
      font-size: 1rem;
      border-radius: 8px;
      transition: all 0.3s ease;
      color: white;
    }

    .submit-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 15px rgba(39, 203, 167, 0.4);
    }

    .form-title {
      font-weight: 700;
      color: #27cba7;
      margin-bottom: 1.5rem;
    }

    .alert {
      font-size: 0.95rem;
      border-radius: 10px;
    }
  </style>
</head>
<body>
  <div class="login-container">
    <h3 class="text-center form-title">نسيت كلمة المرور</h3>
    <?php
    require_once 'connection.php';
    $message = '';

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $email = trim($_POST['email']);

        $stmt = $pdo->prepare("SELECT id FROM user WHERE email = :email");
        $stmt->execute(['email' => $email]);
        $user = $stmt->fetch();

        if ($user) {
            $token = bin2hex(random_bytes(16));
            $expiry = date('Y-m-d H:i:s', strtotime('+1 hour'));

            $stmt = $pdo->prepare("INSERT INTO password_resets (user_id, token, expires_at) VALUES (?, ?, ?)");
            $stmt->execute([$user['id'], $token, $expiry]);

            $resetLink = "http://yourdomain.com/reset_password.php?token=$token";
            // mail($email, "Reset Password", "Click here to reset: $resetLink");

            $message = '<div class="alert alert-success text-center">تم إرسال رابط إعادة التعيين إلى بريدك الإلكتروني.</div>';
        } else {
            $message = '<div class="alert alert-danger text-center">البريد الإلكتروني غير موجود.</div>';
        }
    }
    ?>

    <?php echo $message; ?>

    <form method="POST" action="">
      <div class="mb-3">
        <label for="email" class="form-label">البريد الإلكتروني</label>
        <input type="email" class="form-control input-field" id="email" name="email" required>
      </div>
      <div class="d-grid">
        <button type="submit" class="btn submit-btn">إرسال رابط إعادة التعيين</button>
      </div>
    </form>
  </div>
</body>
</html>
