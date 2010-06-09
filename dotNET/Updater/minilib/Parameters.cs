using System;
using System.Collections;
using System.Collections.Generic;

namespace Updater.minilib
{
    /// <summary>
    /// Klasse zur internen Parameterdarstellung
    /// </summary>
    public sealed class Parameters:ICloneable
    {
        Dictionary<string, object> items;

        public Parameters()
        {
            items=new Dictionary<string, object>();
        }

        #region Clone
        public object Clone()
        {
            Parameters ret=(Parameters)MemberwiseClone();
            ret.items=new Dictionary<string, object>();
            foreach(string key in items.Keys)
            {
                object o=Get(key);
                if(o is byte[])
                {
                    byte[] arr=(byte[])o;
                    byte[] val=new byte[arr.Length];
                    arr.CopyTo(val, 0); // Kopieren des Byte-Arrays
                    ret.Add(key, val);
                }
                else if(o is List<string>)
                {
                    List<string> list=(List<string>)o;
                    List<string> val=new List<string>(list); // Kopieren der String-Liste
                    ret.Add(key, val);
                }
                else if(o is List<long>)
                {
                    List<long> list=(List<long>)o;
                    List<long> val=new List<long>(list); // Kopieren der Long-Liste
                    ret.Add(key, val);
                }
                else if(o is List<bool>)
                {
                    List<bool> list=(List<bool>)o;
                    List<bool> val=new List<bool>(list); // Kopieren der Bool-Liste
                    ret.Add(key, val);
                }
                else if(o is List<double>)
                {
                    List<double> list=(List<double>)o;
                    List<double> val=new List<double>(list); // Kopieren der Double-Liste
                    ret.Add(key, val);
                }
                else if(o is List<Parameters>)
                {
                    List<Parameters> list=(List<Parameters>)o;
                    List<Parameters> val=new List<Parameters>(list.Count);
                    foreach(Parameters p in list) val.Add((Parameters)p.Clone()); // Clonen der Parameters in der Parameters-Liste
                    ret.Add(key, val);
                }
                else if(o is Parameters)
                {
                    Parameters p=(Parameters)o;
                    ret.Add(key, (Parameters)(p.Clone()));  // Clonen des Parameters
                }
                else
                {
                    //  Put statt Add wegen des unbekannten Typs von 'o'
                    ret.Put(key, o); // Kopieren aller anderen Typen (bool, long, string und double).
                }
            }

            return ret;
        }
        #endregion

        #region CheckName
        // 'name' muss mit (a-z), (A-Z), _ oder $ beginnen, danach auch Ziffern möglich
        static bool CheckName(string name)
        {
            int namelen=name.Length;
            if(namelen<1) return false;
            char c=name[0];

            if(!(c>='a'&&c<='z')&&!(c>='A'&&c<='Z')&&(c!='$')&&(c!='_'))
                return false;

            int token=1;

            while(token<namelen)
            {
                c=name[token++];

                if(!(c>='a'&&c<='z')&&!(c>='A'&&c<='Z')&&
                    !(c>='0'&&c<='9')&&(c!='$')&&(c!='_'))
                    return false;
            }
            return true;
        }
        #endregion

        #region ParseListIndex
        // Prüft ob 'name' ein Listeneintrag sein kann und wenn ja, wandelt ihn um.
        static int ParseListIndex(string name, out string listname)
        {
            listname="";

            if(name.Length<4) return -1; // name min: a[0]

            if(name[name.Length-1]!=']') return -1; // letzte Zeichen muss ']' sein

            int ind=name.IndexOf('[');
            if(ind<1) return -1; // nix gefunden, oder '[' am Anfang des strings

            string indStr=name.Substring(ind+1, name.Length-(ind+2));

            foreach(char c in indStr) if(c<'0'||c>'9') return -1; // prüfen, ob alle Zeichen Ziffern

            int ret=0;
            try
            {
                ret=int.Parse(indStr);
            }
            catch(Exception)
            {
                return -1;
            }

            listname=name.Substring(0, ind);
            return ret;
        }
        #endregion

