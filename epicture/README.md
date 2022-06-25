# Epicture project

<h2>Getting started</h2>

<ul>
<li><a href="https://flutter.dev/docs/get-started/install"> Download and install Flutter </a></li>
<li><a href="https://developer.android.com/studio">Download and install Android Studio</a>
<li>Configure Android Studio
    <ul>
    <li>Start Android Studio
    </li>
    <li>Open Plugin preferences (File>Settings>Plugins)
    </li>
    <li>Select Marketplace, select the Flutter plugin and click install
    </li>
    </ul>
</li>
<li>Open project
    <ul>
    <li>Click on Open 
    </li>
    <li>Go to the directory, select epicture and click Ok</br>
    </ul>
</li>
<li> Configure the project
    <ul>
    <li>Go to (File > Settings > Appearances & Behaviour > System settings > Android SDK)
    </li>
    <li>Select Android 9.0 (Pie) and click on Apply</li>
    <li>Go to (File > Project Structure > Project Settings > Project) </li>
    <li>On project SDK select the SDK that you installed (API 28) and click on Apply</li>
    <li>On the Terminal : Go to the root of the directory and execute : <code>flutter pub get</code></li></br>
    </ul>
</li>
<li> Install emulator
    <ul>
    <li> Go to (Tools > AVD Manager) or the AVD Manager icon
    </li>
    <li>Click on Create Virtual Device</li>
    <li>Select a phone and click on Next</li>
    <li>Select Pie (API 28) and click on Next and Finish</li></br>
    </ul>
</li>
</ul>

<h2>Launch application</h2>

<ul>
<li>Open the emulator from AVD Manager
</li>
<li>Click on Run button
</li>
</ul>

<h2>Execute unit tests</h2>

<ul>
<li>On the terminal execute : <code>flutter test test/unit_tests.dart</code>
</li>

</ul>

<h2>How to add image to favorites</h2>

<ul>
<li>Double tap on the image when it's on full screen</li>

</ul>

<h2>Conception</h2>

<ul>
<li>You can find the sequence diagram in the root of directory
</li>

</ul>