# Workshop Week 07: Inheritance

##### UPDATE 26th FEB

You can add a test script to your repository by running the following command in your CodeSpace terminal:

```bash
curl https://raw.githubusercontent.com/My-UofE/ECM1410-Workshop-07-Instructions/refs/heads/main/test_workshop7_v1.sh -o ./tests/test_workshop7_v1.sh
```

Once present you can run the test from your working directory using the terminal command:

```bash
bash ./tests/test_workshop7_v1.sh
```

## `Circle` and `Cylinder` 

This workshop covers the concept of inheritance. The first example includes two classes: a 2D `Circle` class (defined with `radius` and `color` attributes) and a 3D `Cylinder` class (with `radius` `height` and `color`). 

Note. This example was adapted from the page: https://www.ntu.edu.sg/home/ehchua/programming/java/J3b_OOPInheritancePolymorphism.html available via Internet Archive snapshots.

To efficiently code a `Cylinder` class we might set up the class to extend an already existing `Circle` class so we can make use of the attributes and methods for storing the attributes of the circular cylinder base.

<img src="./OOP_Circle_Cylinder.png"> </img>

The `Circle` class is already created for you in file `Circle.java` and an incompleted version of `Cylinder.java` is also present.

Open `Cylinder.java` and complete the tasks 1-5 as described in the comments file to complete the class definition.

<details>
  <summary><strong>Hint.</strong> (expand to view)</summary><br>

  An example of the 3-arg `Cylinder` constructor can be seen below. Note how we use the appropriate `super()` method to call the `Circle` constructor.

  To complete the task you will also need to complete the no-arg, 1-arg and 2-arg constructors.

```java
// 3-arg constructor
public Cylinder(double height, double radius, String color) {
    super(radius, color); // invoke superclass’ constructor
    this.height = height;
}
```
</details><br>




When all 5 tasks are completed you should be able to compile and run `TestCylinder1.java` to test your classes.

**NOTE** It is important to note that a subclass is not a subset of a superclass. In fact a subclass is a *superset* of the superclass. This is because a subclass inherits all the variables and methods of the superclass, and in addition extends the superclass by providing more variables and methods.

### Method overriding

The `Circle` class contains methods for calculing area but we can also calculate a cylinder’s surface area, which is different from a circle’s area. If we want our `Cylinder` object to provide its surface area we need to specify we with to override the `getArea()` in the `Cylinder` class. The formula for calcuating a cylinder’s area A is

$$\text{A = 2 $\times $ base area $+$ circumference $\times$ height}$$

where 

$$\text{base area = $\pi r^{2}~~~~~~$ and $~~~~~$ circumference = $2\pi r$} $$


In the `Cylinder` class override the `getArea()` method i.e.  

```java
   // add following in to Cylinder.java
   @Override
   public double getArea() {
   ...
   }
```
<details>
  <summary><strong>Hint.</strong> (expand to view)</summary><br>
To be able to find the base of the cylinder we can use code like the following access methods from the superclass from within the subclass definition:

```java
double baseArea = super.getArea();
```

</details><br>



Compile and run the code.

To check the code add the following at the end of `TestCylinder1.java`, and complete the lines so they call the appropriate class or superclass methods on Cylinder `cy1`

```java
double surfaceArea = ...
double baseArea = ...
System.out.printf("Surface Area: %.2f, Base Area: %.2f\n", surfaceArea, baseArea);
```

You might expect that the following would allow you to upcast the `Cylinder` and call the superclass `getArea()` method. 

```java
double baseArea = ((Circle)cy1).getArea();
```

However although this command will compile, when the code runs it will be the `Cylinder.getArea()` that is called.

This is for security considerations e.g. see the discussion at: 

https://stackoverflow.com/questions/6896504/java-inheritance-calling-superclass-method

This is an example of dynamic or late binding, whereby the actual method that runs will be determined by the object class at runtime, and not
what it may be identified as at the time of compilation (early or static binding).

Java only allows us to access the superclass methods within the subclass definition. i.e. we can add a method
`getBaseArea()` within the `Cylinder` class that can call the superclass `Circle.getArea()` method using `super.getArea()` 

Compile and run the `TestCylinder1`.

You should notice (if you did not already fix it!) that in addition to the area changing the calculated volume (which originally should call the `Circle` `getArea()` method) now is incorrect (because it picks up the `Cylinder` `getArea()` which returns surface area and not the base area).

