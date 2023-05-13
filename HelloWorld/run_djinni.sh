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
