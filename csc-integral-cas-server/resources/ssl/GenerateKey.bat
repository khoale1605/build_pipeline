del %2cacerts
del %2Integral.crt
keytool -genkey -dname "CN=%1, OU=Integral, O=CSC, ST=HCM, C=VN" -validity 3650 -alias %1 -keypass changeit -keystore %2\cacerts -storepass changeit -keyalg RSA
rem keytool -keystore %2\cacerts -storepass changeit -export -alias %1 -file %2\Integral.crt 
rem keytool -import -storepass changeit -file %2\Integral.crt -keystore %2\cacerts 