        #region Put
        void Put(string name, object val)
        {
            // Canonize Key
            string key=name.Replace('\\', '/');
            while(key.IndexOf("//")!=-1) key=key.Replace("//", "/");
            key=key.Trim('/');

            // Check Key
            if(key.Length==0)
                throw new ArgumentException("Argument: 'name' must begin with an alpha-char,"+
                    " a dollar-sign or an understroke, afterwards digits are allowed too.",
                    "Argument: 'name' is invalid.");

            int ind=key.IndexOf('/');

            if(ind==-1)
            {
                PutLast(key, val);
                return;
            }

            string mainkey=key.Substring(0, ind);
            string subkey=key.Substring(ind+1);

            Parameters p=Get(mainkey) as Parameters;
            if(p!=null) p.Put(subkey, val);
            else PutSub(key, val);
        }

        void PutSub(string name, object val)
        {
            int ind=name.IndexOf('/');

            if(ind!=-1)
            { // wenn sub-Block
                string mainkey=name.Substring(0, ind);
                string subkey=name.Substring(ind+1);

                Parameters newp=new Parameters();
                newp.PutSub(subkey, val);

                PutLast(mainkey, newp);
                return;
            }

            PutLast(name, val);
        }

        void PutLast(string name, object val)
        {
            string listname="";
            int idx=ParseListIndex(name, out listname);

            if(idx==-1)
            { // wenn keine Liste oder kein Index
                #region wenn keine Liste oder kein Index
                string nameBrackets="";
                if(name.Length>2) nameBrackets=name.Substring(name.Length-2);

                if(nameBrackets=="[]")
                {
                    string name2=name.Substring(0, name.Length-2);

                    if(!CheckName(name2))
                        throw new ArgumentException("Argument: 'name' must begin with an alpha-char,"+
                            " a dollar-sign or an understroke, afterwards digits are allowed too.",
                            "Argument: 'name' is invalid.");

                    if(items.ContainsKey(name2))
                    {
                        IList ilist=items[name2] as IList;

                        if(ilist!=null)
                        { // wenn Liste
                            if(val is bool&&ilist is List<bool>)
                            {
                                List<bool> list=(List<bool>)ilist;
                                list.Add((bool)val);
                            }
                            else if(val is long&&ilist is List<long>)
                            {
                                List<long> list=(List<long>)ilist;
                                list.Add((long)val);
                            }
                            else if(val is double&&ilist is List<double>)
                            {
                                List<double> list=(List<double>)ilist;
                                list.Add((double)val);
                            }
                            else if(val is string&&ilist is List<string>)
                            {
                                List<string> list=(List<string>)ilist;
                                list.Add((string)val);
                            }
                            else if(val is Parameters&&ilist is List<Parameters>)
                            {
                                List<Parameters> list=(List<Parameters>)ilist;
                                list.Add((Parameters)val);
                            }
                            else throw new ArgumentException("Argument: 'val' must be of the same type as the typed list to be added to the list.", "Argument: 'val' is of illegal type.");

                            return;
                        }
                        else items.Remove(name2); // wenn keine Liste, dann entfernen
                    }

                    if(val is bool)
                    {
                        List<bool> list=new List<bool>();
                        list.Add((bool)val);
                        items.Add(name2, list);
                    }
                    else if(val is long)
                    {
                        List<long> list=new List<long>();
                        list.Add((long)val);
                        items.Add(name2, list);
                    }
                    else if(val is double)
                    {
                        List<double> list=new List<double>();
                        list.Add((double)val);
                        items.Add(name2, list);
                    }
                    else if(val is string)
                    {
                        List<string> list=new List<string>();
                        list.Add((string)val);
                        items.Add(name2, list);
                    }
                    else if(val is Parameters)
                    {
                        List<Parameters> list=new List<Parameters>();
                        list.Add((Parameters)val);
                        items.Add(name2, list);
                    }
                    else throw new ArgumentException("Argument: 'val' must be a type of a typed list to be added to a list.", "Argument: 'val' is of illegal type.");
                }
                else
                { // keine Liste
                    if(!CheckName(name))
                        throw new ArgumentException("Argument: 'name' must begin with an alpha-char,"+
                            " a dollar-sign or an understroke, afterwards digits are allowed too.",
                            "Argument: 'name' is invalid.");

                    if(items.ContainsKey(name)) items.Remove(name);
                    items.Add(name, val);
                }
                #endregion
            }
            else
            { // wenn Listen-Index
                #region wenn Listen-Index
                if(!CheckName(listname))
                    throw new ArgumentException("Argument: 'name' must begin with an alpha-char,"+
                        " a dollar-sign or an understroke, afterwards digits are allowed too.",
                        "Argument: 'name' is invalid.");

                if(items.ContainsKey(listname))
                {
                    ICollection icoll=items[listname] as ICollection;

                    if(icoll!=null)
                    {
                        if(idx>icoll.Count)
                            throw new IndexOutOfRangeException("Argument: name contains index greater than count of list.");

                        // replace or add
                        if(val is bool&&icoll is List<bool>)
                        {
                            List<bool> list=(List<bool>)icoll;
                            if(idx<list.Count) list[idx]=(bool)val;
                            else list.Add((bool)val);
                        }
                        else if(val is long&&icoll is List<long>)
                        {
                            List<long> list=(List<long>)icoll;
                            if(idx<list.Count) list[idx]=(long)val;
                            else list.Add((long)val);
                        }
                        else if(val is double&&icoll is List<double>)
                        {
                            List<double> list=(List<double>)icoll;
                            if(idx<list.Count) list[idx]=(double)val;
                            else list.Add((double)val);
                        }
                        else if(val is string&&icoll is List<string>)
                        {
                            List<string> list=(List<string>)icoll;
                            if(idx<list.Count) list[idx]=(string)val;
                            else list.Add((string)val);
                        }
                        else if(val is Parameters&&icoll is List<Parameters>)
                        {
                            List<Parameters> list=(List<Parameters>)icoll;
                            if(idx<list.Count) list[idx]=(Parameters)val;
                            else list.Add((Parameters)val);
                        }
                        else throw new ArgumentException("Argument: 'val' must be of the same type as the typed list to be added to the list.", "Argument: 'val' is of illegal type.");

                        return;
                    }
                }

                // keine Liste, löschen und neu anlegen
                if(idx!=0) // nur '[0]' mögich
                    throw new IndexOutOfRangeException("Argument: name contains index(greater 0) to an object that is not a list.");

                items.Remove(listname);

                if(val is bool)
                {
                    List<bool> list=new List<bool>();
                    list.Add((bool)val);
                    items.Add(listname, list);
                }
                else if(val is long)
                {
                    List<long> list=new List<long>();
                    list.Add((long)val);
                    items.Add(listname, list);
                }
                else if(val is double)
                {
                    List<double> list=new List<double>();
                    list.Add((double)val);
                    items.Add(listname, list);
                }
                else if(val is string)
                {
                    List<string> list=new List<string>();
                    list.Add((string)val);
                    items.Add(listname, list);
                }
                else if(val is Parameters)
                {
                    List<Parameters> list=new List<Parameters>();
                    list.Add((Parameters)val);
                    items.Add(listname, list);
                }
                else throw new ArgumentException("Argument: 'val' must be a type of a typed list to be added to a list.", "Argument: 'val' is of illegal type.");

                #endregion
            }
        }
        #endregion

