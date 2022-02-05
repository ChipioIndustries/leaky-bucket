![Unit Tests](https://github.com/chipioindustries/leaky-bucket/actions/workflows/ci.yml/badge.svg)
![Create Release](https://github.com/chipioindustries/leaky-bucket/actions/workflows/release.yml/badge.svg)
![Docs Deploy](https://github.com/chipioindustries/leaky-bucket/actions/workflows/docs-deploy.yml/badge.svg)

# LeakyBucket

LeakyBucket is a rate limiter with a buffer.

* Copy the contents of your .wally/auth.toml file into a Github secret named "WALLY_AUTH"

## Installing with Wally

* Add this line to your `wally.toml` file under `[dependencies]`:

	```toml
	LeakyBucket = "chipioindustries/leaky-bucket@0.1.0"
	```

* Then run `wally install` to install the package.

For more installation methods and usage instructions, see the [documentation](https://chipioindustries.github.io/leaky-bucket).
