.PHONY: clean dist test test_build

SRC_DIR = src/main
TEST_DIR = src/test
PKG=jqext
PKG_DIR = $(SRC_DIR)/$(PKG)
HX_SRC = $(PKG_DIR)/*.hx
TEST_SRC= src/test/*
LIB_JSON = $(SRC_DIR)/haxelib.json

all: test_build

test_build: target Makefile $(HX_SRC) $(LIB_JSON) $(TEST_SRC)
	haxe -lib hxopt -lib JQueryExtern \
		-cp $(SRC_DIR) -cp $(TEST_DIR) \
		-main TestMain -js target/TestMain.js
	cp $(TEST_DIR)/*.html target/
	#cp $(TEST_DIR)/*.css target/
	#cp $(TEST_DIR)/*.js target/

target:
	@mkdir -p target

target/build: target
	@mkdir -p target/build

dist: target/$(PKG).zip

target/$(PKG).zip: target Makefile $(HX_SRC) $(LIB_JSON)
	cd src/main && zip -r ../../target/$(PKG).zip . -x \*~

release: target/$(PKG).zip
	haxelib submit target/$(PKG).zip

clean:
	@rm -r target
