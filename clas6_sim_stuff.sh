# echoerr "============ start lepto ============"
export LEPTO_EXE=/usr/local/Lepto64Sim/bin/lepto.exe
export LEPTO_PL=/usr/local/Lepto64Sim/leptotxt.pl
export TXT2PART=/usr/local/clas-software/build/bin/txt2part
export LEPTO_MATERIAL=lepto$1.A00
export LEPTO_LOG=lepto$1.log
cp ffread_eg2.gsim ffread_eg2$1.gsim
export ffreadfile=ffread_eg2$1.gsim
export Nevts=$2
if [[ $1 == "D" ]]
        then
                export tarA=2
                export tarVG2=1
elif [[ $1 == "C" ]]
        then
                export tarA=12
                export tarVG2=2
elif [[ $1 == "Fe" ]]
        then
                export tarA=56
                export tarVG2=2
elif [[ $1 == "Pb" ]]
        then
                export tarA=207
                export tarVG2=2
fi

sed -i "s/TGTP/TGTP ${tarA}/g"    ${ffreadfile}
sed -i "s/VEG2/VEG2 ${tarVG2}/g"  ${ffreadfile}
sed -i "s/TRIG/TRIG ${Nevts}/g"   ${ffreadfile}

