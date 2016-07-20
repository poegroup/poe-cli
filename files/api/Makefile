start: deps
	@iex -S mix

deps:
	@mix deps.get
	@mix deps.compile

test: deps
	@mix test

clean:
	@mix clean
