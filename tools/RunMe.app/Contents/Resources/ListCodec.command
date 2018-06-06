#!/bin/bash

# Maintained by: Mirone ⓒ 2017 - 2018
#
# Credits: cecekpawon
#
# Using in AppleHAPatcher.app (Old version) to identify installed audio codecs
#
# Mandatory Requirements:
# 1. AppleHDA.kext
# 2. Patch HDEF in your DSDt ou Inject by clover.
# 
# 
#set -x

clear

aONBOARD=(
  [0x10134206]="Cirrus Logic CS4206"
  [0x10134208]="Cirrus Logic CS4208"
  [0x10138409]="Cirrus Logic CS8409"
  [0x10ec0233]="Realtek ALC233"
  [0x10ec0235]="Realtek ALC235"
  [0x10ec0236]="Realtek ALC236"
  [0x10ec0255]="Realtek ALC255"
  [0x10ec0260]="Realtek ALC260"
  [0x10ec0262]="Realtek ALC262"
  [0x10ec0267]="Realtek ALC267"
  [0x10ec0268]="Realtek ALC268"
  [0x10ec0269]="Realtek ALC269"
  [0x10ec0270]="Realtek ALC270"
  [0x10ec0272]="Realtek ALC272"
  [0x10ec0275]="Realtek ALC275"
  [0x10ec0280]="Realtek ALC280"
  [0x10ec0282]="Realtek ALC282"
  [0x10ec0283]="Realtek ALC283"
  [0x10ec0284]="Realtek ALC284"
  [0x10ec0286]="Realtek ALC286"
  [0x10ec0288]="Realtek ALC288"
  [0x10ec0290]="Realtek ALC290"
  [0x10ec0663]="Realtek ALC663"
  [0x10ec0668]="Realtek ALC668"
  [0x10ec0885]="Realtek ALC885"
  [0x10ec0887]="Realtek ALC887"
  [0x10ec0888]="Realtek ALC888"
  [0x10ec0889]="Realtek ALC889"
  [0x10ec0892]="Realtek ALC892"
  [0x10ec0899]="Realtek ALC898"
  [0x10ec0900]="Realtek ALC1150"
  [0x10de1220]="Realtek ALC1220"
  [0x10ec1168]="Realtek ALCS1220A"
  [0x11060441]="VT2021"
  [0x11068446]="VIA VT1802"
  [0x111d7603]="IDT 992HD75B3X5"
  [0x111d7605]="IDT 92HD87B1/92HD81B1X5"
  [0x111d7608]="IDT 92HD75B2X5"
  [0x111d76b2]="IDT 92HD71B7X"
  [0x111d76e0]="IDT 92HD91BXX"
  [0x111d76e5]="IDT 92HD99BXX"
  [0x111d76f3]="IDT 92HD66C3/65"
  [0x14f15067]="Conexant 20583"
  [0x14f15069]="Conexant 20585"
  [0x14f1506c]="Conexant 20588"
  [0x14f1506e]="Conexant 20590"
  [0x14f1510f]="Conexant 20752"
  [0x14f15114]="Conexant 20756"
  [0x14f15115]="Conexant 20757"
  [0x1aec8800]="Wolfson WM8800"
)

# http://lxr.free-electrons.com/source/sound/pci/hda/patch_hdmi.c

