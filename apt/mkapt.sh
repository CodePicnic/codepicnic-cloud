#!/bin/bash

GPG_NAME=55042E49
REPONAME=stable
VERSION=$1
REPODIR=/var/www/apt

cd $REPODIR


for bindir in `find dists/${REPONAME} -type d -name "binary*"`; do
    arch=`echo $bindir|cut -d"-" -f 2`
    echo "Processing ${bindir} with arch ${arch}"

    overrides_file=/tmp/overrides
    package_file=$bindir/Packages
    release_file=$bindir/Release

    # Create simple overrides file to stop warnings
    cat /dev/null > $overrides_file
    for pkg in `ls pool/main/ | grep -E "(all|${arch})\.deb"`; do
        pkg_name=`/usr/bin/dpkg-deb -f pool/main/${pkg} Package`
        echo "${pkg_name} Priority extra" >> $overrides_file
    done

    # Index of packages is written to Packages which is also zipped
    dpkg-scanpackages -a ${arch} pool/main $overrides_file > $package_file
    # The line above is also commonly written as:
    # dpkg-scanpackages -a ${arch} pool/main /dev/null > $package_file
    gzip -9c $package_file > ${package_file}.gz
    bzip2 -c $package_file > ${package_file}.bz2

    # Cleanup
    rm $overrides_file
done


# Release info goes into Release & Release.gpg which includes an md5 & sha1 hash of Packages.*
# Generate & sign release file
cd dists/${REPONAME}
cat > Release <<ENDRELEASE
Suite: ${REPONAME}
Version: ${VERSION}
Component: main
Origin: CodePicnic 
Label: CodePicnic 
Architecture: i386 amd64
Date: `date -R -u`
ENDRELEASE
# Generate hashes
#echo "MD5Sum:" >> Release
#for hashme in `find main -type f`; do
#    md5=`openssl dgst -passin pass:xe4air8hah2Ohf -md5 ${hashme}|cut -d" " -f 2`
#    size=`stat -c %s ${hashme}`
#    echo " ${md5} ${size} ${hashme}" >> Release
#done
#echo "SHA1:" >> Release
#for hashme in `find main -type f`; do
#    sha1=`openssl dgst -passin pass:xe4air8hah2Ohf -sha1 ${hashme}|cut -d" " -f 2`
#    size=`stat -c %s ${hashme}`
#    echo " ${sha1} ${size} ${hashme}" >> Release
#done
echo "SHA256:" >> Release
for hashme in `find main -type f`; do
    sha1=`openssl dgst -passin pass:xe4air8hah2Ohf -sha256 ${hashme}|cut -d" " -f 2`
    size=`stat -c %s ${hashme}`
    echo " ${sha1} ${size} ${hashme}" >> Release
done
echo "SHA512:" >> Release
for hashme in `find main -type f`; do
    sha1=`openssl dgst -passin pass:xe4air8hah2Ohf -sha512 ${hashme}|cut -d" " -f 2`
    size=`stat -c %s ${hashme}`
    echo " ${sha1} ${size} ${hashme}" >> Release
done

# Sign!
gpg --batch --passphrase=xe4air8hah2Ohf --yes -u $GPG_NAME --sign -bao Release.gpg Release
cd -

