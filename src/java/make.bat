
mkdir org\phed\reform\test\

"c:\Program Files\Java\jdk1.5.0_08\bin\javac" Reform.java
"c:\Program Files\Java\jdk1.5.0_08\bin\javac" -classpath /Projects/junit-4.1.jar;. ReformTest.java

copy Reform.class org\phed\reform\.
copy ReformTest.class org\phed\reform\test\.

