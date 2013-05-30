ERL ?= erl
APP := csd

.PHONY: deps

all: deps
	@./rebar compile

app:
	@./rebar compile skip_deps=true

deps:
	@./rebar get-deps

clean:
	@./rebar clean

distclean: clean
	@./rebar delete-deps

webstart: app
	exec erl -pa $(PWD)/apps/*/ebin -pa $(PWD)/deps/*/ebin -boot start_sasl -s reloader -s axos -s axos_web 

docs:
	@erl -noshell -run edoc_run application '$(APP)' '"."' '[]'