aHDMI=(
  [0x10027919]="RS600"
  [0x1002791a]="RS690/780"
  [0x1002793c]="RS600"
  [0x1002aa01]="R6xx"
  [0x10951390]="SiI1390"
  [0x10951392]="SiI1392"
  [0x10de0002]="MCP77/78"
  [0x10de0003]="MCP77/78"
  [0x10de0005]="MCP77/78"
  [0x10de0006]="MCP77/78"
  [0x10de0007]="MCP79/7A"
  [0x10de000a]="GPU 0a"
  [0x10de000b]="GPU 0b"
  [0x10de000c]="MCP89"
  [0x10de000d]="GPU 0d"
  [0x10de0010]="GPU 10"
  [0x10de0011]="GPU 11"
  [0x10de0012]="GPU 12"
  [0x10de0013]="GPU 13"
  [0x10de0014]="GPU 14"
  [0x10de0015]="GPU 15"
  [0x10de0016]="GPU 16"
  [0x10de0018]="GPU 18"
  [0x10de0019]="GPU 19"
  [0x10de001a]="GPU 1a"
  [0x10de001b]="GPU 1b"
  [0x10de001c]="GPU 1c"
  [0x10de0020]="Tegra30"
  [0x10de0022]="Tegra114"
  [0x10de0028]="Tegra124"
  [0x10de0029]="Tegra210"
  [0x10de0040]="GPU 40"
  [0x10de0041]="GPU 41"
  [0x10de0042]="GPU 42"
  [0x10de0043]="GPU 43"
  [0x10de0044]="GPU 44"
  [0x10de0051]="GPU 51"
  [0x10de0060]="GPU 60"
  [0x10de0067]="MCP67"
  [0x10de0070]="GPU 70"
  [0x10de0071]="GPU 71"
  [0x10de0072]="GPU 72"
  [0x10de0073]="GPU 73"
  [0x10de0074]="GPU 74"
  [0x10de0076]="GPU 76"
  [0x10de007b]="GPU 7b"
  [0x10de007c]="GPU 7c"
  [0x10de007d]="GPU 7d"
  [0x10de070e]="GPU 7e"
  [0x10de0080]="GPU 80"
  [0x10de0081]="GPU 81"
  [0x10de0082]="GPU 82"
  [0x10de0083]="GPU 83"
  [0x10de0084]="GPU 84"
  [0x10de0090]="GPU 90"
  [0x10de0091]="GPU 91"
  [0x10de0092]="GPU 92"
  [0x10de0093]="GPU 93"
  [0x10de0094]="GPU 94"
  [0x10de0095]="GPU 95"
  [0x10de0097]="GPU 97"
  [0x10de0098]="GPU 98"
  [0x10de0099]="GPU 99"
  [0x10de8001]="MCP73"
  [0x11069f80]="VX900"
  [0x11069f81]="VX900"
  [0x11069f84]="VX11"
  [0x11069f85]="VX11"
  [0x17e80047]="Chrontel"
  [0x80860054]="IbexPeak"
  [0x80862801]="Bearlake"
  [0x80862802]="Cantiga"
  [0x80862803]="Eaglelake"
  [0x80862804]="IbexPeak"
  [0x80862805]="CougarPoint"
  [0x80862806]="PantherPoint"
  [0x80862807]="Haswell"
  [0x80862808]="Broadwell"
  [0x80862809]="Skylake"
  [0x8086280a]="Broxton"
  [0x8086280b]="Kabylake"
  [0x80862880]="CedarTrail"
  [0x80862882]="Valleyview2"
  [0x80862883]="Braswell"
  [0x808629fb]="Crestline"
)

#
#
# detect installed codecs for Vendor id.
ListCodec=$(ioreg -rxn IOHDACodecDevice | grep VendorID | awk '{ print $4 }' | sed 's/ffffffff//')

# no codecs detected.
if [[ -z "${ListCodec}" ]]; then
  printf "No audio codec detected!!"
  exit 1
fi

printf "Codecs Detecteds:\n\n"

for Codec in $ListCodec
do
  Vendor="ONBOARD"
  Tmp="${aONBOARD[$Codec]}"

  if [[ -z "${Tmp}" ]]; then
    Tmp=$(echo "${Codec}" | egrep -o '0x(10de|1002|8086)')

    if [[ ! -z "${Tmp}" ]]; then
      Vendor="Unknown"
      HDMI="${aHDMI[$Codec]}"

      if [[ ! -z "${HDMI}" ]]; then
        case "${Tmp}" in
          0x8086) Vendor="INTEL";;
          0x10de) Vendor="NVIDIA";;
          0x1002) Vendor="AMD/ATI";;
        esac

        if [[ "${Vendor}" != "Unknown" ]]; then
          Tmp="${HDMI}"
          Vendor+=" DP/HDMI"
        fi
      else
        Tmp="Unknown"
        Vendor="Unknown"
      fi
    fi
  fi

  printf "Vendor: %s\nName: %s\nCodec: %s\n\n" "${Vendor}" "${Tmp}" "${Codec}"
done