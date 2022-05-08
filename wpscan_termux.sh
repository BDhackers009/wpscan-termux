#!/bin/bash
if [[ -f "/data/data/com.termux/files/usr/bin/wpscan" ]]; then
	rm -rf "/data/data/com.termux/files/usr/bin/wpscan"
fi
URL_ethonrb="https://raw.githubusercontent.com/tevio/ethon/f0b4aab081f218c51d0501e7e12fb2a177e16300/lib/ethon.rb"
URL_classesrb="https://raw.githubusercontent.com/tevio/ethon/f0b4aab081f218c51d0501e7e12fb2a177e16300/lib/ethon/curls/classes.rb"
URL_libcrb="https://raw.githubusercontent.com/tevio/ethon/f0b4aab081f218c51d0501e7e12fb2a177e16300/lib/ethon/libc.rb"
ethon_rb="/data/data/com.termux/files/usr/lib/ruby/gems/3.1.0/gems/ethon-0.15.0/lib"
libc_rb="/data/data/com.termux/files/usr/lib/ruby/gems/3.1.0/gems/ethon-0.15.0/lib/ethon"
classes_rb="/data/data/com.termux/files/usr/lib/ruby/gems/3.1.0/gems/ethon-0.15.0/lib/ethon/curls"
fix_libc() {
clear
echo
echo
echo "Fixing libc files..."
echo
echo
sleep .5
if [[ -f "${ethon_rb}/ethon.rb" ]]; then
    rm -rf ${ethon_rb}/ethon.rb
    curl -sL "${URL_ethonrb}" --output ${ethon_rb}/ethon.rb
else
    curl -sL "${URL_ethonrb}" --output ${ethon_rb}/ethon.rb 
fi

if [[ -f "${classes_rb}/classes.rb" ]]; then
    rm -rf ${classes_rb}/classes.rb
    curl -sL "${URL_classesrb}" --output ${classes_rb}/classes.rb
else
    curl -sL "${URL_classesrb}" --output ${classes_rb}/classes.rb
fi

if [[ -f "${libc_rb}/libc.rb" ]]; then
    rm -rf ${libc_rb}/libc.rb
    curl -sL "${URL_libcrb}" --output ${libc_rb}/libc.rb
else
    curl -sL "${URL_libcrb}" --output ${libc_rb}/libc.rb
fi
}
install_nokogiri() {
echo
echo "Installing packages..."
echo
sleep .5
yes | pkg up
yes | pkg install ruby clang make binutils proot pkg-config libxslt
sleep .5
gem install nokogiri --platform=ruby -- --use-system-libraries
}
prosetup() {
# This will fix the read only file system error 
PREFIX="/data/data/com.termux/files/usr"
mv $PREFIX/bin/wpscan $PREFIX/bin/bwpscan
cat <<- EOF > $PREFIX/bin/wpscan
#!/bin/bash
cmnd="$@"
termux-chroot bwpscan "$cmnd"
EOF
chmod +x $PREFIX/bin/wpscan
}
main() {
    install_nokogiri
    sleep .5
    clear
    echo
    echo
    echo "Installing WpScan wait..."
    echo
    echo
    gem install wpscan
    sleep .5
    fix_libc
    prosetup
}

main
