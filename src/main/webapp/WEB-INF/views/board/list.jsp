<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" href="/resources/assets/css/main.css" />
<style>
.big-width {
	display: block
}

.small-width {
	display: none
}

select{
	display: inline;
    width: 15%;
}

#keyword{
	display: inline;
    width: 60%;
}

.search{
	width: 20%;
}

@media ( max-width : 918px) {
	select{
	    width: 100%;
	}
	#keyword{
	    width: 100%;
	}
	.search{
		width: 100%;
	}
	.writer {
		display: none
	}
	.regDate {
		display: none
	}
	.updateDate {
		display: none
	}
	.big-width {
		display: none
	}
	.small-width {
		display: block
	}
}
</style>
</head>
<body class="is-preload">
	<!-- Main -->
	<div id="main">
		<div class="wrapper">
			<div class="inner">

				<!-- Elements -->
				<header class="major">
					<h1 class="home">Board</h1>
					<p>게시판 목록</p>
				</header>
				<!-- Table -->
				<h3>
					<a href="/board/register${pageMaker.cri.getListLink()}" class="button small">글 등록</a>
				</h3>
				<div class="table-wrapper">
					<table>
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th class="writer">작성자</th>
								<th class="regDate">작성일</th>
								<th class="updateDate">수정일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="board" items="${list}">
								<tr>
									<td>${board.bno}</td>
									<td><a class="goGet" href="${board.bno}">${board.title}</a></td>
									<td class="writer">${board.writer}</td>
									<td class="regDate">${board.regDate}</td>
									<td class="updateDate">${board.updateDate}</td>
								</tr>
							</c:forEach>
						</tbody>
						<tfoot>
						</tfoot>
					</table>
				</div>
				<form method="get" action="/board/list" id="searchForm">
					<div class="fields">
						<div class="field">
							<div style="text-align:center">
								<select name="type">
									<option value="" ${pageMaker.cri.type == null ? 'selected' : ''}>검색 기준</option>
									<option value="T" ${pageMaker.cri.type == 'T' ? 'selected' : ''}>제목</option>
									<option value="C" ${pageMaker.cri.type == 'C' ? 'selected' : ''}>내용</option>
									<option value="W" ${pageMaker.cri.type == 'W' ? 'selected' : ''}>작성자</option>
									<option value="TC" ${pageMaker.cri.type == 'TC' ? 'selected' : ''}>제목 또는 내용</option>
									<option value="TW" ${pageMaker.cri.type == 'TW' ? 'selected' : ''}>제목 또는 작성자</option>
									<option value="TCW" ${pageMaker.cri.type == 'TCW' ? 'selected' : ''}>제목 또는 내용 또는 작성자</option>
								</select>
								<input id="keyword" name="keyword" type="text" value="${pageMaker.cri.keyword}"/>
								<input id="pageNum" type="hidden" value="${pageMaker.cri.pageNum}"/>
								<input id="amount" type="hidden" value="${pageMaker.cri.amount}"/>
								<a href="#" class="search button primary icon solid fa-search">검색</a>
							</div>
						</div>
					</div>
				</form>
				<div class="small-width" style="text-align: center;">
					<c:if test="${pageMaker.cri.pageNum > 1}">
						<a class="changePageSmall" href="${pageMaker.cri.pageNum - 1}"><code>&lt;</code></a>
					</c:if>
					<code>${pageMaker.cri.pageNum}</code>
					<c:if test="${pageMaker.cri.pageNum != pageMaker.realEnd}">
						<a class="changePageSmall" href="${pageMaker.cri.pageNum + 1}"><code>&gt;</code></a>
					</c:if>

					<form id="actionFormSmall" action="/board/list" method="get">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"> 
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
						<input type="hidden" name="type" value="${pageMaker.cri.type}">
						<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
					</form>
				</div>

				<div class="big-width" style="text-align: center">
					<c:if test="${pageMaker.prev}">
						<a class="changePage" href="${pageMaker.startPage - 1}"><code>&lt;</code></a>
					</c:if>
					<c:forEach var="num" begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}">
						<c:choose>
							<c:when test="${pageMaker.cri.pageNum eq num}">
								<code>${num}</code>
							</c:when>
							<c:otherwise>
								<a class="changePage" href="${num}"><code>${num}</code></a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${pageMaker.next}">
						<a class="changePage" href="${pageMaker.endPage + 1}"><code>&gt;</code></a>
					</c:if>

					<form id="actionForm" action="/board/list" method="get">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
						<input type="hidden" name="type" value="${pageMaker.cri.type}">
						<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- Scripts -->
	<script src="/resources/assets/js/jquery.min.js"></script>
	<script src="/resources/assets/js/jquery.dropotron.min.js"></script>
	<script src="/resources/assets/js/browser.min.js"></script>
	<script src="/resources/assets/js/breakpoints.min.js"></script>
	<script src="/resources/assets/js/util.js"></script>
	<script src="/resources/assets/js/main.js"></script>

	<script>
		/* alert("${result}"); */

		var actionForm = $("#actionForm");
		var actionFormSmall = $("#actionFormSmall");
		var searchForm = $("#searchForm");

		$(".changePage").on("click", function(e) {
			//a 태그의 동작을 막고 원하는 url에 페이지 번호를 넘겨주어야 한다.
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		})

		$(".changePageSmall").on("click",function(e) {
			//a 태그의 동작을 막고
			e.preventDefault();
			actionFormSmall.find("input[name='pageNum']").val(
					$(this).attr("href"));
			actionFormSmall.submit();
		});

		$(".goGet").on("click", function(e){
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action", "/board/get");
			actionForm.submit();
		})
		
		$("#searchForm a").on("click", function(e){
			e.preventDefault();
			
			if(!searchForm.find("option:selected").val()){
				alert("검색 기준을 선택하세요");
				return false;
			}
			
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요");
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");
			searchForm.submit();
		});
		
		$(".home").on("click", function(e){
			location.href = "/board/list";
		});
		
		result = "${result}";
		$(document).ready(function() {
			//기본 히스토리 경로가 아니라면 true
			if (result == '' || history.state) {
				return;
			}

			if (parseInt(result) > 0) {
				alert("게시글 " + parseInt(result) + "번이 등록되었습니다.")
			}

			history.replaceState({}, null, null);
		})
	</script>

</body>
</html>











