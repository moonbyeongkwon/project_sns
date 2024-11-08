<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/light/theme.jsp"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SNS 페이지</title>
<style>
body {
	margin: 0;
	padding: 0;
	background-color: var(- -background-color);
	font-family: Arial, sans-serif;
	color: var(- -text-color);
	overflow: hidden;
	user-select: none;
}

/* 스크롤바 완전히 숨기기 */
.content-wrapper::-webkit-scrollbar {
	display: none;
}

.content-wrapper {
	-ms-overflow-style: none;
	scrollbar-width: none;
}

.top-bar {
	background-color: #FFBC42;
	padding: 8px;
	display: flex;
	justify-content: flex-end;
	align-items: center;
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 10;
	height: 70px;
	gap: 15px;
}

.user-info-container {
	display: flex;
	align-items: center;
	gap: 15px;
	margin-right: 50px;
	position: relative;
	cursor: pointer;
}

.user-info img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
}

.username {
	font-size: 18px;
	color: white;
}

.notification-icon {
	font-size: 24px;
	color: white;
	cursor: pointer;
}

.dropdown-menu {
	display: none;
	position: absolute;
	top: 60px;
	right: 0;
	background-color: #383A3F;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	border-radius: 5px;
	overflow: hidden;
	z-index: 10;
}

.dropdown-menu a {
	display: block;
	padding: 10px 20px;
	color: #FFFFFF;
	text-decoration: none;
	font-size: 16px;
}

.dropdown-menu a:hover {
	background-color: #2A2C30;
}

.search-bar {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
}

.search-bar input[type="text"] {
	width: 500px;
	padding: 10px;
	border: none;
	border-radius: 5px;
	background-color: #2A2C30;
	color: white;
	font-size: 16px; 
}

.search-bar input[type="text"]::placeholder {
	color: #F6B352;
}

.content-wrapper {
	display: flex;
	flex-direction: row;
	overflow-x: auto;
	overflow-y: hidden;
	scroll-snap-type: x mandatory;
	gap: 60px;
	padding: 0px 40px 100px calc(50vw - 300px);
	height: 100vh;
	align-items: center;
	scroll-behavior: smooth;
	cursor: grab;
}

.post {
	flex: 0 0 65vw;
	height: 80vh;
	background-color: #383A3F;
	border-radius: 10px;
	padding: 20px;
	box-sizing: border-box;
	display: flex;
	scroll-snap-align: center;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
	margin-top: 50px;
	transition: opacity 0.3s;
}

.left-section, .right-section {
	flex: 1;
	padding: 20px;
}

.left-section {
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 15px;
    border-right: 1px solid #2A2C30;
    padding-top: 50px; /* 프로필 오버레이와 이미지를 분리할 수 있도록 여백 추가 */
}

.profile-overlay {
    position: absolute;
    top: 0px; /* 프로필 오버레이 위치를 상단에 고정 */
    left: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
    background-color: rgba(0, 0, 0, 0.6);
    padding: 5px 10px;
    border-radius: 10px;
}

.profile-overlay img {
	width: 30px;
	height: 30px;
	border-radius: 50%;
}

.profile-overlay .username {
	font-size: 14px;
	color: white;
}

.left-section img {
    width: 100%;
    height: auto;
    border-radius: 5px;
    margin-top: 10px; /* 이미지와 오버레이 간 간격을 추가 */
}
.post-actions {
	display: flex;
	justify-content: center;
	gap: 10px;
	width: 100%;
	margin-top: 10px;
}

.post-actions span {
	color: #F6B352;
	cursor: pointer;
}

.right-section {
	overflow-y: auto;
	height: 100%;
}

.comment {
	background-color: #2A2C30;
	padding: 10px;
	margin-bottom: 10px;
	border-radius: 5px;
	color: white;
}

.bottom-menu {
	position: fixed;
	bottom: 0;
	width: 100%;
	background-color: #E0E3DA;
	padding: 10px;
	display: flex;
	justify-content: center;
	gap: 30px;
	box-shadow: 0 -4px 8px rgba(0, 0, 0, 0.2);
	z-index: 5;
}

.bottom-menu a {
	color: #1F2124;
	text-decoration: none;
	font-size: 18px;
}

