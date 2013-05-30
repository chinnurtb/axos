all: clean build package

clean:
	rebar clean

deps:
	rebar get-deps

build: deps
	rebar compile

package: build
	rebar generate -f

console: package
	rel/axos/bin/axos console

console_clean: package
	rel/axos/bin/axos console_clean

