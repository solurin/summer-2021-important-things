#!/bin/bash
export CLAS_PARMS=/data/parms
export ROOTSYS=/usr/local/root
export MYSQLINC=/usr/include/mysql
export MYSQLLIB=/usr/lib64/mysql
export CLAS6=/usr/local/clas-software/build
export PATH=$CLAS6/bin:$PATH
export CERN=/usr/local/cernlib/x86_64_rhel6
export CERN_LEVEL=2005/bin
export CERN_ROOT=$CERN/$CERN_LEVEL
export CVSCOSRC=$CERN/$CERN_LEVEL/src
export PATH=$CERN/$CERN_LEVEL/src:$PATH
export CERN_LIB=$CERN_ROOT/lib
export CERNLIB=$CERN_ROOT/lib
export CERN_BIN=$CERN_ROOT/bin
export CLAS_TOOL=/usr/local/clas-software/analysis/ClasTool
export PATH=$PATH:$CLAS_TOOL/bin/Linux
export LD_LIBRARY_PATH=$ROOTSYS/lib:$CLAS_TOOL/slib/Linux:$CLAS6/lib

source $ROOTSYS/bin/thisroot.sh

# export TMPDIR=$(mktemp -d -p ${PWD})
# echo $TMPDIR

export CLAS_CALDB_PASS=""
export CLAS_CALDB_RUNINDEX="RunIndex"
export RECSIS_RUNTIME="${PWD}/recsis"
mkdir -p ${RECSIS_RUNTIME}

tar -xvf parms.tar.gz
export CLAS_PARMS=${PWD}/parms

export CLAS_CALDB_HOST=clasdb.jlab.org
export CLAS_CALDB_USER=clasreader

export DATE=`date +%m-%d-%Y`

echoerr() { printf "%s\n" "$*" >&1; printf "%s\n" "$*" >&2; }

echoerr "====== cpu info ======"
lscpu
echoerr "====== cpu info ======"

#set -e
STARTTIME=$(date +%s)

# echoerr "============ start lepto ============"
export LEPTO_EXE=/usr/local/Lepto64Sim/bin/
export LEPTO_PL=/usr/local/Lepto64Sim/leptotxt.pl
export TXT2PART=/usr/local/clas-software/build/bin/
export LEPTO_MATERIAL=lepto$1.A00
export LEPTO_LOG=lepto$1.log
cp ffread_eg2.gsim ffread_eg2$1.gsim
export ffreadfile=ffread_eg2$1.gsim
export Nevts=$2
export pid=$3
if [[ $1 == "D" ]]
	then
		export tarA=2
		export tarVG2=1
		export tarZ=1
elif [[ $1 == "C" ]]
	then
		export tarA=12
		export tarVG2=2
		export tarZ=6
elif [[ $1 == "Fe" ]]
	then
		export tarA=56
		export tarVG2=2
		export tarZ=26
elif [[ $1 == "Pb" ]] 
	then
		export tarA=207
		export tarVG2=2
		export tarZ=82
fi

sed -i "s/TGTP/TGTP ${tarA}/g"    ${ffreadfile}
sed -i "s/VEG2/VEG2 ${tarVG2}/g"  ${ffreadfile}
sed -i "s/TRIG/TRIG ${Nevts}/g"   ${ffreadfile}

echo "${Nevts} ${tarA} ${tarZ} ${pid}" > ./lepto.txt


${LEPTO_EXE}/lepto.exe | ${LEPTO_PL} | ${TXT2PART}/txt2part -o${LEPTO_MATERIAL} 2>&1 | tee ${LEPTO_LOG} 









# echoerr "============ end lepto ============"

export CLAS_CALDB_DBNAME=calib
export CLAS_CALDB_RUNINDEX="calib.RunIndex"

echoerr "============ start gsim_bat ============"
gsim_bat -nomcdata -ffread ${ffreadfile} -mcin ${LEPTO_MATERIAL} -bosout gsim.bos
echoerr "============ end gsim_bat ============"

echoerr "============ start gpp ============"
gpp -ogppD.A00 -a2.35 -b2.35 -c2.35 -f0.97 -P0x1b -R23500 gsim.bos
 #gpp -ouncooked.bos -R23500 gsim.bos
echoerr "============ end gpp ============"

# echoerr "============ start user_ana ============"
#user_ana -t user_ana.tcl
user_ana -t recsisD.tcl | grep -v HFITGA | grep -v HFITH | grep -v HFNT
# echoerr "============ end user_ana ============"

# h10maker -rpm cooked.bos all.root

# #ls -latr
# echoerr "============ cleanup ============"
# du -sh *
# echoerr "============ cleanup ============"
# rm -rf aao_rad.* anamonhist cooked.bos cooked_chist.hbook gsim.bos parms parms.tar.gz uncooked.bos
# echoerr "============ cleanup ============"
# du -sh *
# echoerr "============ cleanup ============"
# df -h .
# echoerr "============ cleanup ============"

ENDTIME=$(date +%s)
echo "Hostname: $HOSTNAME"
echo "Total runtime: $(($ENDTIME-$STARTTIME))"
