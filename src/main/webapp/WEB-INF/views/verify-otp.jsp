<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Verify OTP</title>
<style>
	    body {
	        font-family: 'Segoe UI', sans-serif;
	        background: #eef2f7;
	        display: flex;
	        justify-content: center;
	        align-items: center;
	        height: 100vh;
	        margin: 0;
	    }
	    .otp-container {
	        background: #fff;
	        padding: 40px;
	        border-radius: 15px;
	        text-align: center;
	        box-shadow: 0 6px 20px rgba(0,0,0,0.15);
	        width: 360px;
	    }

	    /* Header */
	    .otp-container h2 {
	        color: #1E3A8A; /* Deep blue header */
	        margin-bottom: 20px;
	    }

	    input {
	        width: 100%;
	        padding: 12px;
	        margin: 10px 0;
	        border-radius: 8px;
	        border: 1px solid #ccc;
	        font-size: 14px;
	        transition: all 0.2s ease-in-out;
	    }

	    input:focus {
	        border-color: #007bff;
	        box-shadow: 0 0 5px rgba(0,123,255,0.5);
	    }

	    button {
	        width: 100%;
	        padding: 12px;
	        margin-top: 10px;
	        border-radius: 8px;
	        border: none;
	        font-size: 16px;
	        color: #fff;
	        cursor: pointer;
	        transition: all 0.2s ease-in-out;
	    }

	    /* Button Colors */
	    .send-btn { background: #007bff; }
	    .verify-btn { background: gray; }
	    .resend-btn { background: gray; }

	    /* Enabled state */
	    .enabled {
	        background: #007bff !important;
	        cursor: pointer !important;
	    }

	    /* Hover scaling effect */
	    .enabled:hover {
	        transform: scale(1.05);
	    }

	    /* Disabled verify button */
	    .verify-btn:disabled {
	        background: gray;
	        cursor: not-allowed;
	    }

	    /* Timer */
	    #timer {
	        font-weight: bold;
	        margin-top: 10px;
	        color: #333;
	    }

	    /* Messages */
	    .alert {
	        padding: 10px;
	        border-radius: 5px;
	        margin-bottom: 10px;
	        font-size: 14px;
	    }
	    .alert-success { background: #d4edda; color: #155724; }
	    .alert-error { background: #f8d7da; color: #721c24; }
	</style>

</head>
<body>
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

	    .otp-container {
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

	    .otp-container h2 {
	        font-size: 26px;
	        margin-bottom: 25px;
	        color: #1E3A8A; /* deep blue header */
	    }

	    input[type=number] {
	        width: 100%;
	        padding: 14px;
	        margin: 10px 0;
	        border-radius: 10px;
	        border: 1px solid #dcdcdc;
	        font-size: 14px;
	        transition: 0.25s;
	    }

	    input[type=number]:focus {
	        border-color: #0d6efd;
	        box-shadow: 0 0 0 3px rgba(13,110,253,0.15);
	        outline: none;
	    }

	    /* Buttons */
	    .send-btn, .verify-btn, .resend-btn {
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
	        transition: transform 0.2s, box-shadow 0.2s, background 0.2s;
	    }

	    .send-btn:hover, .verify-btn:hover, .resend-btn.enabled:hover {
	        transform: translateY(-2px) scale(1.03);
	        box-shadow: 0 10px 20px rgba(13,110,253,0.35);
	    }

	    /* Disabled Verify button */
	    .verify-btn:disabled, .resend-btn:disabled {
	        background: gray !important;
	        cursor: not-allowed;
	        box-shadow: none;
	        transform: none;
	    }

	    /* Timer */
	    #timer {
	        font-weight: bold;
	        margin-top: 10px;
	        color: #333;
	        font-size: 14px;
	    }

	    /* Alerts */
	    .alert {
	        padding: 10px;
	        border-radius: 5px;
	        margin-bottom: 10px;
	        font-size: 14px;
	        text-align: center;
	    }

	    .alert-success { background: #d4edda; color: #155724; }
	    .alert-error { background: #f8d7da; color: #721c24; }

	    @media (max-width: 480px) {
	        .otp-container {
	            width: 90%;
	            padding: 30px;
	        }
	    }
	</style>

	<div class="otp-container">

	    <h2>OTP Verification</h2>

	    <!-- Messages -->
	    <c:if test="${not empty success}">
	        <div class="alert alert-success" id="successMsg">${success}</div>
	    </c:if>
	    <c:if test="${not empty error}">
	        <div class="alert alert-error" id="errorMsg">${error}</div>
	    </c:if>

	    <!-- Step 1: Send OTP -->
	    <form id="sendForm" action="${pageContext.request.contextPath}/send-otp" method="post" 
	        style="display: <c:out value='${otpRemainingSeconds == null ? "block" : "none"}'/>;">
	        <input type="hidden" name="email" value="${email}">
	        <button type="submit" class="send-btn" id="sendBtn">Send OTP</button>
	    </form>

	    <!-- Step 2: Verify OTP -->
	    <div id="otpSection" style="display: <c:out value='${otpRemainingSeconds != null ? "block" : "none"}'/>;">
	        <p id="timer">OTP expires in 02:00</p>
	        <form id="verifyForm" action="${pageContext.request.contextPath}/verify-otp" method="post">
	            <input type="hidden" name="email" value="${email}">
	            <input type="number" name="otp" placeholder="Enter OTP" required>
	            <button type="submit" class="verify-btn" id="verifyBtn">Verify OTP</button>
	        </form>
	        <form id="resendForm" action="${pageContext.request.contextPath}/send-otp" method="post" style="display: none;">
	            <input type="hidden" name="email" value="${email}">
	            <button type="submit" class="resend-btn" id="resendBtn" disabled>Resend OTP</button>
	        </form>
	    </div>
	</div>

	<script>
	    // Timer in seconds from server-side, or default 120s
	    let timeLeft = parseInt('<c:out value="${otpRemainingSeconds != null ? otpRemainingSeconds : 120}"/>', 10);

	    const timerEl = document.getElementById('timer');
	    const verifyBtn = document.getElementById('verifyBtn');
	    const resendForm = document.getElementById('resendForm');
	    const resendBtn = document.getElementById('resendBtn');

	    function updateTimer() {
	        if(timeLeft <= 0){
	            timerEl.innerText = "OTP expired!";
	            timerEl.style.color = "red";
	            verifyBtn.disabled = true;

	            // Show and enable the resend button
	            resendForm.style.display = "block";
	            resendBtn.disabled = false;
	            resendBtn.classList.add('enabled'); // apply hover/scale effect
	            clearInterval(intervalId);
	            return;
	        }

	        const minutes = Math.floor(timeLeft / 60);
	        const seconds = timeLeft % 60;
			timerEl.innerHTML = "<strong>OTP expires in</strong> " + minutes.toString().padStart(2, '0') + ":" + seconds.toString().padStart(2, '0');
	        timeLeft--;
	    }

	    // Update every 1 second
	    let intervalId = setInterval(updateTimer, 1000);
	</script>

</body>
</html>
