pragma Singleton
import Quickshell
import Quickshell.Services.Notifications

Singleton {
	id: root
	property var history: []

	NotificationServer {
		id: server
		keepOnReload: false
		actionsSupported: true
		bodySupported: true
		imageSupported: true

		onNotification: function(notification) {
			notification.tracked = true
			root.history.push(notification)
			root.historyChanged()
		}
	}
}
