################
# CLAS settings
################

echo ""
echo ">> Setting Environment variables for CLAS"
echo ""

export CLAS_ROOT=${SOFT}/clas_software_ver1 # external, ahmed dir

export CVS_RSH="/usr/bin/ssh"
export CVSROOT="ahmede@cvs.jlab.org:/group/clas/clas_cvs"
export TOP_DIR=${CLAS_ROOT}
export CLAS_BUILD=${CLAS_ROOT}
export CLAS_PACK=${CLAS_ROOT}/packages
export CLAS_CMS=${CLAS_PACK}/cms
export OSNAME=Linux64RHEL7 # hardcoded
export OS_NAME=${OSNAME}
export CLAS_TOOL=${CLAS_PACK}/ClasTool
export CLASTOOL=${CLAS_TOOL}
export CLAS_TOOL_BIN=${CLAS_TOOL}/bin/${OS_NAME}
export CLAS_SCRIPTS=${CLAS_PACK}/scripts
export CLAS_LIB=${CLAS_ROOT}/lib/${OS_NAME}
xport CLAS_LIB=${CLAS_ROOT}/lib/${OS_NAME}
export CLAS_BIN=${CLAS_ROOT}/bin/${OS_NAME}
export HV_LOCATION=${CLAS_PACK}/Hv
export RECSIS=${CLAS_PACK}
export COBRASYS=${CLAS_PACK}/utilities/cobra
export CLAS_SLIB=${CLAS_ROOT}/slib/${OS_NAME}

export CLAS_PARMS=/group/clas/parms
export CLAS_CALDB_HOST=clasdb.jlab.org
export CLAS_CALDB_USER=clasuser
export CLAS_CALDB_DBNAME=calib
export CLAS_CALDB_RUNINDEX="calib.RunIndex"
export RECSIS_RUNTIME=/group/clas/clsrc/recsis/runtime

echo "CVS_RSH              is set to ${CVS_RSH}"
echo "CVSROOT              is set to ${CVSROOT}"
echo "CLAS_ROOT            is set to ${CLAS_ROOT}"
echo "TOP_DIR              is set to ${TOP_DIR}"
echo "CLAS_BUILD           is set to ${CLAS_BUILD}"
echo "CLAS_PACK            is set to ${CLAS_PACK}"
echo "CLAS_CMS             is set to ${CLAS_CMS}"
echo "CLASTOOL             is set to ${CLASTOOL}"
:
echo "CLAS_TOOL            is set to ${CLAS_TOOL}"
echo "CLAS_SCRIPTS         is set to ${CLAS_SCRIPTS}"
echo "OSNAME               is set to ${OSNAME}"
echo "OS_NAME              is set to ${OS_NAME}"
echo "CLAS_LIB             is set to ${CLAS_LIB}"
echo "CLAS_BIN             is set to ${CLAS_BIN}"
echo "HV_LOCATION          is set to ${HV_LOCATION}"
echo "RECSIS               is set to ${RECSIS}"
echo "COBRASYS             is set to ${COBRASYS}"
echo "CLAS_SLIB            is set to ${CLAS_SLIB}"
echo "CLAS_PARMS           is set to ${CLAS_PARMS}"
echo "CLAS_CALDB_HOST      is set to ${CLAS_CALDB_HOST}"
echo "CLAS_CALDB_USER      is set to ${CLAS_CALDB_USER}"
echo "CLAS_CALDB_DBNAME    is set to ${CLAS_CALDB_DBNAME}"
echo "CLAS_CALDB_RUNINDEX  is set to ${CLAS_CALDB_RUNINDEX}"
echo "RECSIS_RUNTIME       is set to ${RECSIS_RUNTIME}"

if [ -z "${PATH}" ]; then
  PATH=${CLAS_BIN}:${CLAS_TOOL_BIN}:${CLAS_SCRIPTS}:${COBRASYS}/bin
else
  PATH=${CLAS_BIN}:${CLAS_TOOL_BIN}:${CLAS_SCRIPTS}:${COBRASYS}/bin:${PATH}
:
if [ -z "$LIBRARY_PATH" ]; then
  export LIBRARY_PATH=${CLAS_LIB}:${COBRASYS}/lib:${CLAS_SLIB}
else
  export LIBRARY_PATH=${CLAS_LIB}:${COBRASYS}/lib:${CLAS_SLIB}:$LIBRARY_PATH
fi

if [ -z "${LD_LIBRARY_PATH}" ]; then
  LD_LIBRARY_PATH=${CLAS_LIB}:${COBRASYS}/lib:${CLAS_SLIB}
else
  LD_LIBRARY_PATH=${CLAS_LIB}:${COBRASYS}/lib:${CLAS_SLIB}:${LD_LIBRARY_PATH}
fi


























