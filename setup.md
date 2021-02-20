# CRUD Python + MySql App
## I. Setting up the Environment
Make sure you have the following setup. 
1. IDE - VS Code
`<link>` :https://code.visualstudio.com/
install Extension: Python
2. Database Server - MySql  ( XAMPP)
3. Python3  - Python 3.9.1 + pip
pip is already installed if you are using Python 2 >=2.7.9 or Python 3 >=3.4 
`<link>` : https://www.python.org/
`<link>` : https://pip.pypa.io/en/stable/installing/
```
python
pip -V
pip3 -V
py -m pip --version
py -m pip install --upgrade pip 
```
4. MySql-Connector or  PyMySQL or mysqlclient  library
Check if you have PyMySQL library in your system.
Run a pip3 list and look for PyMySQL or MySql-Connector from the list. If you cannot find it, install the library.
```
pip3 list
```
 For Python 3 or higher version install using pip3
 If you cannot find it, install the library.

 ```
 python -m pip install mysql-connector-python
 ```
 or
 ```
 pip install mysql-connector-python
 ```
 or
 ```
pip3 install PyMySQL
 ```
5. [Run Python from xampp - optional] XAMPP setup
- Go to apache >> conf: \xampp\apache\conf\httpd.conf
- put the below codes in the end of that file:
```
AddHandler cgi-script .py
ScriptInterpreterSource Registry-Strict
```
- In same file search for <IfModule dir_module>. When you've found it put index.py
- restart apache
- Open a text editor & test python now on xammp htdoc directory test.py, but wait at the beginning of your script you need to specify the path where you've installed python.
```
#!C:/Users/YOUR_WINDOWS_PROFILE/AppData/Local/Programs/Python/Python39/python
print("Content-Type: text/html")
print ("<h1>This is my first CGI script</h1>")
```
- You must remove any tab / spaces before the #!