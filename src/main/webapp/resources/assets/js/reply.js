/**
 * reply module
 */

console.log("Reply Module.....");

var replyService = (function(){
	
	//댓글 추가
	function add(reply, callback, error){
		console.log("add reply........");
		//callback, error는 외부에서 전달받을 함수이다.
		//함수의 파라미터 개수를 일치시킬 필요가 없기 때문에
		//사용시 callback이나 error와 같은 파라미터는 상황에 따라 작성한다.
		$.ajax({
			type : "POST",
			url : "/replies/new",
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result ,status, xhr){
				if(callback){
					console.log(result);
					//외부에서 전달받은 값이 있다면 결과를 해당 함수에 전달하여 사용한다.
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					//외부에서 전달받은 값이 있다면 er객체를 전달하여 사용한다.
					error(er);
				}
			}
		});
	}
	
	//댓글 목록
	function getList(param, callback, error){
		var bno = param.bno;
		
		//var v = a || b 	: a에 값이 있으면 a를 v에 할당, 없으면 b를 v에 할당
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
				function(data){
					if(callback){
						callback(data.replyCnt, data.list);
					}
		}).fail(function(xhr, status, er){
			if(error){
				error(er);
			}
		});
	}
	
	//댓글 삭제
	function remove(rno, callback, error){
		$.ajax({
			type : "DELETE",
			url : "/replies/" + rno,
			success : function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
	
	//댓글 수정
	function update(reply, callback, error){
		console.log("RNO : " + reply.rno);
		
		$.ajax({
			type : "PUT",
			url : "/replies/" + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	//댓글 조회
	function get(rno, callback, error){
		$.get("/replies/" + rno, function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, er){
			if(error){
				error(er);
			}
		})
	}
	
	//시간 처리(당일은 시/분/초, 지난 날은 년/월/일)
	function displayTime(timeValue){
		var today = new Date();
		var dateObj = new Date(timeValue);
		var gap = today.getTime() - dateObj.getTime();
		
		if(gap < (1000 * 60 * 60 * 24)){
			//시/분/초
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [(hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss].join(' ');
		}else{
			//년/월/일
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			return [yy, '-', (mm > 9 ? '' : '0') + mm, '-', (dd > 9 ? '' : '0') + dd].join(' ');
		}
	}
	//외부에서는 replyService.키값(객체, 콜백)형식으로 사용하며
	//Ajax호출이 감춰져 있기 때문에 코드가 좀 더 깔끔해진다.
	return {add : add, getList : getList, remove : remove, update : update, get : get, displayTime : displayTime};
//	return {name : "AAAA"}
})();









