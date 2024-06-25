# https://github.com/ClickHouse/libgsasl/pull/6
# https://github.com/ClickHouse/libhdfs3/pull/21
# https://github.com/ClickHouse/libhdfs3/pull/24
# Reverted: https://github.com/ClickHouse/libhdfs3/pull/41

# https://github.com/ClickHouse/ClickHouse/pull/37852
# https://github.com/ClickHouse/ClickHouse/pull/39252

SET(SRC_DIR "${CONTRIB_SOURCE_DIR}/ClickHouse-libhdfs3")

MESSAGE(LIBHDFS3_SOURCE_DIR: ${SRC_DIR})

SET(CRC_ISCSI_V_PCL_FILE ${CMAKE_CURRENT_BINARY_DIR}/crc_iscsi_v_pcl.o)
EXECUTE_PROCESS(
    COMMAND yasm -f x64 -f elf64 -X gnu -g dwarf2 -D LINUX -o ${CRC_ISCSI_V_PCL_FILE} ${SRC_DIR}/src/common/crc_iscsi_v_pcl.asm
    COMMAND_ECHO STDOUT
)

MESSAGE(STATUS "Enable kerberos for HDFS")
SET(WITH_KERBEROS 1)

SET(HDFS3_SOURCE_DIR ${SRC_DIR}/src)

ADD_DEFINITIONS(-DTEST_HDFS_PREFIX="${TEST_HDFS_PREFIX}")
ADD_DEFINITIONS(-D__STDC_FORMAT_MACROS)
ADD_DEFINITIONS(-D_GNU_SOURCE)
ADD_DEFINITIONS(-D_GLIBCXX_USE_NANOSLEEP)
ADD_DEFINITIONS(-DHAVE_NANOSLEEP)

SET(HAVE_STEADY_CLOCK 1)
SET(HAVE_NESTED_EXCEPTION 1)
SET(HAVE_BOOST_CHRONO 0)
SET(HAVE_BOOST_ATOMIC 0)
SET(HAVE_STD_CHRONO 1)
SET(HAVE_STD_ATOMIC 1)

# Proto
SET(PROTO_FILES
    # ${HDFS3_SOURCE_DIR}/proto/encryption.proto
    ${HDFS3_SOURCE_DIR}/proto/ClientDatanodeProtocol.proto
    ${HDFS3_SOURCE_DIR}/proto/hdfs.proto
    ${HDFS3_SOURCE_DIR}/proto/Security.proto
    ${HDFS3_SOURCE_DIR}/proto/ProtobufRpcEngine.proto
    ${HDFS3_SOURCE_DIR}/proto/ClientNamenodeProtocol.proto
    ${HDFS3_SOURCE_DIR}/proto/IpcConnectionContext.proto
    ${HDFS3_SOURCE_DIR}/proto/RpcHeader.proto
    ${HDFS3_SOURCE_DIR}/proto/datatransfer.proto
)

# PROTOBUF_GENERATE_CPP(PROTO_SOURCES PROTO_HEADERS ${PROTO_FILES} APPEND_PATH)