        //////////////////////////////////////////////////////////////////////
        // Add-Methoden (native)
        //////////////////////////////////////////////////////////////////////
        #region Add-Methoden (native)
        public Parameters Add(string name, bool val)		// Boolean
        { Put(name, val); return this; }

        public Parameters Add(string name, sbyte val)		// Integer8
        { Put(name, (long)val); return this; }

        public Parameters Add(string name, short val)		// Integer16
        { Put(name, (long)val); return this; }

        public Parameters Add(string name, int val)			// Integer32
        { Put(name, (long)val); return this; }

        public Parameters Add(string name, long val)		// Integer64
        { Put(name, val); return this; }

        public Parameters Add(string name, byte val)		// UInteger8
        { Put(name, (long)val); return this; }

        public Parameters Add(string name, ushort val)		// UInteger16
        { Put(name, (long)val); return this; }

        public Parameters Add(string name, uint val)		// UInteger32
        { Put(name, (long)val); return this; }

        public Parameters Add(string name, ulong val)		// UInteger64
        { Put(name, (long)val); return this; }

        public Parameters Add(string name, float val)		// Float
        { Put(name, (double)val); return this; }

        public Parameters Add(string name, double val)		// Double
        { Put(name, val); return this; }

        public Parameters Add(string name, string val)		// String
        { Put(name, val); return this; }

