all: lint test

lint:
	luacheck --no-color .

test:
	nvim --headless --noplugin -c 'packadd plenary.nvim' -c "PlenaryBustedDirectory spec"
