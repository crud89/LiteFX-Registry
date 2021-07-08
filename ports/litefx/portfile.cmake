vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO crud89/litefx
  REF v0.1.1
  SHA512 a682396bb85d1b0b17290146ee3cc9ae11fff6cbd3dc44c08adbbd3684af5c6f5565bc1e5a68e291da4997c9d134b012fedb6f50b003387ced4e87372beb70b3
  HEAD_REF main
  PATCHES build-script.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        dx12    BUILD_DIRECTX_12_BACKEND
        vulkan  BUILD_VULKAN_BACKEND
        glm     BUILD_WITH_GLM
        dx-math BUILD_WITH_DIRECTX_MATH
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}/src
    OPTIONS 
        -DCMAKE_INSTALL_INCLUDEDIR=include/
        -DBUILD_EXAMPLES=OFF
        ${FEATURE_OPTIONS} 
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup(CONFIG_PATH cmake/)

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE "${CURRENT_PACKAGES_DIR}/LICENSE" "${CURRENT_PACKAGES_DIR}/NOTICE" "${CURRENT_PACKAGES_DIR}/debug/LICENSE" "${CURRENT_PACKAGES_DIR}/debug/NOTICE")