        public Parameters Add(string name, Parameters val)	// Parameters
        { Put(name, val); return this; }

        public Parameters Add(string name, byte[] val)		// Datablock
        { Put(name, val); return this; }

        public Parameters Add(string name, List<bool> val)			// BooleanList
        { Put(name, val); return this; }

        public Parameters Add(string name, List<long> val)			// LongList
        { Put(name, val); return this; }

        public Parameters Add(string name, List<double> val)		// DoubleList
        { Put(name, val); return this; }

        public Parameters Add(string name, List<string> val)		// StringList
        { Put(name, val); return this; }

        public Parameters Add(string name, List<Parameters> val)	// ParametersList
        { Put(name, val); return this; }
        #endregion

        //////////////////////////////////////////////////////////////////////
        // Get-Methode (native)
        //////////////////////////////////////////////////////////////////////
        #region Get-Methode (native)
        public object Get_Old(string name) { return Get_Old(name, null); }
        public object Get_Old(string name, object std)
        {
            char[] sep=new char[] { '/', '\\' };
            string[] names=name.Split(sep, StringSplitOptions.RemoveEmptyEntries);

            if(names.Length==0) return std;

            if(!items.ContainsKey(names[0])) return std;

            if(names.Length==1) return items[names[0]];

            Parameters p=GetParameters(names[0]);
            if(p==null) return std;

            for(int i=1;i<(names.Length-1);i++)
            {
                p=p.GetParameters(names[i]);
                if(p==null) return std;
            }

            return p.Get(names[names.Length-1], std);
        }

        public object Get(string name) { return Get(name, null); }
        public object Get(string name, object std)
        {
            // Canonize Key
            string key=name.Replace('\\', '/');
            while(key.IndexOf("//")!=-1) key=key.Replace("//", "/");
            key=key.Trim('/');

            // Check Key
            if(key.Length==0) return std;

            return innerGet(key, std);
        }

        object innerGetLast(string name, object std)
        {
            string listname="";
            int idx=ParseListIndex(name, out listname);

            if(idx==-1)
            {
                if(!CheckName(name)) return std;
                if(!items.ContainsKey(name)) return std;

                return items[name];
            }
            else
            {
                if(!CheckName(listname)) return std;
                if(!items.ContainsKey(listname)) return std;

                ICollection list=Get(listname) as ICollection;
                if(list==null) return std;

                if(idx>=list.Count) return std;

                IList ilist=list as IList;
                return ilist[idx];
            }
        }

        object innerGet(string name, object std) // name ist schon sauber
        {
            int ind=name.IndexOf('/');

            if(ind==-1) return innerGetLast(name, std);

            string key=name.Substring(0, ind);
            string subkey=name.Substring(ind+1);

            string listname="";
            int idx=ParseListIndex(key, out listname);

            Parameters p=null;
            if(idx==-1)
            {	// keine Liste
                if(!CheckName(key)) return std;
                if(!items.ContainsKey(key)) return std;

                p=items[key] as Parameters;
                if(p==null) return std;

                return p.innerGet(subkey, std);
            }

            if(!CheckName(listname)) return std;
            if(!items.ContainsKey(listname)) return std;

            List<Parameters> pl=items[listname] as List<Parameters>;
            if(pl==null) return std;

            if(idx>=pl.Count) return std;

            p=pl[idx];
            return p.innerGet(subkey, std);
        }
        #endregion

        //////////////////////////////////////////////////////////////////////
        // Get<Type>-Methoden
        //////////////////////////////////////////////////////////////////////
        #region Get<Type>-Methoden
        public bool GetBool(string name) { return GetBool(name, false); }
        public bool GetBool(string name, bool std)
        {
            object o=Get(name, std);

            if(o is bool) return (bool)o;
            if(o is long) return (long)o!=0;
            if(o is double) return (double)o!=0;

            if(o is string)
            {
                string os=(string)o;
                os=os.ToLower();
                if(os=="true") return true;
                else if(os=="false") return false;
            }

            return std;
        }

