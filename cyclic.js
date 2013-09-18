if ( require('fs').existsSync('.git') ) {
	require('child_process').spawn(
		'npm',
		['install', '--force', require('./package.json').name],
		{env:process.env, cwd:process.cwd(), stdio:'inherit'}
	);
}