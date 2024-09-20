package dev.dload;

import java.nio.file.StandardCopyOption;
import java.nio.file.Files;
import java.io.InputStream;
import java.io.File;

public class NativeLoader {

    /**
     * Provide a native method bind.
     */
    public static native void bootstrap();

    /**
     * Entry point into the program.
     *
     * @param args any arguments passed.
     */
    public static void main(final String[] args) {

        System.out.println("[ + ] Loading native...");

        // Load the native.
        // * This wil call the `JNI_OnLoad` function if the library is loaded successfully.
        loadLibrary();

        // Call the bootstrap.
        // * This will call the `Java_dev_dload_NativeLoader_bootstrap` function.
        bootstrap();
    }

    /**
     * Load the native library.
     */
    public static void loadLibrary() {
        try {
            // Get the library as a resource.
            final String libName = "/zig_jni_native_example.dll";
            final File tempLib = File.createTempFile("zig_jni_native_example", ".dll");

            // Copy the resource to a temp file.
            try (final InputStream inputStream = NativeLoader.class.getResourceAsStream(libName)) {
                if (inputStream == null) {
                    throw new Exception("[ - ] Native library not found in resources: " + libName);
                }

                Files.copy(inputStream, tempLib.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            // Load the temp file.
            System.load(tempLib.getAbsolutePath());

            // Delete the temp file when the JVM exits.
            tempLib.deleteOnExit();
        } catch (final Exception exception) {
            exception.printStackTrace();

            // Exit.
            System.exit(1);
        }
    }
}