        public long GetInt(string name) { return GetInt(name, 0L); }
        public long GetInt(string name, int std)
        {
            return GetInt(name, (long)std);
        }

        public long GetInt(string name, long std)
        {
            object o=Get(name, std);

            if(o is long) return (long)o;
            if(o is double) return (long)(double)o;

            return std;
        }

        public double GetDouble(string name) { return GetDouble(name, 0); }
        public double GetDouble(string name, double std)
        {
            object o=Get(name, std);

            if(o is long) return (double)(long)o;
            if(o is double) return (double)o;

            return std;
        }

        public string GetString(string name) { return GetString(name, ""); }
        public string GetString(string name, string std)
        {
            object o=Get(name, std);

            if(o is string) return o.ToString();

            return std;
        }

        public Parameters GetParameters(string name) { return GetParameters(name, null); }
        public Parameters GetParameters(string name, Parameters std)
        {
            object o=Get(name, std);

            if(o is Parameters) return (Parameters)o;

            return std;
        }

        public byte[] GetDataBlock(string name) { return GetDataBlock(name, null); }
        public byte[] GetDataBlock(string name, byte[] std)
        {
            object o=Get(name, std);

            if(o is byte[]) return (byte[])o;

            return std;
        }

        public List<bool> GetBoolList(string name) { return GetBoolList(name, null); }
        public List<bool> GetBoolList(string name, List<bool> std)
        {
            object o=Get(name, std);

            if(o is List<bool>) return (List<bool>)o;

            return std;
        }

        public List<long> GetIntList(string name) { return GetIntList(name, null); }
        public List<long> GetIntList(string name, List<long> std)
        {
            object o=Get(name, std);

            if(o is List<long>) return (List<long>)o;

            return std;
        }

        public List<double> GetDoubleList(string name) { return GetDoubleList(name, null); }
        public List<double> GetDoubleList(string name, List<double> std)
        {
            object o=Get(name, std);

            if(o is List<double>) return (List<double>)o;

            return std;
        }

        public List<string> GetStringList(string name) { return GetStringList(name, null); }
        public List<string> GetStringList(string name, List<string> std)
        {
            object o=Get(name, std);

            if(o is List<string>) return (List<string>)o;

            return std;
        }

        public List<Parameters> GetParametersList(string name) { return GetParametersList(name, null); }
        public List<Parameters> GetParametersList(string name, List<Parameters> std)
        {
            object o=Get(name, std);

            if(o is List<Parameters>) return (List<Parameters>)o;

            return std;
        }
        #endregion

        //////////////////////////////////////////////////////////////////////
        // andere Get-Methoden
        //////////////////////////////////////////////////////////////////////
        #region andere Get-Methoden
        public string[] GetNames()
        {
            string[] ret=new string[items.Keys.Count];
            items.Keys.CopyTo(ret, 0);
            return ret;
        }

        // Gibt Wert passend zum Key(name) als String (ToString()) bzw. "" wenn Key(name) nicht vorhanden
        public string GetAsString(string name)
        {
            object o=Get(name, "");
            return o.ToString();
        }

        public int Count
        {
            get { return items.Count; }
        }
        #endregion

        #region GetHash
        public static long GetHash(double value, long hc)
        {
            unchecked
            {
                hc+=System.Math.Abs(((int)value)+17);
                hc*=1234597;
                hc=System.Math.Abs(hc);
            }
            return hc;
        }

        public static long GetHash(long value, long hc)
        {
            unchecked
            {
                hc+=System.Math.Abs(((int)value)+17);
                hc*=1234597;
                hc=System.Math.Abs(hc);
            }
            return hc;
        }

        public static long GetHash(string value, long hc)
        {
            unchecked
            {
                int h=0;
                int off=0;
                int len=value.Length;

                if(len<16)
                {
                    for(int i=len;i>0;i--) h=(h*37)+value[off++];
                }
                else
                {
                    // only sample some characters
                    int skip=len/8;
                    for(int i=len;i>0;i-=skip, off+=skip) h=(h*39)+value[off];
                }

                hc+=System.Math.Abs(h);

                hc*=1234597;
                hc=System.Math.Abs(hc);
            }
            return hc;
        }

