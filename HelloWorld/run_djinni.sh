#! /usr/bin/env bash

# base config
base_dir=$(cd $(dirname 0) && pwd)

# idl config
# CONFIG start---
idl_folder="idl"
idl_file="HelloWorld.djinni"
# CONFIG end---
djinni_file="$base_dir/$idl_folder/$idl_file"

# cpp config
cpp_out="$base_dir/generated/cpp"
namespace="HelloDjinni"

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
