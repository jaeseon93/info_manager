<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.filebox input[type="file"] {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip:rect(0,0,0,0);
    border: 0;
}

.filebox label {
    display: inline-block;
    padding: .5em .75em;
    color: #999;
    font-size: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #fdfdfd;
    cursor: pointer;
    border: 1px solid #ebebeb;
    border-bottom-color: #e2e2e2;
    border-radius: .25em;
}

/* named upload */
.filebox .upload-name {
    display: inline-block;
    padding: .5em .75em;
    font-size: inherit;
    font-family: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #f5f5f5;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
  -webkit-appearance: none; /* 네이티브 외형 감추기 */
  -moz-appearance: none;
  appearance: none;
}

.filebox.bs3-primary label {
  color: #fff;
  background-color: #337ab7;
    border-color: #2e6da4;
}
.inputfile {
	padding-left: 5px;
}

.input {
	width: 70%;
}

.label {
	text-align: center;
	padding-top: 23px;
	padding-left: 10px;
}

.padding {
	padding-top: 17px;
}

</style>
<script>

	$(document).ready(function(){
	  var fileTarget = $('.filebox .upload-hidden');

	    fileTarget.on('change', function(){
	        if(window.FileReader){
	            var filename = $(this)[0].files[0].name;
	        } else {
	            var filename = $(this).val().split('/').pop().split('\\').pop();
	        }

	        $(this).siblings('.upload-name').val(filename);
	    });
	}); 
	
	function showImg(value) {
		if(value.files && value.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#scanimg').attr('src', e.target.result);
			}
			reader.readAsDataURL(value.files[0]);
		}
	}
	
	$(function() {
		$("#scan").bind("click", rctScan);
		$("#spinner").hide();
	});

	function rctScan() {
		var form = jQuery("#frm")[0];
		var fileData = new FormData(form);
		fileData.append("img", jQuery("#img")[0]);
		$("#spinner").show();		

		$.ajax({
			url : "fileUpload.do",
			type : "POST",
			data : fileData,
			processData : false,
			contentType : false,
			dataType : "json",
			success : function(data) {
				console.log(data)
				var addoption = $("<option>" + data.total + "</option>")
				$("#dtlist").append(addoption);
				var addoption = $("<option>" + data.place + "</option>")
				$("#dtlist").append(addoption);
				$("#total").val(data.total);
				$("#place").val(data.place);
				$("#spinner").hide();

			}
		});
}
	
	
</script>
	<datalist id="dtlist"></datalist>
	<!-- Modal body -->
	<div class="modal-body">
		<form id="frm" name="frm" method="post" action="${pageContext.request.contextPath}/rctInsert.do" enctype="multipart/form-data">
		<div class="row">
		<div class="col-8">
			<div class="row">
				<div class="col-md-8">
					<div class="padding filebox bs3-primary inputfile">
						<label for="img">사진 첨부</label>
						<input class="upload-name" value="파일을 선택해주세요" disabled="disabled" >
						<input type="file" class="upload-hidden" id="img" name="img" onchange="showImg(this);" >
					</div>
				</div>
				<div class="col-md-3">
						<button type="button" class="btn btn-link label" id="scan" name="scan"><spna id="spinner" class="spinner-border spinner-border-sm" visibility="gone" role="status" aria-hidden="true"></spna>Scan</button>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<div class="label">
						<label for="rctdate"> 날 짜 </label>
					</div>
				</div>
				<div class="col-md-8">
					<div class="padding">
						<input type="date" id="rctdate" name="rctdate" class="form-control input">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<div class="label">
						<label for="title"> 제 목 </label>
					</div>
				</div>
				<div class="col-md-8">
					<div class="padding">
						<input type="text" id="rcttitle" name="rcttitle" class="form-control input" placeholder="제목을 입력하세요">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<div class="label">
						<label for="place"> 상호명 </label>
					</div>
				</div>
				<div class="col-md-8">
					<div class="padding">
	 					<input type="text" class="form-control input" id="place" name="place" list="dtlist">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<div class="label">
						<label for="stuff"> 품 명 </label>
					</div>
				</div>
				<div class="col-md-8">
					<div class="padding">
						<select class="form-control input" id="stuff" name="stuff">
							<option>--선택--</option>
							<option value="문화생활">문화생활</option>
							<option value="미용">미용</option>
							<option value="생필품">생필품</option>
							<option value="식비">식비</option>
							<option value="의료/건강">의료/건강</option>
							<option value="의류">의류</option>
							<option value="애견">애견</option>
							<option value="기타">기타</option>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<div class="label">
						<label for="total"> 총 금액 </label>
					</div>
				</div>
				<div class="col-md-8">
					<div class="padding">
						<input class="form-control input" id="total" name="total" list="dtlist">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<div class="label">
						<label for="note"> 메모 </label>
					</div>
				</div>
				<div class="col-md-8">
					<div class="padding">
						<div class="form-group">
							<textarea class="form-control" rows="5" id="note" name="note"></textarea>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-4">
			<div class="row"> 
					<img id="scanimg" width="400" height="500">
			</div>
		</div>
		</div>
	</form>
	</div>