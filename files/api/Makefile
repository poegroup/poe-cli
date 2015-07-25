start: .env deps
	@$(shell cat .env | grep '^#' --invert-match | xargs) iex -S mix

.env:
	@cp .env.example $@

deps:
	@mix deps.get
	@mix deps.compile

test: .env deps
	@$(shell cat .env | grep '^#\|^MIX_ENV' --invert-match | xargs) mix test

clean:
	@mix clean