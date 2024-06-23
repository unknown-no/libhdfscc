SET(SRC_DIR "${CONTRIB_SOURCE_DIR}/ClickHouse-libhdfs3")

MESSAGE(LIBHDFS3_SOURCE_DIR: ${SRC_DIR})

EXECUTE_PROCESS(
    COMMAND yasm -f x64 -f elf64 -X gnu -g dwarf2 -D LINUX -o ${CMAKE_CURRENT_BINARY_DIR}/crc_iscsi_v_pcl.o ${SRC_DIR}/src/common/crc_iscsi_v_pcl.asm
    COMMAND_ECHO STDOUT
)

# SET(SRCS
#     ${CRC_ISCSI_V_PCL_FILE}
# )

# ADD_LIBRARY(libhdfs3 ${SRCS})