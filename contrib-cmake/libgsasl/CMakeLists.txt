SET(SRC_DIR ${CONTRIB_SOURCE_DIR}/ClickHouse-libgsasl)

MESSAGE(LIBGSASL_SOURCE_DIR: ${SRC_DIR})

OPTION(USE_KRB5 "Kerberos Library Name")

SET(SRCS
    ${SRC_DIR}/gl/gc-gnulib.c
    ${SRC_DIR}/gl/printf-parse.c
    ${SRC_DIR}/gl/c-ctype.c
    ${SRC_DIR}/gl/float.c
    ${SRC_DIR}/gl/printf-args.c
    ${SRC_DIR}/gl/hmac-sha1.c
    ${SRC_DIR}/gl/itold.c
    ${SRC_DIR}/gl/hmac-md5.c
    ${SRC_DIR}/gl/gc-pbkdf2-sha1.c
    ${SRC_DIR}/gl/md5.c
    ${SRC_DIR}/gl/base64.c
    ${SRC_DIR}/gl/memxor.c
    ${SRC_DIR}/gl/sha1.c
    ${SRC_DIR}/openid20/client.c
    ${SRC_DIR}/openid20/mechinfo.c
    ${SRC_DIR}/openid20/server.c
    ${SRC_DIR}/anonymous/client.c
    ${SRC_DIR}/anonymous/mechinfo.c
    ${SRC_DIR}/anonymous/server.c
    ${SRC_DIR}/saml20/client.c
    ${SRC_DIR}/saml20/mechinfo.c
    ${SRC_DIR}/saml20/server.c
    ${SRC_DIR}/scram/parser.c
    ${SRC_DIR}/scram/printer.c
    ${SRC_DIR}/scram/tokens.c
    ${SRC_DIR}/scram/client.c
    ${SRC_DIR}/scram/mechinfo.c
    ${SRC_DIR}/scram/server.c
    ${SRC_DIR}/scram/validate.c
    ${SRC_DIR}/src/free.c
    ${SRC_DIR}/src/supportp.c
    ${SRC_DIR}/src/init.c
    ${SRC_DIR}/src/mechtools.c
    ${SRC_DIR}/src/error.c
    ${SRC_DIR}/src/property.c
    ${SRC_DIR}/src/done.c
    ${SRC_DIR}/src/callback.c
    ${SRC_DIR}/src/xstart.c
    ${SRC_DIR}/src/xfinish.c
    ${SRC_DIR}/src/version.c
    ${SRC_DIR}/src/xstep.c
    ${SRC_DIR}/src/mechname.c
    ${SRC_DIR}/src/xcode.c
    ${SRC_DIR}/src/crypto.c
    ${SRC_DIR}/src/doxygen.c
    ${SRC_DIR}/src/suggest.c
    ${SRC_DIR}/src/saslprep.c
    ${SRC_DIR}/src/listmech.c
    ${SRC_DIR}/src/register.c
    ${SRC_DIR}/src/base64.c
    ${SRC_DIR}/src/md5pwd.c
    ${SRC_DIR}/external/client.c
    ${SRC_DIR}/external/mechinfo.c
    ${SRC_DIR}/external/server.c
    ${SRC_DIR}/securid/client.c
    ${SRC_DIR}/securid/mechinfo.c
    ${SRC_DIR}/securid/server.c
    ${SRC_DIR}/plain/client.c
    ${SRC_DIR}/plain/mechinfo.c
    ${SRC_DIR}/plain/server.c
    ${SRC_DIR}/cram-md5/client.c
    ${SRC_DIR}/cram-md5/challenge.c
    ${SRC_DIR}/cram-md5/mechinfo.c
    ${SRC_DIR}/cram-md5/server.c
    ${SRC_DIR}/cram-md5/digest.c
    ${SRC_DIR}/digest-md5/client.c
    ${SRC_DIR}/digest-md5/digesthmac.c
    ${SRC_DIR}/digest-md5/free.c
    ${SRC_DIR}/digest-md5/getsubopt.c
    ${SRC_DIR}/digest-md5/mechinfo.c
    ${SRC_DIR}/digest-md5/nonascii.c
    ${SRC_DIR}/digest-md5/parser.c
    ${SRC_DIR}/digest-md5/printer.c
    ${SRC_DIR}/digest-md5/qop.c
    ${SRC_DIR}/digest-md5/server.c
    ${SRC_DIR}/digest-md5/session.c
    ${SRC_DIR}/digest-md5/test-parser.c
    ${SRC_DIR}/digest-md5/validate.c
    ${SRC_DIR}/login/client.c
    ${SRC_DIR}/login/mechinfo.c
    ${SRC_DIR}/login/server.c
)

IF(USE_KRB5)
    SET(SRCS ${SRCS}
        ${SRC_DIR}/gssapi/client.c
        ${SRC_DIR}/gssapi/mechinfo.c
        ${SRC_DIR}/gssapi/server.c
    )
ENDIF()

ADD_LIBRARY(libgsasl STATIC ${SRCS})

TARGET_INCLUDE_DIRECTORIES(libgsasl PUBLIC ${SRC_DIR})
TARGET_INCLUDE_DIRECTORIES(libgsasl PUBLIC ${SRC_DIR}/gl)
TARGET_INCLUDE_DIRECTORIES(libgsasl PUBLIC ${SRC_DIR}/src)
TARGET_INCLUDE_DIRECTORIES(libgsasl PUBLIC ${SRC_DIR}/digest-md5)
TARGET_INCLUDE_DIRECTORIES(libgsasl PUBLIC ${SRC_DIR}/linux_x86_64/include)

IF(USE_KRB5)
    SET(WITH_KRB5 1)
    TARGET_LINK_LIBRARIES(libgsasl PUBLIC ${KRB5_LIBRARY})
ENDIF()

IF(TARGET OpenSSL::SSL)
    TARGET_LINK_LIBRARIES(libgsasl PRIVATE OpenSSL::Crypto OpenSSL::SSL)
ENDIF()

CONFIGURE_FILE(
  ${SRC_DIR}/linux_x86_64/include/config.h.in
  ${CMAKE_CURRENT_LIST_DIR}/config.h
)
TARGET_COMPILE_DEFINITIONS(libgsasl PRIVATE HAVE_CONFIG_H=1)
TARGET_INCLUDE_DIRECTORIES(libgsasl PUBLIC ${CMAKE_CURRENT_LIST_DIR})
