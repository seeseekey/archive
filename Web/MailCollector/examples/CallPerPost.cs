System.Net.ServicePointManager.Expect100Continue=false;

string url="http://example.org/mailer.php";

//Send message per post
using(var wb=new WebClient())
{
	var data=new NameValueCollection();
	data["reciever"]="developer@example.org";
	data["subject"]="Bugreport";
	data["text"]="Bug 123";

	var response=wb.UploadValues(url, "POST", data);
}