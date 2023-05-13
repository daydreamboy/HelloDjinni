# HelloDjinni

[TOC]

## 1、介绍Djinni

Djinni目前有两个github版本

* [Dropbox版本](https://github.com/dropbox/djinni)
* [Snapchat版本](https://github.com/Snapchat/djinni)。该版本是继承自Dropbox版本，增加使用Bazel工具

由于对Bazel不了解，并简化一些依赖问题，本文采用原始版本来使用Djinni。

> 这里有个官方网站[^1]用于介绍Djinni，本文优先参考这个网站的内容。

在官方网站[^1]上，定义Djinni是一个简单IDL，如下

> The Djinni [**Interface Definition Language**](https://djinni.xlcpp.dev/djinni-generator/idl/) provides a simple, yet powerful way to design your interfaces.

可以理解为Djinni是一门IDL语言，使用配套工具生成平台(Android/iOS等)特性的接口，方便调用C++的实现。

官方文档[^1]描述，如下

> With Djinni you can implement interfaces in any target language and call the implementation from C++!



官方文档[^1]使用下面这个图，比较形象描述Djinni用于桥接C++到各个平台的语言。

<img src="images/01_Djinni_bridge_cpp.svg" style="float:left;" />



### (1) djinni命令行工具

使用[Dropbox版本](https://github.com/dropbox/djinni)的git源码，在src文件下找到run文件。这个可执行文件是djinni命令行工具。

查看帮助信息，如下

```shell
$ src/run --help
Already up to date: Djinni
Usage: djinni [options]

  --help
...
```

说明

> 1. 首次执行命令会下载依赖库，编译scala源码
>
> 2. 为了方便在其他地方使用，可以设置run的别名，并将所在文件夹导入到环境变量PATH中
>
>    ```shell
>    $ cd src    
>    $ ln -s run djinni
>    ```
>
>    这里以使用zsh为例，添加下行代码
>
>    ```shell
>    export PATH="$PATH:$HOME/GitHub_Projects/HelloDjinni/djinni/src"
>    ```
>
>    在新开Terminal中，执行`djinni --help`
>
>    ```shell
>    $ djinni --help
>    Already up to date: Djinni
>    Usage: djinni [options]
>    ...
>    ```
>
> 3. run命令实际是bash脚本

执行`src/run --help`命令，输出的帮助信息，大致分为下面几个部分

* 输出java接口
* 输出C++接口
* 输出JNI接口
* 输出Objective-C接口
* 输出Objective-C++接口
* 输出yaml接口



#### a. 输出java接口

输出java接口的选项，如下

```shell
  --java-out <out-folder>
        The output for the Java files (Generator disabled if unspecified).
  --java-package ...
        The package name to use for generated Java classes.
  --java-class-access-modifier <public/package>
        The access modifier to use for generated Java classes (default: public).
  --java-cpp-exception <exception-class>
        The type for translated C++ exceptions in Java (default: java.lang.RuntimeException that is not checked)
  --java-annotation <annotation-class>
        Java annotation (@Foo) to place on all generated Java classes
  --java-generate-interfaces <true/false>
        Whether Java interfaces should be used instead of abstract classes where possible (default: false).
  --java-nullable-annotation <nullable-annotation-class>
        Java annotation (@Nullable) to place on all fields and return values that are optional
  --java-nonnull-annotation <nonnull-annotation-class>
        Java annotation (@Nonnull) to place on all fields and return values that are not optional
  --java-implement-android-os-parcelable <true/false>
        all generated java classes will implement the interface android.os.Parcelable
  --java-use-final-for-record <use-final-for-record>
        Whether generated Java classes for records should be marked 'final' (default: true). 
```



#### b. 输出C++接口

输出C++接口的选项，如下

```shell
  --cpp-out <out-folder>
        The output folder for C++ files (Generator disabled if unspecified).
  --cpp-header-out <out-folder>
        The output folder for C++ header files (default: the same as --cpp-out).
  --cpp-include-prefix <prefix>
        The prefix for #includes of header files from C++ files.
  --cpp-namespace ...
        The namespace name to use for generated C++ classes.
  --cpp-ext <ext>
        The filename extension for C++ files (default: "cpp").
  --hpp-ext <ext>
        The filename extension for C++ header files (default: "hpp").
  --cpp-optional-template <template>
        The template to use for optional values (default: "std::optional")
  --cpp-optional-header <header>
        The header to use for optional values (default: "<optional>")
  --cpp-enum-hash-workaround <true/false>
        Work around LWG-2148 by generating std::hash specializations for C++ enums (default: true)
  --cpp-nn-header <header>
        The header to use for non-nullable pointers
  --cpp-nn-type <header>
        The type to use for non-nullable pointers (as a substitute for std::shared_ptr)
  --cpp-nn-check-expression <header>
        The expression to use for building non-nullable pointers
  --cpp-use-wide-strings <true/false>
        Use wide strings in C++ code (default: false)
```



#### c. 输出JNI接口

输出JNI接口的选项，如下

```shell
  --jni-out <out-folder>
        The folder for the JNI C++ output files (Generator disabled if unspecified).
  --jni-header-out <out-folder>
        The folder for the JNI C++ header files (default: the same as --jni-out).
  --jni-include-prefix <prefix>
        The prefix for #includes of JNI header files from JNI C++ files.
  --jni-include-cpp-prefix <prefix>
        The prefix for #includes of the main header files from JNI C++ files.
  --jni-namespace ...
        The namespace name to use for generated JNI C++ classes.
  --jni-base-lib-include-prefix ...
        The JNI base library's include path, relative to the JNI C++ classes.
```



#### d. 输出Objective-C接口

输出Objective-C接口的选项，如下

```shell
  --objc-out <out-folder>
        The output folder for Objective-C files (Generator disabled if unspecified).
  --objc-h-ext <ext>
        The filename extension for Objective-C[++] header files (default: "h")
  --objc-type-prefix <pre>
        The prefix for Objective-C data types (usually two or three letters)
  --objc-include-prefix <prefix>
        The prefix for #import of header files from Objective-C files.
  --objc-swift-bridging-header <name>
        The name of Objective-C Bridging Header used in XCode's Swift projects.
  --objc-closed-enums <true/false>
        All generated Objective-C enums will be NS_CLOSED_ENUM (default: false). 
```



#### e. 输出Objective-C++接口

输出Objective-C++接口的选项，如下

```shell
 --objcpp-out <out-folder>
        The output folder for private Objective-C++ files (Generator disabled if unspecified).
  --objcpp-ext <ext>
        The filename extension for Objective-C++ files (default: "mm")
  --objcpp-include-prefix <prefix>
        The prefix for #import of Objective-C++ header files from Objective-C++ files.
  --objcpp-include-cpp-prefix <prefix>
        The prefix for #include of the main C++ header files from Objective-C++ files.
  --objcpp-include-objc-prefix <prefix>
        The prefix for #import of the Objective-C header files from Objective-C++ files (default: the same as --objcpp-include-prefix)
  --cpp-extended-record-include-prefix <prefix>
        The prefix path for #include of the extended record C++ header (.hpp) files
  --objc-extended-record-include-prefix <prefix>
        The prefix path for #import of the extended record Objective-C header (.h) files
  --objcpp-namespace <prefix>
        The namespace name to use for generated Objective-C++ classes.
  --objc-base-lib-include-prefix ...
        The Objective-C++ base library's include path, relative to the Objective-C++ classes.
```



#### f. 输出yaml接口

输出yaml接口的选项，如下

```shell
  --yaml-out <out-folder>
        The output folder for YAML files (Generator disabled if unspecified).
  --yaml-out-file <out-file>
        If specified all types are merged into a single YAML file instead of generating one file per type (relative to --yaml-out).
  --yaml-prefix <pre>
        The prefix to add to type names stored in YAML files (default: "").
```





### (2) HelloWorld示例

这里的HelloWorld示例，参考这篇文章的步骤[^2]

* 准备好接口生成工具和编译工具
* 创建djinni文件
* 创建shell文件



#### a. 准备好接口生成工具和编译工具

接口生成工具，即djinni命令行工具，在上面已经在环境变量PATH中配置好djinni命令。

这里的编译工具采用GN，同样gn命令也在shell中已配置好。

```shell
$ which djinni
~/GitHub_Projects/HelloDjinni/djinni/src/djinni
$ which gn
~/GitHub_Projects/HelloGN/gn/out/gn
```







#### b. 创建djinni文件

以`HelloWorld.djinni`文件为例，如下

```c++
HelloWorld = interface +c {
    static create(): HelloWorld;
    fromCpp(): string
}
```

> 示例代码，来自https://djinni.xlcpp.dev/overview/



#### c. 创建shell文件

由于run命令的参数很多，需要配置各个平台的对应参数，一般会写driver脚本(驱动脚本)。

举个例子，如下

```bash
#! /usr/bin/env bash

# base config
djinni_file="HelloWorld.djinni"
base_dir=$(cd $(dirname 0) && pwd)

# cpp config
cpp_out="$base_dir/generated/cpp"
namespace="hellodjinni"

# java config
jni_out="$base_dir/generated/jni"
java_out="$base_dir/generated/java/com/mycompany/hellodjinni"
java_package="com.mycompany.hellodjinni"

# oc config
objc_out="$base_dir/generated/objc"
objc_prefix="WC"

djinni \
   --java-out $java_out \
   --java-package $java_package \
   --ident-java-field mFooBar \
   \
   --cpp-out $cpp_out \
   --cpp-namespace $namespace \
   \
   --jni-out $jni_out \
   --ident-jni-class NativeFooBar \
   --ident-jni-file NativeFooBar \
   \
   --objc-out $objc_out \
   --objc-type-prefix $objc_prefix \
   \
   --objcpp-out $objc_out \
   \
   --idl $djinni_file
```





#### b. 执行djinni，生成胶水头文件

```shell

```







## References

[^1]:https://djinni.xlcpp.dev/

[^2]:https://github.com/cpageler93/hello_djinni

