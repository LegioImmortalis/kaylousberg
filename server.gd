extends Node

const p_res := preload("res://Player/player.tscn")
const w_res := preload("res://Village/village.tscn")

var server_custom = ENetMultiplayerPeer.new()
var multiplayer_api : MultiplayerAPI

var port = 8888
var max_peers = 5

func _ready():
	print("Custom Server _ready() Entered")

	server_custom.peer_connected.connect(_on_peer_connected)
	server_custom.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer_api = MultiplayerAPI.create_default_interface()
	server_custom.create_server(port, max_peers)

	get_tree().set_multiplayer(multiplayer_api, self.get_path())
	multiplayer_api.multiplayer_peer = server_custom

func _process(_delta: float) -> void:
	if multiplayer_api.has_multiplayer_peer():
		multiplayer_api.poll()

func _on_peer_connected(peer_id):
	print("Custom Server _on_peer_connected, peer_id: {0}".format([peer_id]))
	await get_tree().create_timer(1).timeout
	print("Custom Peers: {0}".format([multiplayer.get_peers()]))

func _on_peer_disconnected(peer_id):
	print("Custom Server _on_peer_disconnected, peer_id: {0}".format([peer_id]))

@rpc(any_peer) 
func rpc_server_custom():
	var peer_id = multiplayer.get_remote_sender_id() # even custom uses default "multiplayer" calls
	print("rpc_server_custom, peer_id: {0}".format([peer_id]))
	rpc_server_custom_response(peer_id)

@rpc 
func rpc_server_custom_response(peer_id, test_var1 : String = "party like it's", test_var2 : int = 1999):
	print("rpc_server_custom_response to peer_id : {0}".format([peer_id]))
	rpc_server_custom_response.rpc_id(peer_id, test_var1, test_var2)