.bottom-menu a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<div class="top-bar">
		<div class="user-info-container" onclick="toggleDropdown()">
			<span class="notification-icon">&#x1F514;</span> <img
				src="profile.jpg" alt="프로필">
			<div class="username">사용자 이름</div>

			<!-- 드롭다운 메뉴 -->
			<div class="dropdown-menu" id="dropdownMenu">
				<a href="#" onclick="logout()">로그아웃</a>
			</div>
		</div>
		<div class="search-bar">
			<input type="text" placeholder="검색...">
		</div>
	</div>

	<div class="content-wrapper" id="contentWrapper">
		<% for (int i = 1; i <= 20; i++) { %>
		<div class="post">
			<div class="left-section">
				<div class="profile-overlay">
					<img src="profile.jpg" alt="프로필"> <span class="username">사용자
						<%= i %></span>
				</div>
				<img src="image_placeholder.jpg" alt="사진">
				<div class="post-actions">
					<span>❤️ 좋아요</span> <span>💬 댓글</span>
				</div>
			</div>
			<div class="right-section">
				<div class="comment">댓글 1</div>
				<div class="comment">댓글 2</div>
				<div class="comment">댓글 3</div>
			</div>
		</div>
		<% } %>
	</div>

	<div class="bottom-menu">
	<i class="bi bi-house">홈</i>
		<a href="#">홈</a> 
		<i class="bi bi-chat-left-text"><a href="#">메세지</a> </i>
		<a href="upload">게시물 작성</a> 
		<a href="#">설정</a>
	</div>

	<script>
        function toggleDropdown() {
            const dropdownMenu = document.getElementById('dropdownMenu');
            dropdownMenu.style.display = dropdownMenu.style.display === 'block' ? 'none' : 'block';
        }

        function logout() {
            window.location.href = '/sns/main';
        }

        document.addEventListener('click', function(event) {
            const dropdownMenu = document.getElementById('dropdownMenu');
            const userInfoContainer = document.querySelector('.user-info-container');
            
            if (!userInfoContainer.contains(event.target)) {
                dropdownMenu.style.display = 'none';
            }
        });

        const contentWrapper = document.getElementById('contentWrapper');
        const posts = document.querySelectorAll('.post');
        const postWidth = posts[0].offsetWidth + 60;
        
        // 현재 보여지는 게시물의 투명도를 업데이트하는 함수
        function updatePostOpacity() {
            posts.forEach(post => post.style.opacity = '0.3'); // 모든 게시물 투명도 낮춤
            const middlePostIndex = Math.round(contentWrapper.scrollLeft / postWidth); // 중간 게시물 찾기
            if (posts[middlePostIndex]) {
                posts[middlePostIndex].style.opacity = '1'; // 중간 게시물 불투명
            }
        }

        // 스크롤 및 드래그를 통해 투명도 업데이트
        contentWrapper.addEventListener('scroll', updatePostOpacity);
        updatePostOpacity();

        contentWrapper.addEventListener('wheel', (event) => {
            event.preventDefault();
            const direction = event.deltaY > 0 ? 1 : -1;
            contentWrapper.scrollBy({
                left: direction * postWidth,
                behavior: 'smooth'
            });
        });

        let isDragging = false;
        let startX;
        let scrollLeft;

        contentWrapper.addEventListener('mousedown', (e) => {
            isDragging = true;
            startX = e.pageX;
            scrollLeft = contentWrapper.scrollLeft;
            contentWrapper.style.cursor = 'grabbing';
        });

        contentWrapper.addEventListener('mouseup', () => {
            isDragging = false;
            contentWrapper.style.cursor = 'grab';
        });

        contentWrapper.addEventListener('mousemove', (e) => {
            if (!isDragging) return;
            e.preventDefault();
            const x = e.pageX;
            const walk = (x - startX) * 1.5; 
            contentWrapper.scrollLeft = scrollLeft - walk;
            updatePostOpacity(); // 드래그 중 투명도 업데이트
        });

        contentWrapper.addEventListener('mouseleave', () => {
            isDragging = false;
            contentWrapper.style.cursor = 'grab';
        });
    </script>
</body>
</html>
