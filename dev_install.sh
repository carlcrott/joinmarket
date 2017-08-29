#!/bin/sh

### TODO:
## check distro / OS
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   echo "Linux"
   # libsodium from git here:
   # https://github.com/JoinMarket-Org/joinmarket
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='macos'
fi

## check python 2.7 ~
	#### HOLDING


## check pip
type pip >/dev/null 2>&1 || { echo >&2 "Pip required but not installed. Aborting"; exit 1;}

## check for or install libsodium
if type dingo >/dev/null 2>&1; then
	echo "Homebrew installed"
	if ! brew ls --versions libsodium > /dev/null; then
		# libsodium not installed ... so install
		brew install libsodium
		echo "Libsodium installed"
	fi
else
	echo "Homebrew not present. Installing libsodium from source"
	git clone git://github.com/jedisct1/libsodium.git
	cd libsodium
	git checkout tags/1.0.3
	./autogen.sh
	./configure
	make check
	sudo make install
fi


## check for bitcoin core installation
if [ -d "/Users/$USER/Documents/python_projects/bitcoin/" ]; then
  echo "btccore present"
else
   echo "Bitcoin Core NOT present -- please install in /Users/$USER/Documents/python_projects/bitcoin/"
fi


## check for presence of files
if [ -f "/Users/$USER/Library/Application Support/Bitcoin/bitcoin.conf" ]; then
	echo "bitcoin.conf present"
else
	echo "bitcoin.conf NOT present -- please install in /Users/$USER/Library/Application Support/Bitcoin/bitcoin.conf"
	echo "example file can be found here: https://raw.githubusercontent.com/bitcoin/bitcoin/master/contrib/debian/examples/bitcoin.conf"
fi


## check for correct file values??












# run tests

PYTHONPATH=.:$PYTHONPATH py.test --cov-report html --nirc=2 --btcroot=/Users/carlcrott/Documents/python_projects/bitcoin/src/ --btcconf=/Users/carlcrott/Library/Application\ Support/Bitcoin/bitcoin.conf --btcpwd=123456abcdef












######## BREW RELATED LOGIC





# 	V=1.0.13
# 	curl -OL https://download.libsodium.org/libsodium/releases/libsodium-${V}.tar.gz
# 	tar -zxvf libsodium-${V}.tar.gz
# 	cd libsodium-${V}
# 	./configure
# 	make
# 	sudo make install
# fi


### MISC

# if [[ $platform == 'linux' ]]; then
# 	# Nothing
# elif [[ $platform == 'osx' ]]; then
# 	# Nothing   
# fi

# https://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
