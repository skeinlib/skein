/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/5/13
 * Time: 12:01 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.locale.core
{
public class ResourceManager
{
    private static var _instance:ResourceManager;

    public static function get instance():ResourceManager
    {
        if (_instance == null)
            _instance = new ResourceManager();

        return _instance;
    }

    public function ResourceManager()
    {
        super();
    }

    private var locale:Object =
    {
        "core" :
        {
            "MOBITILE" : "Mobitile",

            "SUBMIT" : "Submit",
            "BACK" : "BACK",
            "SAVE" : "SAVE",

            "ANONYMOUS" : "Anonymous",

            "HOME" : "Home",
            "CONTACTS" : "Contacts",
            "SOCIAL" : "Social",

            "DD" : "DD",
            "MM" : "MM",
            "YYYY" : "YYYY"

        },
        "index" :
        {
            "CONTACTS" : "CONTACTS",
            "SOCIAL" : "SOCIAL",
            "SHOPS" : "eSHOPS"
        },
        "auth" :
        {
            "EMAIL" : "Email",
            "USERNAME" : "Username",
            "PASSWORD" : "Password",
            "RE_PASSWORD" : "Re-Password",
            "REMIND" : "Remind",
            "FIRST_NAME" : "First Name",
            "LAST_NAME" : "LastName",
            "REGISTER" :"Register",
            "REGISTRATION" :"Registration",
            "LOGIN" : "Login",
            "PHONE" : "Phone"
        },
        "profile" :
        {
            "PROFILE" : "My Profile",

            "FIRST_NAME" : "First Name:",
            "LAST_NAME" : "Last Name:",
            "EMAIL" : "Email:",
            "PHONE" : "Phone:",
            "LOCATION" : "Location:",
            "BIRTHDAY" : "Birthday:",
            "ABOUT" : "About:"
        }
    };

    public function getString(bundle:String, key:String, params:Array=null):String
    {
        return locale[bundle][key] as String;
    }
}
}
