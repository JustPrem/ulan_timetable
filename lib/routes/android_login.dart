// ########################
// Imports.
// ########################

// Base.
import 'package:flutter/material.dart';

// Services.
import 'package:ulan_timetable/services/credentials_service.dart';
import 'package:ulan_timetable/services/timetable_service.dart';

// ############################
// AndroidLogin.
// ############################

class AndroidLogin extends StatefulWidget
{
	const AndroidLogin({super.key});

	@override
	State<AndroidLogin> createState() => _AndroidLoginState();
}

class _AndroidLoginState extends State<AndroidLogin>
{
	// ############################
	// State.
	// ############################

	final _usernameController = TextEditingController();
	final _passwordController = TextEditingController();
	final _formKey            = GlobalKey<FormState>();
	final _service            = TimetableService();

	bool    _obscurePassword = true;
	bool    _isLoading       = false;
	String? _errorMessage;

	// ############################
	// Lifecycle.
	// ############################

	@override
	void initState()
	{
		super.initState();
		_loadSavedCredentials();
	}

	@override
	void dispose()
	{
		_usernameController.dispose();
		_passwordController.dispose();
		super.dispose();
	}

	// ############################
	// Methods.
	// ############################

	Future<void> _loadSavedCredentials() async
	{
		final creds = await CredentialsService().load();

		if (creds.username != null)
		{
			_usernameController.text = creds.username!;
			_passwordController.text = creds.password ?? '';
		}
	}

	Future<void> _onLogin() async
	{
		if (!_formKey.currentState!.validate()) return;

		final username = _usernameController.text.trim();
		final password = _passwordController.text;

		setState
		(
			()
			{
				_isLoading    = true;
				_errorMessage = null;
			},
		);

		try
		{
			await _service.verifyCredentials(username, password);
			
			await CredentialsService().save(username, password);

			if (mounted)
			{
				Navigator.pushReplacementNamed(context, '/timetable');
			}
		}
		catch (e)
		{
			setState(() => _errorMessage = 'Login failed. Check your credentials and try again.');
		}
		finally
		{
			if (mounted) setState(() => _isLoading = false);
		}
	}

	// ############################
	// Build.
	// ############################

	@override
	Widget build(BuildContext context)
	{
		final theme      = Theme.of(context);
		final colours    = theme.colorScheme;
		final isKeyboard = MediaQuery.of(context).viewInsets.bottom > 0;

		return Scaffold
		(
			backgroundColor: colours.surface,
			body: SafeArea
			(
				child: Center
				(
					child: SingleChildScrollView
					(
						padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
						child: ConstrainedBox
						(
							constraints: const BoxConstraints(maxWidth: 700),
							child: Form
							(
								key: _formKey,
								child: Column
								(
									crossAxisAlignment: CrossAxisAlignment.start,
									children:
									[
										// ---- Header ----
										if (!isKeyboard) ...[
											const SizedBox(height: 24),
											Text
											(
												'University of Lancashire',
												style: theme.textTheme.headlineMedium?.copyWith
												(
													fontWeight: FontWeight.w800,
													color:      colours.onSurface,
												),
											),
											Text
											(
												'Timetable Viewer',
												style: theme.textTheme.titleLarge?.copyWith
												(
													fontWeight: FontWeight.w600,
													color:      colours.onSurfaceVariant,
												),
											),
											const SizedBox(height: 4),
											Text
											(
												'Sign in to view your timetable',
												style: theme.textTheme.bodyMedium?.copyWith
												(
													color: colours.onSurface.withOpacity(0.55),
												),
											),
											const SizedBox(height: 40),
										] else
											const SizedBox(height: 16),

										// ---- Username ----
										Text
										(
											'Username',
											style: theme.textTheme.labelLarge?.copyWith
											(
												color: colours.onSurface.withOpacity(0.75),
											),
										),
										const SizedBox(height: 8),
										TextFormField
										(
											controller:      _usernameController,
											keyboardType:    TextInputType.emailAddress,
											textInputAction: TextInputAction.next,
											autocorrect:     false,
											decoration: InputDecoration
											(
												hintText: 'jsmith',
												hintStyle: TextStyle(color: colours.onSurface.withOpacity(0.33)),
												border:   const OutlineInputBorder(),
												suffix: Text
												(
													'@lancashire.ac.uk',
													style: theme.textTheme.bodyMedium?.copyWith
													(
														color: colours.onSurface.withOpacity(0.35),
													),
												),
											),
											validator: (value)
											{
												if (value == null || value.trim().isEmpty)
												{
													return 'Please enter your username';
												}
												return null;
											},
										),
										const SizedBox(height: 20),

										// ---- Password ----
										Text
										(
											'Password',
											style: theme.textTheme.labelLarge?.copyWith
											(
												color: colours.onSurface.withOpacity(0.75),
											),
										),
										const SizedBox(height: 8),
										TextFormField
										(
											controller:      _passwordController,
											obscureText:     _obscurePassword,
											textInputAction: TextInputAction.done,
											onFieldSubmitted: (_) => _onLogin(),
											decoration: InputDecoration
											(
												hintText: '••••••••',
												hintStyle: TextStyle(color: colours.onSurface.withOpacity(0.33)),
												border:   const OutlineInputBorder(),
												suffixIcon: IconButton
												(
													icon: Icon
													(
														_obscurePassword
															? Icons.visibility_outlined
															: Icons.visibility_off_outlined,
														color: colours.onSurface.withOpacity(0.5),
													),
													onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
												),
											),
											validator: (value)
											{
												if (value == null || value.isEmpty)
												{
													return 'Please enter your password';
												}
												return null;
											},
										),
										const SizedBox(height: 24),

										// ---- Error Message ----
										if (_errorMessage != null) ...[
											Container
											(
												padding: const EdgeInsets.all(12),
												decoration: BoxDecoration
												(
													color:        colours.errorContainer,
													borderRadius: BorderRadius.circular(8),
												),
												child: Row
												(
													children:
													[
														Icon(Icons.error_outline, color: colours.error, size: 18),
														const SizedBox(width: 8),
														Expanded
														(
															child: Text
															(
																_errorMessage!,
																style: theme.textTheme.bodySmall?.copyWith
																(
																	color: colours.onErrorContainer,
																),
															),
														),
													],
												),
											),
											const SizedBox(height: 16),
										],

										// ---- Login Button ----
										SizedBox
										(
											width:  double.infinity,
											height: 50,
											child: FilledButton
											(
												onPressed: _isLoading ? null : _onLogin,
												child: _isLoading
													? SizedBox
													(
														width:  20,
														height: 20,
														child: CircularProgressIndicator
														(
															strokeWidth: 2.5,
															color:       colours.onPrimary,
														),
													)
													: const Text('Sign In'),
											),
										),
										const SizedBox(height: 24),
									],
								),
							),
						),
					),
				),
			),
		);
	}
}
