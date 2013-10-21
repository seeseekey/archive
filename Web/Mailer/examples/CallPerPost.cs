System.Net.ServicePointManager.Expect100Continue=false;

string url="http://example.org/mailer.php";

using(var wb=new WebClient())
{
	var data=new NameValueCollection();
	
	data["reciever"]="developer@example.org";
	data["subject"]="Mail from Application";
	data["message"]="Message";
	
	data["challenge"]="abc123";

	var response=wb.UploadValues(url, "POST", data);
}