Correct the code in the `getVolume()` method so that it calls the `Circle` `getArea()` method rather than the overriden method.


### Exploring inheritance

Now let’s do some changes on the code to enhance your understanding of a few concepts in OOP inheritance.


#### Casting, Polymophism

Compile and run the code in `TestCylinder2.java`.

Now  change the reference type of `cy2` in `TestCylinder2.java` as follows:

```java
Circle cy2 = new Cylinder(5.0, 2.0);
```

This is an example of upcasting where we cast an object reference as the superclass.

Recompile the code and see what happens.

You will see compiling errors, because the reference type of the `cy2` is the superclass `Circle`, while there is no `getHeight()` and `getVolume()` in the `Circle` class. 

If we really wanted to query the height and volume of `cy2` we can use downcasting.

To do this make the following edit to the code:

```java
double h = ((Cylinder)cy2).getHeight();
double v = ((Cylinder)cy2).getVolume();
```

**Note** Alternatively we could define the methods for `getHeight()` `getVolume()` in the superclass with dummy implementations, since it does not make sense for a circle to have `getHeight()` and `getVolume()` methods.



#### Methods and binding

When we override instance methods, java will use late binding, this means that the program will use the appropriate method at runtime based on the type of an object.

Static methods can not overridden and use early binding. In the example below we will see that
this means that the program will use the static method of the superclass even if it is redefined in a subclass.

Let's add additional methods to print the class info. We will make both instance methods and static methods: 

In `Circle.java`

```java
// instance method
public void printClassInfo(){
  System.out.println("It is a Circle class");
}

// static method
public static void printClassInfoStatic(){
  System.out.println("It is a Circle class");
}
```


In `Cylinder.java`

```java
// instance method
public void printClassInfo(){
  System.out.println("It is a Cylinder class");
}

// static method
public static void printClassInfoStatic(){
  System.out.println("It is a Cylinder class");
}
```
In the `TestCylinder2.java`, add the following to call the method at the end of the file:

```java    
    System.out.println("\nrunning\nCircle c3 = new Circle();\nc3.printClassInfo();");
    Circle c3 = new Circle();
    c3.printClassInfo();
    
    System.out.println("\nrunning\nCylinder cy4 = new Cylinder();\ncy4.printClassInfo();");
    Cylinder cy4 = new Cylinder();
    cy4.printClassInfo();
    
    System.out.println("\nrunning\nCircle cy5 = new Cylinder();\ncy5.printClassInfo();");
    Circle cy5 = new Cylinder(); // upcasting
    cy5.printClassInfo();
    
    // this will give a compiler warning; but can compile and run
    System.out.println("\nrunning\ncy4.printClassInfoStatic();");
    cy4.printClassInfoStatic();

    // this will give a compiler warning; but can compile and run
    System.out.println("\nrunning\ncy5.printClassInfoStatic();");
    cy5.printClassInfoStatic();
```

 Explore the results, and ask if you do not understand one of the results.
<details>
  <summary><strong>Answer.</strong> (expand to view)</summary><br>

Static methods are early binded, i.e. the determination of which method will be called is determined at compile time, and here as we cast cy1 as `Circle` the compiler links the `Circle.printClassInfoStatic()` method.

This differs from instance methods which can use dynamic binding so that an instance of a subclass, where the determination of which method will be called is determined at runtime, and even if we cast `Cylinder` cy1 as `Circle` the compiler will link the objects overidden method i.e. in this case call the `Cylinder.getArea()` method.

Unlike instance methods **in an inherited class  the static methods cannot be overriden**.

(If you want to see what happens try to add the annotation `@Override` before the `Cylinder` `printClassInfoStatic()` method, see what the compiler says).

</details><br>

#### Access modifier
Currently both `getArea()` methods in the `Circle` superclass and `Cylinder` subclass are set to have `public` accessibility. 

What if change the subclass’s method to a narrower access modifier (such as `protected`, `default` and `private`)? 

Try it yourself to see what the compiler says.

(After experimenting change the `Cylinder` `getArea()` method back to be `public`)

<details>
  <summary><strong>Answer.</strong> (expand to view)</summary><br>
You should find the access modifier for an overriding method in the subclass can allow the same or more, but not less, access than the overridden method.
</details>


#### Constructors

There is another detail about the subclass constructors that is not covered in the lectures.

