
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>تسجيل الدخول</title>
    <link rel="stylesheet" href="Static/CSS/login.css" />
</head>
<body>
    <div class="container">
        <div class="login-box">
            <div class="text-section">
                <div class="left-section">
                    <div class="welcome-text">
                        <p class="hello">أهلا بعودتك</p>
                        <h2>تسجيل الدخول</h2>
                    </div>
                    <?php if (!empty($login_error)): ?>
                        <div class="error-message"><?php echo htmlspecialchars($login_error); ?></div>
                    <?php endif; ?>
                    <form method="POST" action="login-checker.php" class="form-section">
                        <div class="input-group">
                            <label for="email">الحساب الإلكتروني</label>
                            <input type="email" name="email" id="email" required />
                        </div>
                        <div class="input-group">
                            <div class="Password-lables">
                                <label for="Password"> كلمة المرور</label>
                                <label for="Password">
                                    <a href="forgot_Password.php" class="plain-link"> هل نسيت كلمة المرور </a>
                                </label>
                            </div>
                            <input type="Password" name="Password" id="Password" required />
                        </div>
                        <div class="submit-button">
                            <input type="submit" value="تسجيل الدخول" />
                        </div>
                    </form>
                </div>
                <div class="image-section">
                    <img src="Static/IMG/caractor-working.png" alt="شخص يعمل" />
                </div>
            </div>
        </div>
    </div>
</body>
</html>