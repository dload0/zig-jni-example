# zig-jni-native-example
> A JNI native example in Zig. 

<p align='left'>
    <img src="https://img.shields.io/badge/Zig-%2523F7A41D.svg?style=for-the-badge&logo=zig&logoColor=white&color=yellow" />
    <img src="https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white" />
</p>

| Folder | Description |
| --- | --- |
| `native-loader/` | The Java program responsible for loading the native, and calling a function. |
| `root` | The Zig native code. |

## Build


Run the command in the project root to build the Zig native.

```
zig build
```

Run the command in the `native-loader` folder to build the Java program.

```
./gradlew build
```