        public static long GetHash(bool value, long hc)
        {
            unchecked
            {
                hc+=System.Math.Abs(value?1231:1237);
                hc*=1234597;
                hc=System.Math.Abs(hc);
            }
            return hc;
        }

        static int StringComparer(string a, string b)
        {
            if(a==null&&b==null) return 0;
            if(a==null) return -1;

            int len=System.Math.Min(a.Length, b.Length);
            for(int i=0;i<len;i++)
            {
                if(a[i]<b[i]) return -1;
                if(b[i]<a[i]) return 1;
            }

            if(a.Length==b.Length) return 0;

            return a.Length<b.Length?-1:+1;
        }

        public static long GetHash(Parameters value, long hc)
        {
            unchecked
            {
                if(value==null) hc+=1345;
                else
                {
                    List<string> keys=new List<string>(value.items.Keys);
                    keys.Sort(StringComparer);
                    foreach(string key in keys)
                    {
                        hc=GetHash(key, hc);
                        object v=value.Get(key);
                        if(v==null) hc=GetHash((Parameters)null, hc);
                        else if(v is bool) hc=GetHash((bool)v, hc);
                        else if(v is double) hc=GetHash((double)v, hc);
                        else if(v is long) hc=GetHash((long)v, hc);
                        else if(v is string) hc=GetHash((string)v, hc);
                        else if(v is Parameters) hc=GetHash((Parameters)v, hc);
                        else
                        {
                            hc*=1234597;
                            hc=System.Math.Abs(hc);
                        }
                    }
                }

                hc*=1234597;
                hc=System.Math.Abs(hc);
            }

            return hc;
        }

        public static string GetHashString(Parameters value)
        {
            long hc=GetHash(value, 13);

            string ret="1-";
            while(hc>0)
            {
                ret+=(char)(hc%26+'a');
                hc/=17;
            }
            return ret;
        }

        public long GetHash(long hc)
        {
            return GetHash(this, hc);
        }

        public string GetHashString()
        {
            return GetHashString(this);
        }
        #endregion

        //////////////////////////////////////////////////////////////////////
        // Misc-Methoden
        //////////////////////////////////////////////////////////////////////
        #region Contains & innerContains's
        public bool IsEmpty()
        {
            return items.Count==0;
        }

        public bool Contains(string name)
        {
            // Canonize Key
            string key=name.Replace('\\', '/');
            while(key.IndexOf("//")!=-1) key=key.Replace("//", "/");
            key=key.Trim('/');

            // Check Key
            if(key.Length==0) return false;

            return innerContains(key);
        }

        bool innerContainsLast(string name)
        {
            string listname="";
            int idx=ParseListIndex(name, out listname);

            if(idx==-1)
            {
                if(!CheckName(name)) return false;
                return items.ContainsKey(name);
            }
            else
            {
                if(!CheckName(listname)) return false;
                if(!items.ContainsKey(listname)) return false;

                ICollection list=Get(listname) as ICollection;
                if(list==null) return false;

                return (idx<list.Count);
            }
        }

        bool innerContains(string name) // name ist schon sauber
        {
            int ind=name.IndexOf('/');

            if(ind==-1) return innerContainsLast(name);

            string key=name.Substring(0, ind);
            string subkey=name.Substring(ind+1);

            string listname="";
            int idx=ParseListIndex(key, out listname);

            Parameters p=null;
            if(idx==-1)
            {	// keine Liste
                if(!CheckName(key)) return false;
                if(!items.ContainsKey(key)) return false;

                p=items[key] as Parameters;
                if(p==null) return false;

                return p.innerContains(subkey);
            }

            if(!CheckName(listname)) return false;
            if(!items.ContainsKey(listname)) return false;

            List<Parameters> pl=items[listname] as List<Parameters>;
            if(pl==null) return false;

            if(idx>=pl.Count) return false;

            p=pl[idx];
            return p.innerContains(subkey);
        }
        #endregion

