pragma Singleton
import Quickshell

Singleton {
    // Which screen currently owns the open audio flyout, if any.
    property ShellScreen audioScreen: null

    function toggleAudio(screen: ShellScreen): void {
        audioScreen = audioScreen === screen ? null : screen;
    }

    function closeAudio(): void {
        audioScreen = null;
    }
}
