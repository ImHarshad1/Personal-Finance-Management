<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>

<style>
    * {
        box-sizing: border-box;
        font-family: 'Segoe UI', system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
    }

    body {
        margin: 0;
        height: 100vh;
        background: #eef2f7;
    }

    .container {
        display: flex;
        height: 100vh;
    }


    .left-panel {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
        background: #f9fbff;
    }

    .register-container {
        width: 380px;
        padding: 20px 40px 20px;
        border-radius: 18px;
        background: rgba(255, 255, 255, 0.88);
        backdrop-filter: blur(12px);
        box-shadow:
            0 20px 40px rgba(0, 0, 0, 0.12),
            inset 0 1px 0 rgba(255,255,255,0.5);
        animation: slideUp 0.6s ease;
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .register-container h2 {
        text-align: center;
        font-size: 26px;
        margin-top: 0;
        margin-bottom: 20px;
        color: #222;
    }

    .form-group {
        margin-bottom: 18px;
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

    .error {
        color: red;
        font-size: 13px;
        display: none;
        margin-top: 5px;
    }

    .register-btn {
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

    .register-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(13,110,253,0.35);
    }

    .login-link {
        display: block;
        text-align: center;
        margin-top: 20px;
        font-size: 14px;
        color: #0d6efd;
        text-decoration: none;
    }

    .login-link:hover {
        text-decoration: underline;
    }

  
    .right-panel {
        flex: 1;
        position: relative;
        overflow: hidden;
        background:
            radial-gradient(circle at top left, rgba(255,255,255,0.15), transparent 40%),
            linear-gradient(135deg, #0d6efd, #003d99);
        color: white;
        display: flex;
        align-items: center;
        padding: 80px;
    }

    .right-content {
        max-width: 520px;
        position: relative;
        z-index: 2;
    }

    .right-content h1 {
        font-size: 44px;
        font-weight: 700;
        margin-bottom: 20px;
        letter-spacing: -0.5px;
    }

    .right-content p {
        font-size: 18px;
        line-height: 1.8;
        opacity: 0.92;
    }

   
    .money-rain {
        position: absolute;
        inset: 0;
        pointer-events: none;
        z-index: 1;
    }

    .note {
        position: absolute;
        top: -80px;
        width: 80px;
        height: 40px;
        border-radius: 8px;
        background: linear-gradient(
            135deg,
            rgba(255,255,255,0.35),
            rgba(255,255,255,0.15)
        );
        box-shadow:
            0 10px 25px rgba(0,0,0,0.15),
            inset 0 0 0 1px rgba(255,255,255,0.3);
        opacity: 0.6;
        animation: floatNote linear infinite;
    }

	.note::before {
	    content: "$";
	    position: absolute;
	    inset: 0;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    font-size: 20px;
	    font-weight: 700;
	    color: rgba(255, 255, 255, 0.35);
	    letter-spacing: 1px;
	}



    @keyframes floatNote {
        0% {
            transform: translateY(-10%) translateX(0) rotate(0deg);
            opacity: 0;
        }
        15% {
            opacity: 0.6;
        }
        50% {
            transform: translateY(50vh) translateX(30px) rotate(180deg);
        }
        100% {
            transform: translateY(110vh) translateX(-30px) rotate(360deg);
            opacity: 0;
        }
    }

    
    .note:nth-child(1) {
        left: 10%;
        animation-duration: 14s;
        filter: blur(1px);
    }

    .note:nth-child(2) {
        left: 28%;
        animation-duration: 18s;
        width: 70px;
        height: 35px;
        filter: blur(2px);
    }

    .note:nth-child(3) {
        left: 50%;
        animation-duration: 12s;
    }

    .note:nth-child(4) {
        left: 70%;
        animation-duration: 16s;
        filter: blur(1.2px);
    }

    .note:nth-child(5) {
        left: 85%;
        animation-duration: 20s;
        width: 65px;
        height: 32px;
        filter: blur(2.5px);
    }

    @media (max-width: 768px) {
        .container {
            flex-direction: column;
        }

        .right-panel {
            height: 40%;
            padding: 40px;
            text-align: center;
        }

        .money-rain {
            display: none;
        }
    }
    
/* 	OAuth */
	.oauth-divider {
    	display: flex;
    	align-items: center;
    	margin: 22px 0;
    	color: #9ca3af;
    	font-size: 13px;
	}

	.oauth-divider::before,
	.oauth-divider::after {
	    content: "";
	    flex: 1;
	    height: 1px;
	    background: #e5e7eb;
	}
	
	.oauth-divider span {
	    padding: 0 10px;
	}

	.oauth-btn {
	    width: 100%;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    gap: 10px;
	    padding: 12px;
	    border-radius: 12px;
	    border: 1px solid #e5e7eb;
	    background: #ffffff;
	    font-size: 14px;
	    font-weight: 600;
    	color: #1e293b;
	    cursor: pointer;
	    text-decoration: none;
	    transition: all 0.2s ease;
	}
	
	.oauth-btn:hover {
	    background: #f8fafc;
	    box-shadow: 0 8px 18px rgba(0,0,0,0.08);
	}
	
	.oauth-btn img {
	    width: 18px;
	    height: 18px;
	}
</style>

<script>
    function validatePasswords() {
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var errorMsg = document.getElementById("errorMsg");

        if (password !== confirmPassword) {
            errorMsg.style.display = "block";
            errorMsg.innerText = "Passwords do not match!";
            return false;
        }

        errorMsg.style.display = "none";
        return true;
    }
</script>

</head>
<body>

<div class="container">

    
    <div class="left-panel">
        <div class="register-container">
            <h2>Create Account</h2>

            <form action="register" method="post" onsubmit="return validatePasswords()">

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" placeholder="Enter full name" required>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" placeholder="Enter email" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter password" required>
                </div>

                <div class="form-group">
                    <label>Confirm Password</label>
                    <input type="password" id="confirmPassword" placeholder="Confirm password" required>
                    <span id="errorMsg" class="error"></span>
                </div>

                <button type="submit" class="register-btn">Register</button>
                
                <div class="oauth-divider">
				    <span>OR</span>
				</div>

				<a href="/oauth2/authorization/google" class="oauth-btn">
				    <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google">
				    Sign up with Google
				</a>
                
                <a href="login" class="login-link">
                    Already registered? Login here
                </a>
            </form>
        </div>
    </div>


    <div class="right-panel">

        <div class="money-rain">
            <div class="note"></div>
            <div class="note"></div>
            <div class="note"></div>
            <div class="note"></div>
            <div class="note"></div>
        </div>

        <div class="right-content">
            <h1>Take Control of Your Finances</h1>
            <p>
                Create your account to track income and expenses,
                manage budgets, and build smarter financial habits.
            </p>
        </div>
    </div>

</div>

</body>
</html>
