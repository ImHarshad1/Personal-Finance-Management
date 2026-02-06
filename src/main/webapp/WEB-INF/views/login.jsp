<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

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

    .left-content {
        max-width: 520px;
        position: relative;
        z-index: 2;
    }

    .left-content h1 {
        font-size: 44px;
        font-weight: 700;
        letter-spacing: -0.5px;
        margin-bottom: 20px;
    }

    .left-content p {
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
        color: rgba(255,255,255,0.35);
        text-shadow: 0 0 10px rgba(255,255,255,0.25);
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

   
    .note:nth-child(1) { left: 10%; animation-duration: 14s; filter: blur(1px); }
    .note:nth-child(2) { left: 28%; animation-duration: 18s; width: 70px; height: 35px; filter: blur(2px); }
    .note:nth-child(3) { left: 50%; animation-duration: 12s; }
    .note:nth-child(4) { left: 70%; animation-duration: 16s; filter: blur(1.2px); }
    .note:nth-child(5) { left: 85%; animation-duration: 20s; width: 65px; height: 32px; filter: blur(2.5px); }


    .right-panel {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
        background: #f9fbff;
    }
    
    @media (max-width: 768px) {
    	.container {
         	flex-direction: column;
    	}

    	.left-panel {
        	height: 40%;
        	padding: 40px;
        	text-align: center;
    	}

    	.money-rain {
            display: none;
        }
    }

    .login-container {
        width: 380px;
        padding: 40px;
        border-radius: 18px;
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(12px);
        box-shadow:
            0 20px 40px rgba(0, 0, 0, 0.12),
            inset 0 1px 0 rgba(255,255,255,0.5);
        animation: slideUp 0.6s ease;
    }

    @keyframes slideUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .login-container h2 {
        text-align: center;
        font-size: 26px;
        margin-top: 0;
        margin-bottom: 25px;
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

    .login-btn {
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

    .login-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(13,110,253,0.35);
    }

	.auth-link {
	    display: block;
	    margin-top: 14px;
	    font-size: 14px;
	    color: #0d6efd;            /* Primary blue */
	    text-decoration: none;
		text-align: center;
	    font-weight: 500;
	    transition: all 0.3s ease;
	}

	.auth-link:hover {
	    text-decoration: underline;
	    color: #084298;
	}

	.auth-link.muted {
	    font-size: 13px;
		text-align: center;
	    color: #6c757d;
	}

	.auth-link.muted:hover {
	    color: #0d6efd;
	}
	
/* 	Message display */
	.message {
	    display: flex;
	    align-items: center;
	    gap: 8px;
	    padding: 10px 12px;
	    border-radius: 10px;
	    font-size: 13px;
	    font-weight: 500;
	    margin-bottom: 14px;
	}

	.message.success {
	    background: #eaf7f0;
	    color: #1e7e4f;
	    border: 1px solid #cfeedd;
	}

	.message.error {
	    background: #fdeeee;
	    color: #b02a37;
	    border: 1px solid #f5c2c7;
	}

	.message svg {
	    width: 16px;
	    height: 16px;
	    flex-shrink: 0;
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
</head>
<body>

<div class="container">

   
    <div class="left-panel">

        <div class="money-rain">
            <div class="note"></div>
            <div class="note"></div>
            <div class="note"></div>
            <div class="note"></div>
            <div class="note"></div>
        </div>

        <div class="left-content">
            <h1>Personal Finance Manager</h1>
			   <p>
			       Track spending, add budgets,  
			       and manage your money efficiently.
			   </p>
        </div>
    </div>

   
    <div class="right-panel">
        <div class="login-container">
            <h2>Login</h2>

			<c:if test="${not empty error}">
			    <div class="message error" role="alert">
			        <svg viewBox="0 0 24 24" fill="none">
			            <circle cx="12" cy="12" r="10" fill="#dc3545"/>
			            <path d="M12 7v6M12 16h.01"
			                  stroke="#fff"
			                  stroke-width="2"
			                  stroke-linecap="round"/>
			        </svg>
			        ${error}
			    </div>
			</c:if>

			<c:if test="${not empty success}">
			    <div class="message success" role="status">
			        <svg viewBox="0 0 24 24" fill="none">
			            <circle cx="12" cy="12" r="10" fill="#2fbf71"/>
			            <path d="M7 12.5l3 3 7-7"
			                  stroke="#fff"
			                  stroke-width="2"
			                  stroke-linecap="round"
			                  stroke-linejoin="round"/>
			        </svg>
			        ${success}
			    </div>
			</c:if>


            <form action="login" method="post">
                <div class="form-group">
                    <label>Email ID</label>
                    <input type="email" name="username" placeholder="Enter email" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Enter password" required>
                </div>

                <button type="submit" class="login-btn">Login</button>
                <div class="oauth-divider">
    				<span>OR</span>
				</div>

				<a href="/oauth2/authorization/google" class="oauth-btn">
				    <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google">
				    Continue with Google
				</a>

				<a href="register" class="auth-link">
				    Don't have an account? Register Now
				</a>

				<a href="forgot-password" class="auth-link muted">
				    Forgot Password?
				</a>

            </form>
        </div>
    </div>

</div>
</body>

</html>