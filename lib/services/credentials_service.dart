// ########################
// Imports
// ########################

// External.
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ########################
// Credentials Service
// ########################
class CredentialsService
{
	static const _storage  = FlutterSecureStorage();
	static const _keyUser  = 'username';
	static const _keyPass  = 'password';
	
	// Save user credentials.
	Future<void> save(String username, String password) async
	{
		await _storage.write(key: _keyUser, value: username);
		await _storage.write(key: _keyPass, value: password);
	}
	

	// Load user credentials.
	Future<({String? username, String? password})> load() async
	{
		final username = await _storage.read(key: _keyUser);
		final password = await _storage.read(key: _keyPass);
		return (username: username, password: password);
	}

	// Check if credentials exist.
	Future<bool> hasCredentials() async
	{
		final username = await _storage.read(key: _keyUser);
		return username != null;
	}

	// Remove all credentials.
	Future<void> clear() async
	{
		await _storage.deleteAll();
	}
}