SET(SRCS
    ${CRC_ISCSI_V_PCL_FILE} # TODO: ARCH_AMD64
    ${HDFS3_SOURCE_DIR}/network/TcpSocket.cpp
    ${HDFS3_SOURCE_DIR}/network/DomainSocket.cpp
    ${HDFS3_SOURCE_DIR}/network/BufferedSocketReader.cpp
    ${HDFS3_SOURCE_DIR}/client/DataReader.cpp
    ${HDFS3_SOURCE_DIR}/client/ReadShortCircuitInfo.cpp
    ${HDFS3_SOURCE_DIR}/client/Pipeline.cpp
    ${HDFS3_SOURCE_DIR}/client/Hdfs.cpp
    ${HDFS3_SOURCE_DIR}/client/Packet.cpp
    ${HDFS3_SOURCE_DIR}/client/OutputStreamImpl.cpp
    ${HDFS3_SOURCE_DIR}/client/KerberosName.cpp
    ${HDFS3_SOURCE_DIR}/client/PacketHeader.cpp
    ${HDFS3_SOURCE_DIR}/client/LocalBlockReader.cpp
    ${HDFS3_SOURCE_DIR}/client/UserInfo.cpp
    ${HDFS3_SOURCE_DIR}/client/RemoteBlockReader.cpp
    ${HDFS3_SOURCE_DIR}/client/Permission.cpp
    ${HDFS3_SOURCE_DIR}/client/FileSystemImpl.cpp
    ${HDFS3_SOURCE_DIR}/client/DirectoryIterator.cpp
    ${HDFS3_SOURCE_DIR}/client/FileSystemKey.cpp
    ${HDFS3_SOURCE_DIR}/client/DataTransferProtocolSender.cpp
    ${HDFS3_SOURCE_DIR}/client/LeaseRenewer.cpp
    ${HDFS3_SOURCE_DIR}/client/PeerCache.cpp
    ${HDFS3_SOURCE_DIR}/client/InputStream.cpp
    ${HDFS3_SOURCE_DIR}/client/FileSystem.cpp
    ${HDFS3_SOURCE_DIR}/client/InputStreamImpl.cpp
    ${HDFS3_SOURCE_DIR}/client/Token.cpp
    ${HDFS3_SOURCE_DIR}/client/PacketPool.cpp
    ${HDFS3_SOURCE_DIR}/client/OutputStream.cpp
    ${HDFS3_SOURCE_DIR}/client/AbstractNativeRawDecoder.cpp
    ${HDFS3_SOURCE_DIR}/client/AbstractNativeRawEncoder.cpp
    ${HDFS3_SOURCE_DIR}/client/ByteBufferDecodingState.cpp
    ${HDFS3_SOURCE_DIR}/client/ByteBufferEncodingState.cpp
    ${HDFS3_SOURCE_DIR}/client/CoderUtil.cpp
    ${HDFS3_SOURCE_DIR}/client/ECChunk.cpp
    ${HDFS3_SOURCE_DIR}/client/ErasureCoderOptions.cpp
    ${HDFS3_SOURCE_DIR}/client/GF256.cpp
    ${HDFS3_SOURCE_DIR}/client/GaloisField.cpp
    ${HDFS3_SOURCE_DIR}/client/NativeRSRawDecoder.cpp
    ${HDFS3_SOURCE_DIR}/client/NativeRSRawEncoder.cpp
    ${HDFS3_SOURCE_DIR}/client/Preconditions.cpp
    ${HDFS3_SOURCE_DIR}/client/RSUtil.cpp
    ${HDFS3_SOURCE_DIR}/client/RawErasureCoderFactory.cpp
    ${HDFS3_SOURCE_DIR}/client/RawErasureDecoder.cpp
    ${HDFS3_SOURCE_DIR}/client/RawErasureEncoder.cpp
    ${HDFS3_SOURCE_DIR}/client/StatefulStripeReader.cpp
    ${HDFS3_SOURCE_DIR}/client/StripeReader.cpp
    ${HDFS3_SOURCE_DIR}/client/StripedBlockUtil.cpp
    ${HDFS3_SOURCE_DIR}/client/StripedInputStreamImpl.cpp
    ${HDFS3_SOURCE_DIR}/client/StripedOutputStreamImpl.cpp
    ${HDFS3_SOURCE_DIR}/client/SystemECPolicies.cpp
    ${HDFS3_SOURCE_DIR}/client/dump.cpp
    ${HDFS3_SOURCE_DIR}/client/erasure_coder.cpp
    ${HDFS3_SOURCE_DIR}/rpc/RpcChannelKey.cpp
    ${HDFS3_SOURCE_DIR}/rpc/RpcProtocolInfo.cpp
    ${HDFS3_SOURCE_DIR}/rpc/RpcClient.cpp
    ${HDFS3_SOURCE_DIR}/rpc/RpcRemoteCall.cpp
    ${HDFS3_SOURCE_DIR}/rpc/RpcChannel.cpp
    ${HDFS3_SOURCE_DIR}/rpc/RpcAuth.cpp
    ${HDFS3_SOURCE_DIR}/rpc/RpcContentWrapper.cpp
    ${HDFS3_SOURCE_DIR}/rpc/RpcConfig.cpp
    ${HDFS3_SOURCE_DIR}/rpc/RpcServerInfo.cpp
    ${HDFS3_SOURCE_DIR}/rpc/SaslClient.cpp
    ${HDFS3_SOURCE_DIR}/server/Datanode.cpp
    ${HDFS3_SOURCE_DIR}/server/LocatedBlocks.cpp
    ${HDFS3_SOURCE_DIR}/server/NamenodeProxy.cpp
    ${HDFS3_SOURCE_DIR}/server/NamenodeImpl.cpp
    ${HDFS3_SOURCE_DIR}/server/NamenodeInfo.cpp
    ${HDFS3_SOURCE_DIR}/common/WritableUtils.cpp
    ${HDFS3_SOURCE_DIR}/common/ExceptionInternal.cpp
    ${HDFS3_SOURCE_DIR}/common/SessionConfig.cpp
    ${HDFS3_SOURCE_DIR}/common/StackPrinter.cpp
    ${HDFS3_SOURCE_DIR}/common/Exception.cpp
    ${HDFS3_SOURCE_DIR}/common/Logger.cpp
    ${HDFS3_SOURCE_DIR}/common/CFileWrapper.cpp
    ${HDFS3_SOURCE_DIR}/common/XmlConfig.cpp
    ${HDFS3_SOURCE_DIR}/common/WriteBuffer.cpp
    ${HDFS3_SOURCE_DIR}/common/HWCrc32c.cpp
    ${HDFS3_SOURCE_DIR}/common/MappedFileWrapper.cpp
    ${HDFS3_SOURCE_DIR}/common/Hash.cpp
    ${HDFS3_SOURCE_DIR}/common/SWCrc32c.cpp
    ${HDFS3_SOURCE_DIR}/common/Thread.cpp
    ${HDFS3_SOURCE_DIR}/common/IntelAsmCrc32c.cpp
    ${PROTO_SOURCES}
)

