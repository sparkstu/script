@echo off

:: TODO:设置java环境变量
:: Author: Gwt
color 02
::设置java的安装路径，可方便切换不同的版本
set input=
set /p "input=请输入java的jdk路径（或回车默认路径为C:\Program Files\Java\jdk1.7.0_71）:"
if defined input (echo jdk已设置) else (set input=C:\Program Files\Java\jdk1.7.0_71)
echo jdk路径为%input%
set javaPath=%input%

::如果有的话，先删除JAVA_HOME
wmic ENVIRONMENT where "name='JAVA_HOME'" delete

::如果有的话，先删除ClASS_PATH 
wmic ENVIRONMENT where "name='CLASS_PATH'" delete

::创建JAVA_HOME
wmic ENVIRONMENT create name="JAVA_HOME",username="<system>",VariableValue="%javaPath%"

::创建CLASS_PATH
wmic ENVIRONMENT create name="CLASS_PATH",username="<system>",VariableValue=".;%%JAVA_HOME%%\lib\tools.jar;%

%JAVA_HOME%%\lib\dt.jar;"

::在环境变量path中，剔除掉变量java_home中的字符，回显剩下的字符串
call set xx=%Path%;%JAVA_HOME%\jre\bin;%JAVA_HOME%\bin

::echo %xx%

::将返回显的字符重新赋值到path中
wmic ENVIRONMENT where "name='Path' and username='<system>'" set VariableValue="%xx%"

pause





::    @echo off 是关闭回显的，不会显示命令信息 on打开会显示命令信息

::　　color 02是设置输出文本颜色的，这里是控制命令台输出绿颜色

::　　set /p "input=请输入命令信息" 是用来接收控制台输入的文本信息的

::　　if else 是用来做判断 if defined input 是用来判断用户是否输入信息，回车的话，则表示未定义input的值

::　　echo "输出信息" 是用来显示信息的

::　　set javaPath=%input% 是用来吧变量input的值赋值给javaPath变量的

::　　wmic 是提供了批处理的命令，可以方便的操作环境变量值

::　　删除某一环境变量 就使用 wmic ENVIRONMENT where "name='JAVA_HOME'" delete命令

::　  创建某一环境变量 使用 wmic ENVIRONMENT create name="JAVA_HOME",username="<system>",VariableValue="%javaPath%"命令

::    修改某一环境变量 使用 wmic ENVIRONMENT where "name='Path' and username='<system>'" set VariableValue="value"