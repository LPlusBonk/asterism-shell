pragma Singleton
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource
    readonly property bool muted: sink?.audio?.muted ?? false
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property bool sourceMuted: source?.audio?.muted ?? false
    readonly property real sourceVolume: source?.audio?.volume ?? 0

    readonly property var sinks: Pipewire.nodes.values.filter(n => !n.isStream && n.isSink)
    readonly property var sources: Pipewire.nodes.values.filter(n => !n.isStream && !n.isSink && (n.type & PwNodeType.Audio))

    function setVolume(v: real): void {
        if (sink?.ready && sink?.audio) {
            sink.audio.muted = false
            sink.audio.volume = Math.max(0, Math.min(1, v))
        }
    }

    function toggleMute(): void {
        if (sink?.ready && sink?.audio) sink.audio.muted = !sink.audio.muted
    }

    function setSourceVolume(v: real): void {
        if (source?.ready && source?.audio) {
            source.audio.muted = false
            source.audio.volume = Math.max(0, Math.min(1, v))
        }
    }

    function toggleSourceMute(): void {
        if (source?.ready && source?.audio) source.audio.muted = !source.audio.muted
    }

    function setSink(node: PwNode): void {
        Pipewire.preferredDefaultAudioSink = node
    }

    function setSource(node: PwNode): void {
        Pipewire.preferredDefaultAudioSource = node
    }

    PwObjectTracker { objects: [sink, source] }
}
