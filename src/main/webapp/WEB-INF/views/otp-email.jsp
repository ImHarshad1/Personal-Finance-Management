<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Password Reset OTP</title>
</head>

<body style="
    margin:0;
    padding:0;
    background-color:#f1f5f9;
    font-family:'Segoe UI', Arial, sans-serif;
">

<!-- Outer Wrapper -->
<table width="100%" cellpadding="0" cellspacing="0" style="padding:30px 0;">
    <tr>
        <td align="center">

            <!-- Card -->
            <table width="520" cellpadding="0" cellspacing="0" style="
                background:#ffffff;
                border-radius:16px;
                box-shadow:0 12px 30px rgba(0,0,0,0.12);
                overflow:hidden;
            ">

                <!-- Header -->
                <tr>
                    <td style="
                        background:linear-gradient(135deg,#2563eb,#1e3a8a);
                        padding:22px;
                        text-align:center;
                        color:#ffffff;
                        font-size:20px;
                        font-weight:700;
                    ">
                        🔐 Password Reset Verification
                    </td>
                </tr>

                <!-- Content -->
                <tr>
                    <td style="padding:26px 28px; color:#334155;">

                        <p style="margin:0 0 14px; font-size:15px;">
                            Dear User,
                        </p>

                        <p style="margin:0 0 18px; font-size:15px; line-height:1.6;">
                            We received a request to reset your account password.
                            Please use the following One-Time Password (OTP) to continue:
                        </p>

                        <!-- OTP Box -->
                        <div style="
                            text-align:center;
                            background:#f8fafc;
                            border:2px dashed #2563eb;
                            border-radius:14px;
                            padding:18px;
                            margin:22px 0;
                        ">
                            <span style="
                                display:block;
                                font-size:26px;
                                font-weight:700;
                                letter-spacing:4px;
                                color:#1e3a8a;
                            ">
                                ${otp}
                            </span>
                        </div>

                        <p style="margin:0 0 14px; font-size:14.5px; line-height:1.6;">
                            This OTP is valid for a <strong>limited time</strong>.
                            Please do not share this code with anyone for security reasons.
                        </p>

                        <!-- Warning -->
                        <div style="
                            background:#fff1f2;
                            border-left:4px solid #dc2626;
                            padding:14px 16px;
                            border-radius:10px;
                            font-size:14px;
                            color:#7f1d1d;
                        ">
                            If you did not request a password reset, you can safely ignore
                            this email. Your account remains secure.
                        </div>

                        <br>

                        <p style="margin:18px 0 0; font-size:14.5px;">
                            Regards,<br>
                            <strong style="color:#1e3a8a;">Personal Finance Management Team</strong>
                        </p>

                    </td>
                </tr>

                <!-- Footer -->
                <tr>
                    <td style="
                        text-align:center;
                        padding:14px;
                        font-size:12px;
                        color:#94a3b8;
                        background:#f8fafc;
                    ">
                        © 2026 Personal Finance Management • Secure & Trusted
                    </td>
                </tr>

            </table>

        </td>
    </tr>
</table>

</body>
</html>
