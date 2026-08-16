#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm jre-openjdk openssl

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Getting app..."
echo "---------------------------------------------------------------"
VERSION=1.0
echo "$VERSION" > ~/version
wget https://downloaditr.receita.fazenda.gov.br/2026/arquivos/${VERSION}/ITR2025v${VERSION}.zip
bsdtar -xvf ./ITR2026v${VERSION}.zip --strip-components=1
rm -f *.zip

mkdir -p ./AppDir/bin
sed -i 's|\(\./jre/bin/\)\?java -jar pgditr.jar|java -jar "$APPDIR/bin/pgditr.jar" "$@"|g' exec.sh
mv -v exec.sh lib pgditr.jar RFB.png pgd-updater.jar ./AppDir/bin
