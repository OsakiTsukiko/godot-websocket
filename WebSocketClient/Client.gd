extends Control

onready var username_input = $CenterContainer/VBoxContainer/Username
onready var ip_input = $CenterContainer/VBoxContainer/IP
onready var port_input = $CenterContainer/VBoxContainer/Port

const PROTOCOL = "ludus"
var username: String = "Godette"
var ip: String = "localhost"
var port: int = 3000

var client: WebSocketClient

func _ready():
	pass

func _on_Connect_pressed():
	if (username_input.text != ""):
		username = username_input.text
	if (ip_input.text != ""):
		ip = ip_input.text
	if (port_input.text != ""):
		port = int(port_input.text)
	
	client = WebSocketClient.new()
	client.connect_to_url("ws://" + ip + ":" + str(port), PoolStringArray([PROTOCOL]), true)
	
	get_tree().connect("connection_failed", self, "_close_network")
	get_tree().connect("connected_to_server", self, "_connected")
	
	get_tree().set_network_peer(client)
	pass

func _close_network():
	if get_tree().is_connected("connection_failed", self, "_close_network"):
		get_tree().disconnect("connection_failed", self, "_close_network")
	if get_tree().is_connected("connected_to_server", self, "_connected"):
		get_tree().disconnect("connected_to_server", self, "_connected")
	get_tree().set_network_peer(null)

func _connected():
	print("Connected")
	pass
