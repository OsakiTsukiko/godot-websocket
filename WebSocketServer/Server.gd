extends Node

const PORT = 3000
const PROTOCOL = "ludus"
var server: WebSocketServer

func _ready():
	server = WebSocketServer.new()
	server.listen(PORT, PoolStringArray([PROTOCOL]), true)
	
	get_tree().connect("network_peer_disconnected", self, "_peer_disconnected")
	get_tree().connect("network_peer_connected", self, "_peer_connected")
	get_tree().connect("server_disconnected", self, "_close_network")
	
	get_tree().set_network_peer(server)
	pass

func _peer_connected(id):
	print("_peer_connected ", id)
	pass

func _peer_disconnected(id):
	print("_peer_disconnected ", id)
	pass

func _close_network():
	if get_tree().is_connected("server_disconnected", self, "_close_network"):
		get_tree().disconnect("server_disconnected", self, "_close_network")
	if get_tree().is_connected("connection_failed", self, "_close_network"):
		get_tree().disconnect("connection_failed", self, "_close_network")
	get_tree().set_network_peer(null)
