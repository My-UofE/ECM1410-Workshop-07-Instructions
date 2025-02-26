#!/bin/bash

read -r -d '' t01_TestCylinder1 << EOM
Class: class Circle, Radius: 2.00, Colour: blue, Area: 12.57
Class: class Cylinder, Height: 5.00, Radius: 2.00, Colour: red, Area: 87.96, Volume: 62.83
Surface Area: 87.96, Base Area: 87.96
EOM

read -r -d '' t02_TestCylinder2 << EOM
Height: 5.00, Radius: 2.00, Area: 87.96, Volume: 62.83

running
Circle c3 = new Circle();
c3.printClassInfo();
It is a Circle class

running
Cylinder cy4 = new Cylinder();
cy4.printClassInfo();
It is a Cylinder class

running
Circle cy5 = new Cylinder();
cy5.printClassInfo();
It is a Cylinder class

running
cy4.printClassInfoStatic();
It is a Cylinder class

running
cy5.printClassInfoStatic();
It is a Circle class
EOM

read -r -d '' t03_ShapeApp << EOM
Rectangle[width=3.00,height=4.00,color=green,area=12.00,perimeter=14.00]
Triangle[a=3.00,b=4.00,c=5.00,color=green,area=3.00,perimeter=12.00]
true
false
EOM

# Iterate over all Java files in the directory
for java_file in *.java; do
    # Compile the Java file
    javac "$java_file"
done

java TestCylinder1 > ./tests/t01_TestCylinder1.out
if [[ $? -eq 0 ]]; then
    echo "TestCylinder1: COMPILED"
    TestCylinder1=COMPILED
else
    echo "TestCylinder1: FAILED_TO_RUN"
    TestCylinder1=FAILED_TO_COMPILE
fi

java TestCylinder2 > ./tests/t02_TestCylinder2.out
if [[ $? -eq 0 ]]; then
    echo "TestCylinder2: COMPILED"
    TestCylinder2=COMPILED
else
    echo "TestCylinder2: FAILED_TO_COMPILE"
    TestCylinder2=FAILED_TO_COMPILE
fi

java ShapeApp > ./tests/t03_ShapeApp.out
if [[ $? -eq 0 ]]; then
    echo "ShapeApp: COMPILED"
    TestCylinder2=COMPILED
else
    echo "ShapeApp: FAILED_TO_COMPILE"
    TestCylinder2=FAILED_TO_COMPILE
fi

for student in ./tests/*.out; do
    ref=$(basename $student)
    ref="${ref%.*}"
    var="$(diff -B -y --suppress-common-lines $student <(echo "${!ref}") | wc -l)"
    if [[ $var -eq 0 ]]; then
        echo ${ref:4}: PASS
    else
        echo ${ref:4}: FAIL
        echo " "
        echo ... STUDENT FILE DIFFERS FROM EXPECTED OUTPUT....
        echo ............ EXPECTED OUTPUT: ...................
        echo "${!ref}"
        echo .............. YOUR OUTPUT: .....................
        cat $student
        echo ................................................
        echo " "
    fi
done