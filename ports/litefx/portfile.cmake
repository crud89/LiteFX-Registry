vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO crud89/litefx
  REF v0.2.1
  SHA512 d185f8378edc604ecd6b3e197bf7af0bf14a474061051ab1757193b8d169bc6b4f1e65df396a4f8f1ea99b69a5c99bbd4ee95a1f4bae2a43f972636fcd32f91e
  HEAD_REF main
  PATCHES "dx12-headers.patch"
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