        #region Remove
        public bool Remove(string name)
        {
            // Canonize Key
            string key=name.Replace('\\', '/');
            while(key.IndexOf("//")!=-1) key=key.Replace("//", "/");
            key=key.Trim('/');

            // Check Key
            if(key.Length==0) return false;

            int ind=key.LastIndexOf('/');

            if(ind==-1)
            {
                string listname="";
                int idx=ParseListIndex(key, out listname);

                if(idx==-1)
                {
                    if(!CheckName(key)) return false;
                    return items.Remove(key);
                }
                else
                {
                    if(!CheckName(listname)) return false;
                    if(!items.ContainsKey(listname)) return false;

                    ICollection list=Get(listname) as ICollection;
                    if(list==null) return false;

                    if(idx!=list.Count-1) return false;
                    IList ilist=list as IList;

                    try
                    {
                        ilist.RemoveAt(idx);
                    }
                    catch(Exception)
                    {
                        return false;
                    }
                    return true;
                }
            }

            string mainkey=key.Substring(0, ind);
            string subkey=key.Substring(ind+1);

            Parameters p=Get(mainkey) as Parameters;
            if(p==null) return false;

            return p.Remove(subkey);
        }
        #endregion

        //////////////////////////////////////////////////////////////////////
        // Spezial-Add-Methoden
        //////////////////////////////////////////////////////////////////////
        // Fügt alle Werte des übergebenen Parameters ein. (Shallow Add)
        public Parameters Add(Parameters values)
        {
            foreach(string key in values.items.Keys) Put(key, values.items[key]);

            return this;
        }

        // Fügt alle Parameters/Wert-Paare aus einer Parametersstruktur hinzu.
        // Dabei werden Werte vom Typ Parameters bei gleichen Keys nicht überschrieben,
        // sondern rekursiv deren Werte eingetragen.
        // Bereits vorhanden Werte(nicht vom Typ Parameters) werden überschrieben.
        #region AddDeep
        public Parameters AddDeep(Parameters values)
        {
            foreach(string key in values.items.Keys)
            {
                if(!items.ContainsKey(key))
                {
                    Put(key, values.items[key]);
                    continue;
                }

                object valThis=items[key];
                bool fPThis=(valThis is Parameters);

                object valThat=values.items[key];
                bool fPThat=(valThat is Parameters);

                // Wenn beides pParameters sind, rekursiv weitermachen
                if(fPThis&&fPThat)
                {
                    ((Parameters)valThis).AddDeep((Parameters)valThat);
                    continue;
                }

                // Wenn beide keine Parameters sind -> Werte austauschen
                if(!fPThis&&!fPThat)
                {
                    Put(key, valThat); // Put statt Add wegen des unbekannten Typs von 'valThat'
                    continue;
                }

                // Jetzt ist eins Parameters und der andere nicht
                Parameters p;

                if(fPThis)
                {
                    p=(Parameters)valThis;
                    object o=valThat;

                    // Wir tragen den anderen Wert als "$default$"-Eintrag ein
                    p.Put("$default$", o);
                }
                else
                {
                    p=(Parameters)valThat;
                    object o=valThis;

                    // Wir tragen den anderen Wert als "$default$"-Eintrag ein
                    p.Put("$default$", o);

                    Add(key, p);
                }
            }

            return this;
        }
        #endregion

        //////////////////////////////////////////////////////////////////////
        // Sonstiges
        //////////////////////////////////////////////////////////////////////
        // Interpretiert eine Kommandozeile und schreibt die Werte in diese Parameterstruktur.
        // z.B. "-verbose -InFile:C:\hfjkhd.txt -OutFile:c:\dfsfk.out"
        #region InterpretCommandLine
        public static Parameters InterpretCommandLine(string[] args)
        {
            Parameters ret=new Parameters();
            if(args.Length<1) return ret;	// nix Argumente

            int filecount=0;
            string key;
            foreach(string str in args)
            {
                if(str[0]=='-')
                {
                    int idx=str.IndexOf(':');
                    if(idx>=0)
                    {
                        key=str.Substring(1, idx-1);
                        ret.Add(key, str.Substring(idx+1));
                    }
                    else
                    {
                        key=str.Substring(1);
                        ret.Add(key, true);
                    }
                }
                else
                {
                    key=String.Format("file{0:000}", filecount++);
                    ret.Add(key, str);
                }
            }
            return ret;
        }
        #endregion
    }
}