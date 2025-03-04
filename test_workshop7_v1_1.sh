#!/bin/bash

echo $PWD

read -r -d '' t01_TestCylinder1 << EOM
Class: class Circle, Radius: 2.00, Colour: blue, Area: 12.57
Class: class Cylinder, Height: 5.00, Radius: 2.00, Colour: red, Area: 87.96, Volume: 62.83
Surface Area: 87.96, Base Area: 12.57
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
Triangle[a=3.00,b=4.00,c=5.00,color=green,area=6.00,perimeter=12.00]
true
false
EOM

# Iterate over all Java files in the directory
java_files="Circle.java Cylinder.java TestCylinder1.java TestCylinder2.java ShapeApp.java"
for java_file in $java_files; do
    # Compile the Java file
    echo Compiling $java_file
    javac "$java_file"
done

java TestCylinder1 > ./tests/t01_TestCylinder1.out
if [[ $? -eq 0 ]]; then
    echo "TestCylinder1: RAN"
    TestCylinder1=RAN
else
    echo "TestCylinder1: FAILED_TO_RUN"
    TestCylinder1=FAILED_TO_RUN
fi

java TestCylinder2 > ./tests/t02_TestCylinder2.out
if [[ $? -eq 0 ]]; then
    echo "TestCylinder2: RAN"
    TestCylinder2=RAN
else
    echo "TestCylinder2: FAILED_TO_RUN"
    TestCylinder2=FAILED_TO_RUN
fi

java ShapeApp > ./tests/t03_ShapeApp.out
if [[ $? -eq 0 ]]; then
    echo "ShapeApp: RAN"
    ShapeApp=RAN
else
    echo "ShapeApp: FAILED_TO_RUN"
    ShapeApp=FAILED_TO_RUN
fi
score=0
for student in ./tests/*.out; do
    ref=$(basename $student)
    ref="${ref%.*}"
    var="$(diff -B -y --suppress-common-lines $student <(echo "${!ref}") | wc -l)"
    if [[ $var -eq 0 ]]; then
        echo ${ref:4}: PASS
        ((score++))
    else
        echo ${ref:4}: FAIL
        mkdir -p tmpdir
        echo "${!ref}" > tmpdir/model_answer.txt
        cat $student > tmpdir/submitted.txt
        echo
        echo ">>> ${ref}: differences - submission code output (green) vs model answer (red)"
        echo
        git diff --no-prefix -U1000 --no-index --ignore-space-at-eol   \
             --ignore-cr-at-eol  --ignore-blank-lines  --color \
                tmpdir/model_answer.txt tmpdir/submitted.txt | tail -n +6 | sed 's/^/   /'
        # diff -B -E -Z $student <(echo "${!ref}")
        echo  
       echo " "
    fi
done
result=${PWD##*/}
echo SUMMARY user ${result:12} passed ${score} of the 3 provided tests

