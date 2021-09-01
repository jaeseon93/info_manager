var hasTwoFactor = false;
$(function(){
    $("#aEdit").bind("click", function(){
        $("#divBody").load("toInfo.do", afterLoad);
    });
    $("#aLogout").bind("click", function(){
        location.href="toLogout.do";
    });
    $("#btnPassword").bind("click", function(){
       $("#divBody").load("toPassword.do");
    });

    $("#btnAddress").bind("click", function(){
        $("#divBody").load("toAddress.do");
    });

    $("#btnReceipt").bind("click", function(){
        $("#divBody").load("toReceipt.do");
    });

    $("#btnHome").bind("click", function(){
        location.href="toMain.do";
    });

    $("#btnNote").bind("click", function(){
        $("#divBody").load("toNote.do");
    });



    let $btnSearch = $("#btnSearch");

    $btnSearch.off();
    $btnSearch.on( "click", searchCards);
    let $inputSearch = $("#input-search");
    $inputSearch.off();

    $inputSearch.on("keyup",function(key) {
        searchCards();
    });

});
function searchCards(){
    let $titles = $(".card-title");
    let $searchText = $("#input-search").val();
    $.each($titles, function(index, item){
        let $item = $(item);
        let $parent = $item.parents(".basic-card");

        if( $item.html().search($searchText) == -1 ){
            $parent.hide();
        }else{
            $parent.show();
        }
    });
}

function afterLoad(){
    hasTwoFactor = false;
    getData();
    $("#aEdit").bind("click", function(){
        $("#divBody").load("toInfo.do", afterLoad);
    });
    $("#btnGenTwo").bind("click", genTwoFactor);
    $("#btnAuth").bind("click", checkTwoFactor);
    $("#divOTPComplete").hide();
    $("#btnSave").bind("click", changePw);
    if(hasTwoFactor){
        $("#divOTPComplete").show();
        $("#divAddTwoFactor").hide();
    }else{
        $("#divOTPComplete").hide();
        $("#divAddTwoFactor").show();
    }
    $("#checkPw").change(inputCheck);
}

function getData(){
    console.log("GetDATA");

    $.ajax({
        url : "getmeminfo.do",
        type : "POST",
        datatype:"json",
        async : false,
        success : function(data){
            console.log(data);
            let json = JSON.parse(data);
            let email = json.email;
            let phone = json.phone;
            hasTwoFactor = json.hasTwoFactor;
            $("#email").val(email);
            $("#phone").val(phone);
        }
    });
}

function inputCheck(){
    let pw = $("#pw").val();
    let pwCheck = $("#checkPw").val();
    let pwWarning = $("#checkPwWarning");
    let phone = $("#phone").val();

    if(phone=="" && pwCheck=="")
        return false;

    let result = true;

    if(pw != pwCheck){
        pwWarning.removeClass("d-none");
        result = false;
    }else{
        if(pwWarning.hasClass("d-none"))
            $("#checkPwWarning").addClass("d-none");
    }

    return result;
}


function genTwoFactor(){
    $.ajax({
        type:"POST",
        url:"gentwofactor.do",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: "",
        datatype:"json",
        success: function(data) {
            var obj = JSON.parse(data);
            var url = obj.url;
            var key = obj.key;

            if( key != null) {
                var img = document.getElementById("twoFactorImg");
                var keyElement = document.getElementById("otpKey");
                img.setAttribute("src", url);
                keyElement.value = key;
                $(".divAuth").each(function (index, item) {
                    console.log(item);
                    $(item).removeClass("d-none");
                });
            }
        },
        error: function(e) {

        }
    });
}

function checkTwoFactor(){
    let json = {};
    json.encryptKey = $("#otpKey").val();
    json.numberKey = $("#auth").val();

    $.ajax({
        type:"POST",
        url:"addtwofactor.do",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: json,
        datatype:"json",
        success: function(data) {
            let json = JSON.parse(data);
            if(json.result){
                $("#divAddTwoFactor").hide();
                $("#divOTPComplete").show();
            }else{
                alert("정확한 값을 입력해주세요");
            }
        }
    });

}

