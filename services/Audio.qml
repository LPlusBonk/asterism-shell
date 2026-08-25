pragma Singleton
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource
    readonly property bool muted: sink?.audio?.muted ?? false
    readonly property real volume: sink?.audio?.volume ?? 0

    function setVolume(v: real): void {
        if (sink?.ready && sink?.audio) {
            sink.audio.muted = false
            sink.audio.volume = Math.max(0, Math.min(1, v))
        }
    }

    function toggleMute(): void {
        if (sink?.ready && sink?.audio) sink.audio.muted = !sink.audio.muted
    }

    PwObjectTracker { objects: [sink, source] }
}
