function ShowHelp(url)
{	
var winHeight = 700;   ///
var winWidth = 980;//
var leftPos = (screen.width-winWidth)>>1;
var topPos = ((screen.height-winHeight)>>1)-20;
var URL = url;// 'help.ppt';//'help.aspx?='+url;
var newWindow = window.open( URL, 'help', "top="+topPos+",left="+leftPos+",height="+winHeight+",width="+winWidth+",status=no,toolbar=no,menubar=no,location=no,resizable=yes,scrollbars=1", false);
return false;
}	
function validateLogonForm(form) 
{
var username=form['username'];
var password=form['password'];
if( username.value.length == 0) 
{
alert("Введите логин\rEntrez nom d'utilisateur");
//alert("Введите логин\rEnter login\rEntrez nom d'utilisateur");
username.focus();
return false;
}
if( password.value.length == 0) 
{
alert("Введите пароль\rEnter password\rEntrez passe");
password.focus();
return false;
}
// if( username.value.length < 6) 
//{
// alert("Минимальная длина имени должна быть 6 символов");
// username.focus();
// return false;
//}
return true;
}
function JSEndSess(txt,val)
{ 
if(confirm(val))
{
var elem = document.getElementById(txt);
elem.value="yes";
__doPostBack(document);}
}

function SetTopWindow()
{
if (top.location!=self.location)
{
top.location=self.location; 
}
}
function mov(ctl,sost)
{
if (sost==1)
{
document.getElementById(ctl).className="menusel"; 
document.getElementById(ctl).style.color="Red"
}
else
{
document.getElementById(ctl).className="menuunsel";
document.getElementById(ctl).style.color="Gray"
}
}