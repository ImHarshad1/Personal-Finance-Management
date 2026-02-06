<%@ page contentType="text/html;charset=UTF-8" %>

<!-- Floating AI Button -->
<button id="aiBtn">🤖</button>

<!-- AI Chat Box -->
<div id="aiBox">
	<iframe src="${pageContext.request.contextPath}/ai/chat"></iframe>
</div>

<style>
#aiBtn {
    position: fixed;
    bottom: 20px;
    right: 20px;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    border: none;
    font-size: 24px;
    cursor: pointer;
    background: #2563eb;
    color: white;
    box-shadow: 0 4px 10px rgba(0,0,0,.3);
}

#aiBox {
    position: fixed;
    bottom: 90px;
    right: 20px;
    width: 380px;
    height: 520px;
    background: white;
    border-radius: 12px;
    display: none;
    box-shadow: 0 10px 25px rgba(0,0,0,.35);
}

#aiBox iframe {
    width: 100%;
    height: 100%;
    border: none;
    border-radius: 12px;
}
</style>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const btn = document.getElementById("aiBtn");
    const box = document.getElementById("aiBox");

    if (btn && box) {
        btn.onclick = function () {
            box.style.display = box.style.display === "block" ? "none" : "block";
        };
    }
});
</script>
