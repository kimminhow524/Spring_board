<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" href="/resources/assets/css/main.css" />
<style>
	.reply{
		border-bottom: 1px solid #ff8b77;
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
					<h1>Board</h1>
					<p>게시글 상세보기</p>
				</header>
				<!-- Table -->
				<h3>
					<a href="/board/list${cri.getListLink()}" class="button small">목록 보기</a>
				</h3>
				<div class="content">
					<div class="form">
						<form method="post" action="/board/remove">
							<input type="hidden" name="type" value="${cri.type}">
							<input type="hidden" name="keyword" value="${cri.keyword}">
							<input type="hidden" name="pageNum" value="${cri.pageNum}">
							<input type="hidden" name="amount" value="${cri.amount}">
							<div class="fields">
								<div class="field">
									<h4>번호</h4>
									<input name="bno" type="text" value="${board.bno}" readonly/>
								</div>
								<div class="field">
									<h4>제목</h4>
									<input name="title" type="text" value="${board.title}" readonly/>
								</div>
								<div class="field">
									<h4>내용</h4>
									<textarea name="content" rows="6"
										style="resize: none" readonly>${board.content}</textarea>
								</div>
								<div class="field">
									<h4>작성자</h4>
									<input name="writer" type="text" value="${board.writer}" readonly/>
								</div>
							</div>
							<ul class="actions special">
								<li>
									<input type="button" class="button" value="수정" onclick="location.href='/board/modify${cri.getListLink()}&bno=${board.bno}'" />
									<input type="submit" class="button" value="삭제" />
								</li>
							</ul>
							<ul class="icons">
								<li style="display:block">
									<span class="icon solid fa-envelope"></span>
									<strong>댓글</strong>
								</li>
							</ul>
							<a href="#" style="width:100%" class="button primary small register">댓글 등록</a>
							<div class="fields register-form" style="display:none">
								<div class="field">
									<h4>작성자</h4>
									<input name="replyer" placeholder="Replyer" type="text" />
								</div>
								<div class="field">
									<h4>댓글</h4>
									<textarea name="reply" rows="6" placeholder="Reply"
										style="resize: none"></textarea>
								</div>
								<div style="text-align:center" class="field regBtn">
									<a href="#" class="button primary small finish">등록</a>
									<a href="#" class="button primary small cancel">취소</a>
								</div>
							</div>
							<ul class="replies">
							</ul>
							<div class="big-width" style="text-align: center">
							</div>
						</form>
					</div>
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
	<script src="/resources/assets/js/reply.js"></script>
	
	<script>
		$(".register").on("click", function(e){
			e.preventDefault();
			
			$(".register-form").show();
			$(this).hide();
		});
	
		$(".cancel").on("click", function(e){
			e.preventDefault();
			
			$(".register-form").hide();
			$(".register").show();
		});
		
		$(".finish").on("click", function(e){
			e.preventDefault();
			
			var bnoValue = "${board.bno}";
			var replyValue = $("textarea[name='reply']").val();
			var replyerValue = $("input[name='replyer']").val();
			
			replyService.add({reply : replyValue, replyer : replyerValue, bno : bnoValue}, 
					function(result){
						alert("등록 완료");
			})
			location.reload(); //새로고침
		});
		
		$(document).ready(function(){
			var bnoValue = "${board.bno}";
			var replyUL = $(".replies");
			
			var pageNum = 1;
			var replyPageFooter = $(".big-width");
			
			showList(1);
			
			function showReplyPage(replyCnt){
				var endNum = Math.ceil(pageNum / 10.0) * 10;
				var startNum = endNum - 9;
				
				var prev = startNum != 1;
				var next = false;
				
				var str = "";
				
				if(endNum * 10 >= replyCnt){
					endNum = Math.ceil(replyCnt / 10.0);
				}
				
				if(endNum * 10 < replyCnt){
					next = true;
				}
			
				if(matchMedia("screen and (max-width : 918px)").matches){
					
					if(pageNum > 1){
						str += "<a class='changePage' href='"+(pageNum - 1)+"'><code>&lt;</code></a>"
					}
					str += "<code>"+ pageNum +"</code>";
					if(pageNum != endNum){
						str += "<a class='changePage' href='"+(pageNum + 1)+"'><code>&gt;</code></a>"
					}
					
				}else{
					if(prev){
						str += "<a class='changePage' href='"+(startNum - 1)+"'><code>&lt;</code></a>"
					}
					for(var i = startNum; i <= endNum; i++){
						if(i == pageNum){
							str += "<code>"+ i +"</code>";
							continue;
						}
						str += "<a class='changePage' href='"+ i +"'><code>" + i + "</code></a>";
					}
					if(next){
						str += "<a class='changePage' href='"+(endNum + 1)+"'><code>&gt;</code></a>"
					}
				}
				replyPageFooter.html(str);

				$(".changePage").on("click", function(e){
					e.preventDefault();
					
					targetNum = $(this).attr("href");
					pageNum = parseInt(targetNum);
					
					showList(pageNum);
				})
			}
			
			
			function showList(page){
				replyService.getList({bno : bnoValue, page : page || 1}, function(replyCnt, list){
					var str = "";
					if(list == null || list.length == 0){
						//댓글이 없습니다.
						replyUL.html("댓글이 없습니다.");
						return;
					}
					
					for(var i=0, len = list.length || 0; i < len; i++){
						str += "<li style='display:block'>";
						str += "<strong>" + list[i].replyer + "</strong>";
						str += "<p class='reply"+ list[i].rno +"'>" + list[i].reply + "</p>"
						str += "<div style='text-align:right'><strong>"
						+ replyService.displayTime(list[i].replyDate) +
						"</strong>";
						str += "<br><a href='"+list[i].rno+"' class='modify'>수정</a>";
						str += "<a href='"+list[i].rno+"' style='display:none' class='finish'>수정완료</a>&nbsp;&nbsp;&nbsp;&nbsp;";
						str += "<a href='"+list[i].rno+"' class='remove'>삭제</a></div>";
						str += "<div class='reply'></div>"
					}
					replyUL.html(str);
					showReplyPage(replyCnt);
					//페이지 버튼 구현
					
					$(".modify").on("click", function(e){
						e.preventDefault();
						
						var rnoValue = $(this).attr("href");
						var replyTag = $(".reply"+rnoValue);
						
						replyTag.html("<textarea class='"+ rnoValue +"'>"+ replyTag.text() +"</textarea>")
						
						$(this).hide();
						
						var finishs = document.getElementsByClassName("finish");
						
						for(var i=0; i<finishs.length; i++){
							if(finishs[i].getAttribute("href") == rnoValue){
								finishs[i].style.display = "inline";
								break;
							}
						}
					});
					
					$(".finish").on("click", function(e){
						e.preventDefault();
						
						var bnoValue = "${board.bno}";
						var rnoValue = $(this).attr("href");
						
						replyService.update({rno : rnoValue, bno : bnoValue, reply : $("."+rnoValue).val()},
								function(result){
									if(result == "success"){
										alert("수정 완료");
									}
						});
						location.reload();
					});
					
					$(".remove").on("click", function(e){
						e.preventDefault();
						
						replyService.remove($(this).attr("href"), function(result){
							if(result == "success"){
								alert("삭제 완료");
							}
						})
						location.reload();
					});
				});
			}
		});
	</script>
	
	<script>
		//$(document).ready(function(){
			//console.log(replyService.name);
			
//		console.log("============");
//		console.log("JS TEST");
		
//		var bnoValue = "${board.bno}";
//		
//		replyService.add(
//			{reply : "JS TEST", replyer : "tester", bno : bnoValue},
//			function(result){
//				alert("RESULT : " + result);
//			}
//		);
		//})
		
		//댓글 목록 사용하기
//		var bnoValue = "${board.bno}";
//		
//		replyService.getList({bno : bnoValue, page : 1},function(list){
//			console.log(list);
//		});
		
		//댓글 삭제
		
//		replyService.remove(6,
//				
//			function(result){
//				if(result == "success"){
//					alert("REMOVED");
//				}
//		}, function(err){
//			alert("ERROR...");
//		})
		
		//댓글 수정
//		var bnoValue = "${board.bno}";
//		
//		replyService.update({
//			rno : 20,
//			bno : bnoValue,
//			reply : "Modified Reply"
//		}, function(result){
//			alert("MODIFIED");
//		})
		
		//댓글 조회
//		replyService.get(20, function(result){
//			console.log(result);
//		})
		
	</script>
	
</body>
</html>

















