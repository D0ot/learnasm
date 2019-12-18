cmake_minimum_required(VERSION 3.0.0)
project(learnelf VERSION 0.1.0)

set(USER_SOURCE_DIR ${PROJECT_SOURCE_DIR})
set(USER_BUILD_DIR ${PROJECT_SOURCE_DIR}/build )


add_custom_target(elf_obj COMMAND nasm -f elf32 -o ${USER_BUILD_DIR}/elf.o ${PROJECT_SOURCE_DIR}/elf.s)
add_custom_target(elf ALL COMMAND ld -m elf_i386 ${USER_BUILD_DIR}/elf.o -o elf)
add_dependencies(elf elf_obj)

add_custom_target(reader_obj COMMAND nasm -g -f elf32 -o ${USER_BUILD_DIR}/reader.o ${PROJECT_SOURCE_DIR}/reader.s)
add_custom_target(reader ALL COMMAND ld -m elf_i386 ${USER_BUILD_DIR}/reader.o -o reader)
add_dependencies(reader reader_obj)

