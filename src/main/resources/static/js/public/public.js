//字符串不为空
$.extend({
	isNotEmpty: function(str) {
		return str != undefined && str != null && str != "";
	}
});
//弹窗
function $alert(message, f) {
	bootbox.alert({
		buttons: {
			ok: {
				label: '确定',
				className: 'btn-myStyle'
			}
		},
		title: "提示！",
		message: message,
		callback: f
	});
}

function $confirm(message, f,){
	bootbox.confirm(
			 { 
			  title: "提示",
			 /* size: "small",*/
			  message: message, 
			  buttons: {cancel: { label: '取消', className: 'btn-default' }, confirm: { label: '确定', className: 'btn-primary' } },
			  callback: f			  	
		     });
}

function $popDownloadWin() {
	var $dialog = bootbox.dialog({
		message: '<p class="text-center">正在下载，请稍后...</p>',
		closeButton: true
	});
	return $dialog;
}
