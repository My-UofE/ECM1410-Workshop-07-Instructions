#!/bin/bash

read -r -d '' t01CopyArrayApp << EOM
original values: [1, 1, 2, 3, 4, 4]
unique values: [1, 2, 3, 4]
EOM

read -r -d '' t02PassByValueApp << EOM
After the method: red
5
EOM

read -r -d '' t03StringFormatApp << EOM
name: Oscar                Age:  22 Height: 1.52m
My space height would be 155.5cm
On Mars I would be approximately 12 years old.
EOM

read -r -d '' t04AuthorApp << EOM
Author[name=Richard Osman,email=noone@nowhere.com,gender=m]
name is: Richard Osman
email is: osman@murderclub.com
gender is: m
EOM

read -r -d '' t06BookShopApp << EOM
Book[name=Data Mining Handbook,authors={Author[name=Robert Nisbet,email=,gender=u]},price=27.95,qty=10]
Book[name=Mastering COBOL,authors={Author[name=Roger Hutty,email=,gender=u]},price=4.95,qty=10]
Book[name=Intro to COBOL,authors={Author[name=Paul Murrill,email=,gender=u]},price=7.35,qty=4]
Book[name=Making Software,authors={Author[name=Andy Oram,email=,gender=u]},price=35.00,qty=5]
Book[name=OO Design Using Java,authors={Author[name=James Nino,email=,gender=u],Author[name=Frederick Hosch,email=,gender=u]},price=30.00,qty=6]
Book[name=Objects First with Java,authors={Author[name=David Barnes,email=,gender=u],Author[name=Michael Kolling,email=,gender=u]},price=29.50,qty=4]
| Data Mining Handbook    | Robert Nisbet                |  27.95 | 010 |
| Mastering COBOL         | Roger Hutty                  |   4.95 | 010 |
| Intro to COBOL          | Paul Murrill                 |   7.35 | 004 |
| Making Software         | Andy Oram                    |  35.00 | 005 |
| OO Design Using Java    | James Nino,Frederick Hosch   |  30.00 | 006 |
| Objects First with Java | David Barnes,Michael Kolling |  29.50 | 004 |
Search for term(s) 'making software' in title...
| Data Mining Handbook    | Robert Nisbet                |  27.95 | 010 |
| Mastering COBOL         | Roger Hutty                  |   4.95 | 010 |
| Intro to COBOL          | Paul Murrill                 |   7.35 | 004 |
| Making Software         | Andy Oram                    |  35.00 | 004 |
| OO Design Using Java    | James Nino,Frederick Hosch   |  30.00 | 006 |
| Objects First with Java | David Barnes,Michael Kolling |  29.50 | 004 |
Removing all books with term 'cobol' in title...
Removed 2 books
| Data Mining Handbook    | Robert Nisbet                |  27.95 | 010 |
| Making Software         | Andy Oram                    |  35.00 | 004 |
| OO Design Using Java    | James Nino,Frederick Hosch   |  30.00 | 006 |
| Objects First with Java | David Barnes,Michael Kolling |  29.50 | 004 |
EOM

# Iterate over all Java files in the directory
for java_file in *App.java; do
    # Compile the Java file
    javac "$java_file"
done

java CopyArrayApp 1 1 2 3 4 4 > ./tests/t01CopyArrayApp.out
if [[ $? -eq 0 ]]; then
    echo "CopyArrayApp: RAN"
else
    echo "CopyArrayApp: FAILED_TO_RUN"
    t01CopyArrayApp=FAILED_TO_RUN
fi

java PassByValueApp | tail -n 1 > ./tests/t02PassByValueApp.out
java PassByValueApp | wc -l | tr -d '[:blank:]'  >> ./tests/t02PassByValueApp.out
if [[ $? -eq 0 ]]; then
    echo "PassByValueApp: RAN"
else
    echo "PassByValueApp: FAILED_TO_RUN"
    t02PassByValueApp=FAILED_TO_RUN
fi



java StringFormatApp Oscar 22 1.52 > ./tests/t03StringFormatApp.out
if [[ $? -eq 0 ]]; then
    echo "StringFormatApp: RAN"
else
    echo "StringFormatApp: FAILED_TO_RUN"
    t03StringFormatApp=FAILED_TO_RUN
fi

java AuthorApp > ./tests/t04AuthorApp.out
if [[ $? -eq 0 ]]; then
    echo "AuthorApp: RAN"
else
    echo "AuthorApp: FAILED_TO_RUN"
    t04AuthorApp=FAILED_TO_RUN
fi

# java BookApp > ./tests/05_BookApp.out
java BookShopApp > ./tests/t06BookShopApp.out
if [[ $? -eq 0 ]]; then
    echo "BookShopApp: RAN"
else
    echo "BookShopApp: FAILED_TO_RUN"
    t06BookShopApp=FAILED_TO_RUN
fi

for student in ./tests/*.out; do
    #t01CopyArrayApp=$(<./tests/t01CopyArrayApp.out)
    ref=$(basename $student)
    ref="${ref%.*}"
    var="$(diff -B -y --suppress-common-lines $student <(echo "${!ref}") | wc -l)"
    if [[ $var -eq 0 ]]; then
        echo ${ref:3}: PASS
    else
        echo ${ref:3}: FAIL
        echo DIFFERENCES:
        diff -B $student <(echo "${!ref}")

    fi
done
