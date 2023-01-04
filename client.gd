extends Node

var client_custom = ENetMultiplayerPeer.new()
var multiplayer_api : MultiplayerAPI

var address = "127.0.0.1"
var port = 8888

func _ready():
	print("Custom Client _ready() Entered")

	client_custom.peer_connected
	client_custom.peer_disconnected

	client_custom.create_client(address, port)
	multiplayer_api = MultiplayerAPI.create_default_interface()
	get_tree().set_multiplayer(multiplayer_api, self.get_path()) 
	multiplayer_api.multiplayer_peer = client_custom

	print("Custom ClientUnique ID: {0}".format([multiplayer_api.get_unique_id()]))

func _process(_delta: float) -> void:
	if multiplayer_api.has_multiplayer_peer():
		multiplayer_api.poll()

func _on_connection_succeeded():
	print("Custom Client _on_connection_succeeded")
	await get_tree().create_timer(1).timeout
	print("Custom Peers: {0}".format([multiplayer.get_peers()]))
	rpc_server_custom()

func _on_connection_failed():
	print("Custom Client _on_connection_failed")

@rpc 
func rpc_server_custom():
	print("Custom Client rpc_server_custom")
	print("Custom Peers: {0}".format([multiplayer.get_peers()]))
	rpc_server_custom.rpc() # this works (NO MORE STRINGS!)

@rpc(authority) 
func rpc_server_custom_response(test_var1, test_var2):
	print("Custom Client rpc_server_custom_response: {0} {1}".format(
		[test_var1, test_var2]))
