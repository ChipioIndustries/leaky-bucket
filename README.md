![Unit Tests](https://github.com/chipioindustries/leaky-bucket/actions/workflows/ci.yml/badge.svg)
![Create Release](https://github.com/chipioindustries/leaky-bucket/actions/workflows/release.yml/badge.svg)
![Docs Deploy](https://github.com/chipioindustries/leaky-bucket/actions/workflows/docs-deploy.yml/badge.svg)

# LeakyBucket

LeakyBucket is a rate limiter with a buffer.

## SETTING UP REPOSITORY (REMOVE THIS)

* Copy this repository's contents into a new repository
* Find and replace all instances of the following terms:

|Term|Replace with|
|-|-|
|chipioindustries|your github username|
|leaky-bucket|your package name|
|LeakyBucket|your package name as it appears to users and as a Studio instance|
|A rate limiter with a buffer.|your package description|
|A rate limiter with a buffer.|your package tagline|

* Copy the contents of your .wally/auth.toml file into a Github secret named "WALLY_AUTH"

## Installing with Wally

* Add this line to your `wally.toml` file under `[dependencies]`:

	```toml
	LeakyBucket = "chipioindustries/leaky-bucket@0.1.0"
	```

* Then run `wally install` to install the package.

For more installation methods and usage instructions, see the [documentation](https://chipioindustries.github.io/leaky-bucket).
