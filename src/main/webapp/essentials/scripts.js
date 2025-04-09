function checksend() {
	data=document.login;
	if (data.usuario.value == '' ||
			data.pass.value == '')
		alert ('You must fill all fields!');
	else data.submit();
}

function checkfield(campo, evento) {
	var keycode;
	if (window.event) keycode = window.event.keyCode;
	else if (evento) keycode = evento.which;
	else return true;
	if (( keycode < 48 || keycode > 57 ) && ( keycode < 64 || keycode > 90 ) && ( keycode < 97 || keycode > 122 )) //Letter and number ASCII Range
	{
		if (keycode != 8 && keycode != 13 && keycode != 27 && keycode != 0 ) { //Allowed special characters
			alert('You can only introduce numbers and letters!');
			return false;
		} else if (keycode == 13) {
			compruebayenvia();
		} else return true;
	} else {
		return true;
	}
}

