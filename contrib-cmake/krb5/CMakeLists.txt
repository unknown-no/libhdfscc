SET(SRC_DIR ${CONTRIB_SOURCE_DIR}/krb5)

IF(NOT EXISTS ${WORKSPACE_INSTALL_DIR}/include/krb5/krb5.h OR FORCE_INSTALL_KRB5)
EXECUTE_PROCESS(
    WORKING_DIRECTORY ${SRC_DIR}/src
    COMMAND_ECHO STDOUT
    COMMAND autoreconf --verbose
    COMMAND ${SRC_DIR}/src/configure --prefix=${WORKSPACE_INSTALL_DIR} --with-spake-openssl=${WORKSPACE_INSTALL_DIR} --enable-static --disable-shared
    COMMAND make
    COMMAND make install
)
ENDIF()

# FIND_PACKAGE(Krb5 REQUIRED)