SET_SOURCE_FILES_PROPERTIES(${HDFS3_SOURCE_DIR}/rpc/RpcClient.cpp PROPERTIES COMPILE_FLAGS "-DBOOST_UUID_RANDOM_PROVIDER_FORCE_POSIX=1")

ADD_LIBRARY(libhdfs3
    common.cc
    # ${SRCS}
)
# ADD_DEPENDENCIES(libhdfs3 protoc)

CONFIGURE_FILE(${HDFS3_SOURCE_DIR}/platform.h.in ${CMAKE_CURRENT_LIST_DIR}/platform.h)
TARGET_INCLUDE_DIRECTORIES(libhdfs3 PRIVATE ${CMAKE_CURRENT_LIST_DIR})
TARGET_INCLUDE_DIRECTORIES(libhdfs3 PRIVATE ${HDFS3_SOURCE_DIR})
TARGET_INCLUDE_DIRECTORIES(libhdfs3 PRIVATE ${HDFS3_SOURCE_DIR}/common)
TARGET_INCLUDE_DIRECTORIES(libhdfs3 SYSTEM BEFORE INTERFACE ${HDFS3_SOURCE_DIR}/include)

TARGET_LINK_LIBRARIES(libhdfs3 PRIVATE OpenSSL::Crypto OpenSSL::SSL Krb5::Krb5 libgsasl
# LibXml2::LibXml2
)
# TARGET_LINK_LIBRARIES(libhdfs3 PRIVATE protobuf boost::headers_only)