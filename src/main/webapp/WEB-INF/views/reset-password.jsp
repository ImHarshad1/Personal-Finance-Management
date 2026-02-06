<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reset Password</title>

<style>
    * {
        box-sizing: border-box;
        font-family: 'Segoe UI', system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
    }

    body {
        margin: 0;
        height: 100vh;
        background: #eef2f7;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .reset-container {
        width: 380px;
        padding: 40px;
        border-radius: 18px;
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(12px);
        box-shadow:
            0 20px 40px rgba(0, 0, 0, 0.12),
            inset 0 1px 0 rgba(255,255,255,0.5);
        animation: slideUp 0.6s ease;
        text-align: center;
    }

    @keyframes slideUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .reset-container h2 {
        font-size: 26px;
        margin-bottom: 25px;
        color: #222;
    }

    .form-group {
        margin-bottom: 18px;
        text-align: left;
    }

    .form-group label {
        font-size: 13px;
        font-weight: 600;
        color: #555;
        margin-bottom: 6px;
        display: block;
    }

    .form-group input {
        width: 100%;
        padding: 14px;
        border-radius: 10px;
        border: 1px solid #dcdcdc;
        font-size: 14px;
        transition: 0.25s;
    }

    .form-group input:focus {
        border-color: #0d6efd;
        box-shadow: 0 0 0 3px rgba(13,110,253,0.15);
        outline: none;
    }

    .update-btn {
        width: 100%;
        padding: 14px;
        margin-top: 10px;
        background: linear-gradient(135deg, #0d6efd, #0047cc);
        color: white;
        border: none;
        border-radius: 12px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .update-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(13,110,253,0.35);
    }

    .message {
        font-size: 13px;
        margin-top: 10px;
        text-align: center;
    }

    .back-login {
        display: block;
        text-align: center;
        margin-top: 20px;
        font-size: 14px;
        color: #0d6efd;
        text-decoration: none;
    }

    .back-login:hover {
        text-decoration: underline;
    }

    @media (max-width: 480px) {
        .reset-container {
            width: 90%;
            padding: 30px;
        }
    }
</style>
</head>

<body>
    <div class="reset-container">
        <h2>Reset Password</h2>

        <form action="reset-password" method="post">
            <!-- Pass email from previous step -->
            <input type="hidden" name="email" value="${email}">

            <div class="form-group">
                <label>New Password</label>
                <input type="password" name="newPassword" placeholder="Enter new password" required>
            </div>

            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirmPassword" placeholder="Confirm new password" required>
            </div>

            <button type="submit" class="update-btn">Update Password</button>

            <div class="message" style="color:red">${error}</div>
            <div class="message" style="color:green">${success}</div>
        </form>

    </div>
</body>
</html>