If no `super()` constructor is called in the subclass’s constructor, the compiler automatically insert a `super()` statement to invoke the no-arg constructor of its superclass.

Try it yourself by remove the `super()` from the no-arg constructor in the `Cylinder` class, and verify the code still compiles.

```
    public Cylinder(...) {
       super(); //A no-arg constructor could be omitted
       height = 1.0; // default value for height
}
```

## Abstract classes

The example of the abstract `Shape` class and two of its subclasses (`Triangle` and `Rectangle`) have been defined in the lecture. 

Let’s give a complete implementation of all three classes to enhance your understanding about abstract class and abstract methods.

**TASK 2.1 Create the abstract `Shape` class**

Create an abstract class Shape, as shown in the figure which contains two abstract methods, `area()` and `perimeter()`.

<img src="./OOP_Polymorphism_Shape.png"> </img>

These cannot yet be coded since they depend on what kind of shape is being created.(i.e. in this case which subclass).

**TASK 2.2 Create the two concrete subclasses**

To use the abstract `Shape` class, you need derive subclasses (e.g., `Rectangle` and `Triangle`) from it. 

In the derived subclasses, you must provide implementation to all the abstract methods (`area()` and `perimeter()`). 

All the attributes and methods for the three classes are shown in the following figure.

**Note**

The area of a triangle given the lengths of each side ($a$ $b$ and $c$)can be found using: 

$$\text{area} = \sqrt{s(s-a)(s-b)(s-c)}$$

where:

$$s = \frac{a + b + c}{2}$$

**TASK 2.3 Overriding `toString()` and `equals()`**

In the two subclasses, the two methods (`toString()` and `equals()`) are derived from the grand-parent class `Object`. It is a good practice to always add the `@Override` annotation right before the overriding methods (e.g. the compiler will detect if if you make a typo and your method does not match that in the superclass)

##### Overriding `toString()`
The `toString()` method should print out the rectangle/triangle’s basic information, such as side lengths, color, area and perimeter in the following formats:

```
Rectangle[height=X.XX,width=X.XX,color=X,area=X.XX,perimeter=X.XX]
```

```
Triangle[a=X.XX,b=X.XX,c=X.XX,color=X,area=X.XX,perimeter=X.XX]
```

##### Overriding `equals()`
The `equals()` method returns `true` if the other rectangle/triangle has exactly the same side lengths and colors, otherwise returns `false`. 

If the compared two shapes are not from the same shape type, always return `false`.

Hints

The following is the `equals()` method from the `Integer` class. You may reference it to write your `equals()` methods in the two subclasses.

 Before comparing, always check the obj’s type using the `instanceof` operator.

 ```java
    @Override
    public boolean equals(Object obj) {
    if (obj instanceof Integer) {
      return value == ((Integer)obj).intValue();
    }
    return false;
}
```

To test your code create and run the test file `ShapeApp.java` containing the following:

```java 
public class ShapeApp {
   public static void main(String[] args) {
     //They are all declared as shapes,
     //but instantiated with different subclasses’ objects
     Shape s1,s2,s3,s4;
     s1 = new Rectangle(3.0,4.0,"green");
     System.out.println(s1.toString());
     s2 = new Rectangle(3.0,4.0,"green");
     s3 = new Triangle(3.0,4.0,5.0,"green");
     System.out.println(s3);
     //compare the shapes
     System.out.println(s1.equals(s2));
     System.out.println(s3.equals(s2));
} 
}
```

Compile all the files, and run them. Verify that the output areas and perimeters are correct for each shape.

#### Explorations

**1.** Check what happends when you comment out the two overriding methods `toString()` and `equals()` in your Rectangle class. 

<details>
  <summary><strong>Answer.</strong> (expand to view)</summary><br>
The code still compiles. 

This is because the default method implementations for `equals()` and `toString()` exist
in the  `Object` which all java objects inherit, and your rectangle class will make use of those.
</details><br>

**2.** Add one more shape as follows and recompile the code - what do you find?

```
Shape s5 = new Shape("black");
```

<details>
  <summary><strong>Answer.</strong> (expand to view)</summary><br>
The code will not compile. This is because `Shape` is an abstract class. 
Abstract classes are not allowed to be instantiated, since there are 
methods which have no implementation.
</details><br>

*Once you have explored the results, reset your code
 (uncomment the `Rectangle` methods, and remove the line that attempts
  to create the `Shape s5` object so that your file will compile).*



