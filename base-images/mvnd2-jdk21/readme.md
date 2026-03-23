# Maven3编译对照表

| major version | Java版本  |
|---------------|---------|
| 65            | Java 21 |
| 61            | Java 17 |
| 60            | Java 16 |
| 59            | Java 15 |
| 58            | Java 14 |
| 57            | Java 13 |
| 56            | Java 12 |
| 55            | Java 11 |
| 54            | Java 10 |
| 53            | Java 9  |
| 52            | Java 8  |
| 51            | Java 7  |
| 50            | Java 6  |

# 测试项目

```shell
git clone https://gitee.com/odboy-tianjun/cutejava.git

cd cutejava
```

### 对照组1：jdk21 & maven3编译java11应用，指定编译版本8（由于使用了java11的特性，编译失败）

> vi pom.xml

```xml

<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
    <maven.compiler.encoding>UTF-8</maven.compiler.encoding>
    <java.version>8</java.version>
</properties>
```

```shell
mvn clean package -DskipTests -Dfile.encoding=UTF-8
```

### 对照组2：jdk21 & maven3编译java11应用，指定编译版本11（正确输出java11字节码）

> vi pom.xml

```xml

<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
    <maven.compiler.encoding>UTF-8</maven.compiler.encoding>
    <java.version>11</java.version>
</properties>
```

```shell
mvn clean package -DskipTests -Dfile.encoding=UTF-8

javap -v cutejava-starter/target/classes/cn/odboy/AppRun.class | grep "major"

major version: 55
```

### 对照组3：jdk21 & maven3编译java11应用，指定编译版本17（正确输出java17字节码）

> vi pom.xml

```xml

<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
    <maven.compiler.encoding>UTF-8</maven.compiler.encoding>
    <java.version>17</java.version>
</properties>
```

```shell
mvn clean package -DskipTests -Dfile.encoding=UTF-8

javap -v cutejava-starter/target/classes/cn/odboy/AppRun.class | grep "major"

major version: 61
```

### 对照组2：jdk21 & maven3编译java11应用，指定编译版本21（正确输出java21字节码）

> vi pom.xml

```xml

<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
    <maven.compiler.encoding>UTF-8</maven.compiler.encoding>
    <java.version>21</java.version>
</properties>
```

```shell
mvn clean package -DskipTests -Dfile.encoding=UTF-8

javap -v cutejava-starter/target/classes/cn/odboy/AppRun.class | grep "major"

major version: 65
```