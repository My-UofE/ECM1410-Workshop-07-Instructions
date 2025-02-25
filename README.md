# ECM1410-Workshop-05-Instructions

**UPDATE 17th Feb**

If you are not sure why your code does not pass the tests please check this file: [Expected_Outputs.pdf](https://github.com/My-UofE/ECM1410-Workshop-05-Instructions/blob/main/Expected_Outputs.pdf)

It shows the output that should be produced by the different programs you have written. 

**UPDATE 12th Feb** 

You can add a test script to your repository by running the following command in your CodeSpace terminal:

```bash
curl https://raw.githubusercontent.com/My-UofE/ECM1410-Workshop-05-Instructions/refs/heads/main/test_all.sh -o ./tests/test_all.sh
```

Once present you can run the test from your working directory using the terminal command:

```bash
bash ./tests/test_all.sh
```

Note there is no test 5, because the contents of file 5: `BookApp.java` was unspecified. Therefore you should check the behaviour of your `Book` class carefully and in particular the `.getAuthorNames()` method which is not checked by the test script.


## Part A. Arrays, Pass By Reference and String Formatting

### 1. `CopyArrayApp.java`: Working with arrays and ArrayLists

The following code shows an example of a program that can read in a list of integers passed on the command line. It makes use of `args.length` to detect how many numbers have been passed.

```java
public class CopyArrayApp{
  public static void main(String[] args) {
    int nVals = args.length;
    for (int i = 0; i < nVals; i++) {
      int item = Integer.parseInt(args[i]);
      System.out.println(item);
    }
  }
}
```

Read through the code to check you can understand it. 

Create the file in your workspace then run the code in the terminal using the command below, and check the output is in line with your expectations. If there is anything you do not understand ask one of the teaching staff.

```
java CopyArrayApp 1 2 3 4
```

**TASK 1.1**

Now before the loop runs, add in the code below, that creates integer array `myVals`. Next edit the code so that instead of printing each value, it stores the loaded values into this array.

```
// to create a new array of ints
int[] myVals = new int[nVals];
```

```
// to allocate a value into the created array at index i
myVals[i] = ...
```

We can make use of a utility from `java.util.Arrays` to display the result. To do this add the following line to the top of your file:

```java
import java.util.Arrays;
```

Now add the following code in an appropriate place to display the array once all values have been loaded:

```java
System.out.println("original values: " + Arrays.toString(myVals));
```

Once your code is working you should be able to run the program using a command like:

```bash
java CopyArrayApp 1 8 3 5
```

and see output:

```
original values: [1, 8, 3, 5]
```

**TASK 1.2**

We want to develop our program and manually code an algorithm that creates a filtered copy of the list named `uniqueVals` that removes any duplicate values with the desired output as shown in the example below:

```bash
java CopyArrayApp 1 8 3 3 5 1 9
```

```
original values: [1, 8, 3, 3, 5, 1, 9]
unique values: [1, 8, 3, 5, 9]
```

One problem we have with implementing this is that we cannot create an output array and dynamically change its size to grow the array as we copy them in.

In theory we could get around this by: first calculating the number of unique items; then allocating an array of the right size; and finally selecting and copying in the unique items.

However we can avoid this by making use of the `ArrayList` class. This is a more flexible class that implements data array storage, that allows the addition/removal of elements after it has been created. This flexibility will come at a potential performance cost (because the fixed allocation of the basic array type can be more efficiently managed in memory).

To use an `ArrayList` you will need to add the following import at the top of your file:

```java
import java.util.ArrayList;
```

We can create an `ArrayList` using code like:

```java
ArrayList<Integer> uniqueVals = new ArrayList<>();
```

The methods to work with `ArrayList` objects differ from the basic java arrays, e.g. consider the following commands for an array:

```java
// create an int array with 10 values
int[] x = new int[10];

// set array values
x[0] = 5;
x[1] = 8;
x[2] = 7; 


// n stores 10
n = x.length; 

// extend array to add extra value 9
// NOT ALLOWED FOR ARRAY!!

// displays array values and length
System.out.println(Arrays.toString(x));
System.out.println(n); 

```
For an `ArrayList` these become:

```java
// create an int ArrayList initialised with preallocated space to store 3 values
// note we could use ArrayList<>() to initialise an empty array 
ArrayList<Integer> x = new ArrayList<>(3); 

// set array values
x.set(0) = 5;
x.set(1) = 8;
x.set(2) = 7; 

// extend array to add extra value 9
x.add(9)

// read the array length 
n = x.size();

// displays array values and length
System.out.println(x); // ArrayList class has `toString()` method inbuilt
System.out.println(n); 
```

Using the above commands edit your code to implement the functionality to display the created array of unique values, i.e. the desired output will be:

```bash
java CopyArrayApp 1 8 3 3 5 1 9
```

```
original values: [1, 8, 3, 3, 5, 1, 9]
unique values: [1, 8, 3, 5, 9]
```

Hint: The `ArrayList` class has a `.contains()` method which may be useful when checking for unique values.


**IMPORTANT** 

As this workshop is assessed please ensure that:

 i. your `CopyArrayApp` program produces output *exactly* in line with the format above, with 2 lines of output. 

 ii. you write your own algorithm to filter out duplicate values when filtering the original array values.
 
 iii. you successfully commit and push your `CopyArrayApp.java` file to the GitHub classroom repository where they can be accessed by the teaching staff. You should not commit any of the `.class` binary files (these do not need to be stored as they can be generated from the `.java` files).

### 2. `PassByValueApp.java`: Passing by value

The following is a quick example to help you better understand the *passing by value* concept.

Copy the code into file `PassByValueApp.java`.

```java
//An example for passing by value
class Apple {
   public String color;
   public Apple(String color){ this.color = color; }
}

public class PassByValueApp{
   public static void main(String[] args){
     Apple myApple = new Apple("red");
     System.out.println("myApple: "+myApple);//display memory address
     System.out.println("Before the method: "+myApple.color);
     changeAppleColor(myApple);
     System.out.println("After the method: "+myApple.color);
   }
   //The method argument is a reference type (class)
   public static void changeAppleColor(Apple apple){
     System.out.println("apple: "+apple);//display memory address
     apple.color = "green";
   }
}
```

The two `println()` statements let us view the the memory addresses so we can check the objects that different variables are pointing to (i.e. whether they point at the same memory address and therefore reference the same object).

Compile and run the program. You should observed the following:

 1. `apple`’s memory address is the same as the `myApple`’s. This is because the method argument `apple` has a copy of the `myApple`’s "value" – the memory address for any reference data type.

 2. The `myApply`’s colour has been changed to `"green"`. Whenever more than one variable (here `apple` and `myApple`) points to the same memory address, you may understand it as one object but with mutliple names or *handles*. In this case when we make a change to `apple` we can see the change when accessing the object via the `myApple` handle.

Make sure you understand the reasons for the output. If you'd like to ask any questions, ask a teaching assistant.

To enhance your understanding of *passing by value* of reference data types, let’s experiment on the code above.

**TASK 2.1** 

Add two lines to the bottom of the the `changeAppleColor` method as follows:

```java
     public static void changeAppleColor(Apple apple){
       System.out.println("apple: "+apple);//display memory address
       apple.color = "green";
       apple = new Apple("blue");
       System.out.println("apple: "+apple);//display memory address
}
```

First think about what the output of `myApple`'s colour after calling this method. Then run the code to verify your answer.

**TASK 2.2**

Now change the order of the statements as follows.

```java
public static void changeAppleColor(Apple apple){
    System.out.println("apple: "+apple);//display memory address
    apple = new Apple("blue");
    System.out.println("apple: "+apple);//display memory address
    apple.color = "green";
}
```

Again, first think about what the output of `myApple`’s colour after calling this method. Then run the code to verify your answer.

You may find it useful to keep in mind that whenever `new` is used to create an object the compiler will allocate a new memory block for it. Therefore, `apple = new Apple("blue");` creates a new memory block, that `apple` now points to. Any changes for this new memory block will not affect `myApple` any more.

**IMPORTANT** 

As this workshop is assessed please ensure that:


 i. you leave the `PassByValueApp` code in the state it should be after completion of **TASK 2.2**.

 ii. you successfully commit and push your `PassByValueApp.java` file to the GitHub classroom repository where they can be accessed by the teaching staff. 

### `StringFormatApp.java`: String formatting

For printing on the screen, Java offers the `System.out.printf()` method
which allows control of how literals can be displayed as part of the program output.
(this function also can be called via `System.out.format()`)

The first input to the `printf` method is a string with placeholders that indicate where and how
data fields should be inserted, followed by additional arguments containing the data to be inserted.

To explore the `printf` method we can make use of the `jshell` tool. This is a `REPL` (Read-Eval-Print Loop) as can be used in Python.

**TASK 3.1**

Launch `jshell` in the CodeSpace terminal panel:

```
jshell
```

You should see a message like:

```
|  Welcome to JShell -- Version 21.0.5
|  For an introduction type: /help intro
```

Consider the line of java below:

```java
System.out.printf("This is %s code!%n","java");
```

In this code the `%` is used to denote a placeholder field along with a single character that denotes the *format specifier* which defines the fields data type. 

Here `%s` is used as the placeholder is marking the place at which a string will be inserted.

Try copy and pasting the above code at the `jshell` prompt. You should see something like:

```
jshell> System.out.printf("This is %s code!%n","java");
   ...> 
This is java code!
$1 ==> java.io.PrintStream@34b7bfc0
```

In addition to showing us the code output, the `jshell` terminal includes additional output indicating the objects created. 

Here `$1` refers to line 1 of standard output, and `java.io.PrintStream@34b7bfc0` to the object that was created in memory by the `System.out.format()` command.

Let's now try altering the format used. Rerun the above command but change the placeholder to `%S` (upper case `S`), and view how the output changes. 

Note: You can access previous commands in the terminal and `jshell` by using the up/down arrows. 

The following define some common character codes that can be used:

|specifiers:| use: |
|---------|----------|
| `%d`      | to insert an integer number |
| `%f`      | to insert a floating point number |
| `%s`      | to insert a string of characters |
| `%c`      | to insert a single character |
| `%n`      | to insert a new line |
| `%%`      | to display the percent-sign `%` |


In between the `%` and *specifiers* additional *flags* and formatting commands can be used to control how data is displayed. 

For example we can add spacing by specifying the field's width (useful to align values in mutliline output):

```java
// uses 10 characters-width when displaying the field
System.out.printf("This is %10s code!%n","java");
```

```java
// 10 character width, with left alignment
System.out.printf("This is %-10s code!%n","java");
```

We can also direct particular data into particular placeholders, e.g. adding `2$` into `%2$s` means insert the second value provided into this field:

```java
String a = "apples";
String b = "bananas";
String c = "carrots";
System.out.printf("You can eat %3$s, %2$s and %1$s.%n", a, b, c);
```

Additional flags and specifiers exist for numbers. The following examples display different options on an integer value;

```java
int x = 123456;
int y = 3;
System.out.printf("%d  %d%n", x, y);
```

```java
// use 8-characters for field and pad with zeros
System.out.printf("%08d  %08d%n", x, y);
```

```java
// uses , for large values
System.out.printf("%,d  %,d%n", x, y);
```

In addition floating point numbers can be displayed with a given precision, and in decimal or scientific formats.

```java
int a = 10;
double pi = 3.1415926535;
double result = a + 3.1415926535;
System.out.printf("%d + pi = %f%n", a, result);
```

```java
// display to 8 decimal places (default is 8)
System.out.printf("%d + pi = %.8f%n", a, result);
```

```java
// print in float format with 2 decimal places
System.out.printf("%d + pi = %.2f%n", a, result);
```

```java
// print in scientific format with 3 decimal places
System.out.printf("%d + pi = %.3e%n", a, result);
```

```java
// print in general format with 4 significant figures
// (general will use scientific format when appropriate)
System.out.printf("%d + pi = %.4g%n", a, result);
```

Some tutorials on the `printf` / `format` method can be found here:

 - https://www.w3schools.com/java/ref_output_printf.asp

 - https://docs.oracle.com/javase/tutorial/java/data/numberformat.html

Note we can also use the `String.format()` method to create a string without printing it. For example: 

```java
String s = String.format("%.1f", 1.234); // s = "1.2"
System.out.println(s)
```

Strings are a type of java object. This means operators like `==` work differently to the way we might use them on `int` or `double` variables. To see this run the following code in `jshell`:

```java
String s1 = new String("book");
String s2 = "book";
String s3 = "books";
System.out.println("s1==s2:"+(s1==s2));
System.out.println("s2==s3:"+(s2==s3));
```

You may be surprised that `s1` and `s2` are not "equal". This is because for objects the `==` operator checks if the variables reference the same object in memory, and the `new` operator always places the object it creates in a new memory location.

Now rerun the code but change `s3` to store `"book"`.

```java
String s1 = new String("book");
String s2 = "book";
String s3 = "book";
System.out.println("s1==s2:"+(s1==s2));
System.out.println("s2==s3:"+(s2==s3));
```

You may be surprised that now `s2` and `s3` are `"equal"` and reference the same object in memory. This is because java tries to optimise the code by intern identifcal data values in memory (where the stored data cannot be changed).

Next try the following in `jshell`:

```java
String s = "Java 8.0";
s.replace('8','9');
System.out.println("s: "+s);
```

You will find that `s` is unchanged. Recall strings cannot be editted once created.

To carry out and use the result of the `.replace()` method we must allocate the result to a new string:

```java
String s = "Java 8.0";
String s_new = s.replace('8','9');
System.out.println("s: "+s);
System.out.println("s_new: "+s_new);
```

When you are finished experimenting with strings  you can quit `jshell` by typing:

```
/exit
```

**TASK 3.2**

Write a program `StringFormatApp.java` that will take three command arguments: your name, age and height in m. 

These will be a string, integer and floating point number respectively.

i.e. The command to execute the program might be as follows:

```bash
java StringFormatApp Alice 21 1.64
```

Your program should display this information using `System.out.printf()` with following format:

```
name: Alice Age: 21 Height: 1.64m
```

**Hint**

The command line inputs can be accessed via `args[0]`,   `args[1]`, `args[2]`.

The `args` array stores the data in `string` format. To load in and convert the numerical data to `int` or `float` or `double`, we can use code that calls the primitive wrapper classes’s methods e.g.

```java
int age = Integer.parseInt(args[ ... ]); // or: Integer.valueOf(..)
float height = Float.parseFloat(args[ ... ]); //or: Float.valueOf(..)
```

Make the following changes to the output format (so we could collate the lines of output from all students and the data would be aligned):

 - the name field is 20 characters wide (left justified)

 - the age field is 3 characters wide (right justified)
 
 - the height field is 4 characters wide and always given to 2 decimal places (right justified)

(see the diagram below for format and how the output line will look for different input data) 

```
fields and widths:
          
      _________20_________      _3_         __4_

name: Alice                Age:  21 Height: 1.64m
name: Jonathan             Age: 102 Height: 1.75m
name: Zebedee              Age:   7 Height: 0.82m
```

Note how the fixed field widths mean that when collated the output can be combined so the data is aligned in columns (although the current program is to collect one students data only, in general we might write programs to deal with and display many records).

**TASK 3.3**

In space due to the absence of gravity your vertebra expand such that your height increases by 2.3%. 

Add code to your program to calculate your height in space in centimetres and display the result by printing a second line of output with the following format:

```
My space height would be ___cm
```

Where your space height in centimetres is inserted to 1 decimal place.

**TASK 3.4**

On Mars the orbital period is 687 Earth days. This means if you lived on Mars your age in Martian years would be younger than your age on Earth by a factor of 1.88.

Add code to your program to calculate your age in Martian years (divide Earth age by 1.88). 

Display the result as a third line of output in the following format:

```
On Mars I would be approximately __ years old.
```

Where your Martian age is inserted to the nearest whole number.

**IMPORTANT** 

As this workshop is assessed please ensure that:

 i. your `StringFormatApp` program produces output *exactly* in line with the format above, with 3 lines of output. 

 ii. you successfully commit and push your `StringFormatApp.java` file to the GitHub classroom repository where they can be accessed by the teaching staff. 

 ## Part B. Books and authors

 ### `Author.java`

 A class called `Author` (as shown in the UML class diagram below) is designed to model a book’s author. It shows the structure of the class including attributes and methods. In the diagram `+` means public members and `−` means private members.

 We will study UML diagrams later in the module, and if you have any questions you can ask one of the module teaching staff to explain anything you do not understand.

<img src="./Author_class_uml.png"> </img>

It contains:

- Three private instance variables: `name` (String), `email` (String), and `gender`
  (char of either `m`, `f`, or `u` for unspecified);

- One constructor to initialize the `name`, `email` and `gender` with the given
  values;

- public getters/setters: `getName()`, `getEmail()`, `setEmail()`, and `getGender()`; 
  (There are no setters for `name` and `gender`, as these attributes cannot be changed once the author object is created.)

- A toString() method that returns `"Author[name=?,email=?,gender=?]"` e.g. `"Author[name=Tan Ah Teck,email=ahTeck@somewhere.com,gender=m]"`.

**TASK 4.1**

Write the `Author` class. 

In the file `AuthorApp.java` use the code below within the `main` function so that it will test all the public `Author` methods when it is compiled and run:

```java
Author osman = new Author("Richard Osman", "noone@nowhere.com", 'm');

System.out.println(osman); // Test toString()
osman.setEmail("osman@murderclub.com"); // Test setter
System.out.println("name is: " + osman.getName()); // Test getter
System.out.println("email is: " + osman.getEmail()); // Test getter
System.out.println("gender is: " + osman.getGender()); // Test getter
```

 ### `Book.java`

The Book class is designed (as shown in the UML class diagram below) to
model a book written by multiple authors. In this design, once a Book instance
is created, you cannot add or remove author, as the authors is a fix-length array.

<img src="./Book_class_uml.png"> </img>


Note in the diagram, the methods and constructors of the Author class are ommitted but refer to the existing Author class we created. 

The diamond shape between the two classes means an aggregation relationship, i.e., the Book class owns references to objects of the Author class.

**TASK 4.2**

Write the `Book` class (which uses the `Author` class written earlier). 

In the same way you wrote a `AuthorApp.java` program to test the public methods of the `Author` app, 
create a file `BookApp.java` to test the public methods you have constructed for the `Book` class.

**Hint**

Note that you have to construct an array of `Author` instances before you can construct an instance of `Book`, e.g.

```java
 // Declare and allocate an array of Authors
Author[] authors = new Author[2];
authors[0] = new Author("Pip Jones", "pjones@java.org", 'u');
authors[1] = new Author("Bessie Carter", "b.carter@java.org", 'f');
// Declare and allocate a Book instance
Book javaDummy = new Book("Java for Dummies", authors, 19.99, 99);
System.out.println(javaDummy); // toString()
```

When displaying the author details for a book you need to loop over the author array, and for example build up a string from each entry plus a `comma` to separate them. 

If you get stuck you can expand the code example below for a hint on how to do this.

<details>
  <summary>code example</summary>
The example code below provides a possible code structure that can be adapted. It takes an array of values e.g. 2,4,6,8 and produces a string like `"2-4-6-8"`: 

```
int[] values = {2, 4, 6, 8, 10};
String valuesString="";
boolean first=true;
for (int i = 0; i < values.length; i++) {
  if (!first) valuesString += "-";
  valuesString += String.valueOf(values[i]);
  first=false;
}
System.out.println(valuesString);
```

</details>

### `BookShopApp.java`

**TASK 4.3**

Create a program `BookShopApp.java` with a main function that will complete the following exercises.

First create a book array which contains the following books, using the `ArrayList` so that we may dynamically add and remove books from the list.

You can leave the author email addresses empty, and the gender codes as `'u'` i.e. unspecified.

| Name  | Authors  | Price GBP | Stock Level | 
|-------------------------|-------------------------------|------:|---:|
| Data Mining Handbook    | Robert Nisbet                 | 27.95 | 10 |
| Mastering COBOL         | Roger Hutty                   |  4.95 | 10 |
| Intro to COBOL          | Paul Murrill                  |  7.35 |  4 |
| Making Software         | Andy Oram                     | 35.00 |  5 |
| OO Design Using Java    | James Nino, Frederick Hosch   | 30.00 |  6 |
| Objects First with Java | David Barnes, Michael Kolling | 29.50 |  4 |

**\* CORRECTION:** originally book 3 was `Introduction to Cobol` but for consistency this has been amended to `Intro to COBOL`. Please update your submission accordingly. 

**Hint**

```java
// create the stocklist as an ArrayList to store the books
ArrayList<Book> stocklist = new ArrayList<>();

// to add book 1
// first create necessary 'authors' array
Author [] authors1 = {new Author("Robert Nisbet", "", 'u')};

// we can then create book1
Book book1 = new Book("Data Mining Handbook", authors1, 27.95, 10);

// finally add book 1 into the ArrayList
stocklist.add(book1);

// create more books, and add them into the array
...
```

**NEW** (This line was added on 12th Feb to ensure we test the `Book.toString()` method).

When you have added code to enter all the books run the following code to loop over the items and print each book.

```
for (Book b : stocklist) {
  System.out.println(b);
}
```

Next we will work to display the stocklist in a more readable "table" format. 

Leave the above code in your file, but add extra code below. This should loop over the books in the `stocklist` and print information about each book to recreate the table rows as below (using  3 digits, zero-padded to store the stock level quantity), using `|` to delimit the columns.

Note the table uses field sizes of 23, 28, 6 and 3 and do not need to be calculated.

```
| Data Mining Handbook    | Robert Nisbet                 |  27.95 | 010 |
| Mastering COBOL         | Roger Hutty                   |   4.95 | 010 |
| Intro to COBOL          | Paul Murrill                  |   7.35 | 004 |
| Making Software         | Andy Oram                     |  35.00 | 005 |
| OO Design Using Java    | James Nino, Frederick Hosch   |  30.00 | 006 |
| Objects First with Java | David Barnes, Michael Kolling |  29.50 | 004 |
```

**CHALLENGE** When you finish the other tasks come back and try to make this table dynamically adapt its column widths to accomodate the book title and author columns so they would fit the content exactly i.e. width would be the length of the longest entry plus a space at each side. (optional - not for credit).

**TASK 4.4**

Suppose a customer wants to check if a book is in stock, and if so purchase it. 

Add the following line of code after displaying the `ArrayList` as above to set up a string variable containing the search terms given by the customer.

```java
String searchFor = "making software";
System.out.println("Search for term(s) '" + searchFor + "' in title...");
```

**\* CORRECTIONS:** 

 - In the code above I made a minor consistency change to `Search for term(s):` where it originally it stated `title`.
 - I have updated the section below to remove the requirement to print the book details (as we can see the update when we reprint the table). 

Add code that searches the array for books with a title that matches the search string. If the search term is found it should <s>print the details of the book (using the `toString` method), and</s> decrease the stock quantity of that book by 1.

Recall that for comparing string objects we should use the `equals()` method rather than equality operator `==`.

Ensure that your code can match the title in a case insensitive way. (Hint: make use of a String method like `.toLowerCase()`). 

To verify the stock levels have changed display the updated rows of the `stocklist` as above by reusing your existing code to display `stocklist`.

**TASK 4.5**

Suppose the book shop owner wants to be able to identify and remove all books with a given programming language in the title. 

Use the following code to define a variable storing the term that will be used for this process:

```java
String removeAll = "cobol";
System.out.println("Removing all books with term '" + removeAll + "' in title..."); 
```
**\* CORRECTION:** The section below was updated to remove the requirement to print the rows for removal. 

Next add code that searches the stock level array for books containing this term in the title. It should <s>print the stock level rows for the books identified (so they can be removed) and</s> delete these items from the stock list. 

Hint. In addition to the `.equals()` method the `String` class has a `.contains()` method which can be used to determine if a string contains a given substring e.g.

```java
// try in jshell
String pets="cat dog mouse";
pets.contains("dog"); // true
pets.contains("lion"); // false
```

After this your code should summarise the action taken by printing the line:

```
"Removed _ books"
```

where the blank is filled with the number of books removed from the stocklist (i.e. for the example this will be `2` because two books with cobol in the title should be removed.)

Demonstrate your code has been successful by displaying the updated stocklist array.

**IMPORTANT** 

As this workshop is assessed please ensure that:

 i. the files `Author.java`, `AuthorApp.java`, `Book.java`, `BookApp.java` and `BookShopApp.java` programs have been written in exact accordance with the instructions and produce output *exactly* in line with the format above.

 ii. you successfully commit and push these files to the GitHub classroom repository where they can be accessed by the teaching staff. 
