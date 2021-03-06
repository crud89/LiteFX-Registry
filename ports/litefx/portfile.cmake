vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO crud89/litefx
  REF v0.2.2
  SHA512 df9cd5c76e0c9a19f95d751ef1ac8e2975dd7631e7aa25c054352b696ab2123169b9f843cf9a306b0085395dc557fd44098bc6db3c555f6c5531a811800bc9c1
  HEAD_REF main
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